

#include <inference_engine.hpp>
#include <ext_list.hpp>
#include <samples/common.hpp>

#include <vector>
#include <map>
#include <chrono>
#include <string>
#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>


#ifdef _WIN32
#include <os/windows/w_dirent.h>
#else
#include <dirent.h>
#endif


using namespace InferenceEngine;
using namespace std;
using namespace cv;

ConsoleErrorListener error_listener;



int main() {
    try {
        std::cout << "InferenceEngine: " << GetInferenceEngineVersion() << std::endl;


        /** This vector stores paths to the processed images **/
        std::vector<std::string> imageNames;
        imageNames.push_back("../../1.jpg");
        if (imageNames.empty()){
            std::cout<<"No suitable images were found";
        }
        // -----------------------------------------------------------------------------------------------------

        // --------------------------- 1. Load Plugin for inference engine -------------------------------------
        std::cout << "Loading plugin" << std::endl;

        bool FLAGS_plugin_message =false;
        string FLAGS_plugin_path="";
        string FLAGS_device = "CPU";
        string FLAGS_custom_cpu_library="";
        string FLAGS_custom_cldnn ="";
        bool FLAGS_performance_counter=true;
        string FLAGS_model_xml="../../mnist.xml";
        string FLAGS_model_bin =  "../../mnist.bin";
        unsigned int FLAGS_iterations_count=10;
        unsigned int FLAGS_ntop=10;
        unsigned int FLAGS_infer_num_threads=10;
        unsigned int FLAGS_ninfer_request=1;
        string FLAGS_cpu_threads_pinning="YES";


        InferencePlugin plugin = PluginDispatcher({ FLAGS_plugin_path }).getPluginByDevice(FLAGS_device);
        if (FLAGS_plugin_message) {
            static_cast<InferenceEngine::InferenceEnginePluginPtr>(plugin)->SetLogCallback(error_listener);
        }

        /** Loading default extensions **/
        if (FLAGS_device.find("CPU") != std::string::npos) {
            /**
             * cpu_extensions library is compiled from "extension" folder containing
             * custom MKLDNNPlugin layer implementations. These layers are not supported
             * by mkldnn, but they can be useful for inferring custom topologies.
            **/
            plugin.AddExtension(std::make_shared<Extensions::Cpu::CpuExtensions>());
        }

        if (!FLAGS_custom_cpu_library.empty()) {
            // CPU(MKLDNN) extensions are loaded as a shared library and passed as a pointer to base extension
            IExtensionPtr extension_ptr = make_so_pointer<IExtension>(FLAGS_custom_cpu_library);
            plugin.AddExtension(extension_ptr);
            std::cout << "CPU Extension loaded: " << FLAGS_custom_cpu_library << std::endl;
        }
        if (!FLAGS_custom_cldnn.empty()) {
            // clDNN Extensions are loaded from an .xml description and OpenCL kernel files
            plugin.SetConfig({{PluginConfigParams::KEY_CONFIG_FILE, FLAGS_custom_cldnn}});
            std::cout << "GPU Extension loaded: " << FLAGS_custom_cldnn << std::endl;
        }

        /** Setting plugin parameter for collecting per layer metrics **/
        if (FLAGS_performance_counter) {
            plugin.SetConfig({ { PluginConfigParams::KEY_PERF_COUNT, PluginConfigParams::YES } });
        }

        /** Printing plugin version **/
        printPluginVersion(plugin, std::cout);
        // -----------------------------------------------------------------------------------------------------

        // --------------------------- 2. Read IR Generated by ModelOptimizer (.xml and .bin files) ------------
        std::cout << "Loading network files:"
                "\n\t" << FLAGS_model_xml <<
                "\n\t" << FLAGS_model_bin <<
        std::endl;

        CNNNetReader networkReader;
        /** Reading network model **/
        networkReader.ReadNetwork(FLAGS_model_xml);

        /** Extracting model name and loading weights **/
        networkReader.ReadWeights(FLAGS_model_bin);
        CNNNetwork network = networkReader.getNetwork();
        // -----------------------------------------------------------------------------------------------------

        // --------------------------- 3. Configure input & output ---------------------------------------------

        // --------------------------- Prepare input blobs -----------------------------------------------------
        std::cout << "Preparing input blobs" << std::endl;

        /** Taking information about all topology inputs **/
        InputsDataMap inputInfo = network.getInputsInfo();
        if (inputInfo.size() != 1){ 
            std::cout<<"Sample supports topologies only with 1 input"<<endl;
            return 1;
        }

        auto inputInfoItem = *inputInfo.begin();

        /** Specifying the precision and layout of input data provided by the user.
         * This should be called before load of the network to the plugin **/
        //inputInfoItem.second->setPrecision(Precision::U8);
        inputInfoItem.second->setPrecision(Precision::FP32);
        inputInfoItem.second->setLayout(Layout::NCHW);





        std::vector<cv::Mat> imagesData;
	for (int id=0;id<imageNames.size();id++){
            cv::Mat image = cv::imread(imageNames[id],1);
            image.convertTo(image, CV_32FC3, 1.0/255, -0.5);
            imagesData.push_back(image);
        }


        if (imagesData.empty()){ 
            std::cout<<"Valid input images were not found!"<<endl;
            return 1;
        }

        /** Setting batch size using image count **/
        network.setBatchSize(imagesData.size());
        size_t batchSize = network.getBatchSize();
        std::cout << "Batch size is " << std::to_string(batchSize) << std::endl;

        // ------------------------------ Prepare output blobs -------------------------------------------------
        std::cout << "Preparing output blobs" << std::endl;

        OutputsDataMap outputInfo(network.getOutputsInfo());
        // BlobMap outputBlobs;
        std::string firstOutputName;

        for (auto & item : outputInfo) {
            if (firstOutputName.empty()) {
                firstOutputName = item.first;
            }
            DataPtr outputData = item.second;
            if (!outputData) {
                std::cout<<"output data pointer is not valid";
                return 1;
            }

            item.second->setPrecision(Precision::FP32);
        }

        const SizeVector outputDims = outputInfo.begin()->second->getDims();

        bool outputCorrect = false;
        if (outputDims.size() == 2 /* NC */) {
            outputCorrect = true;
        } else if (outputDims.size() == 4 /* NCHW */) {
            /* H = W = 1 */
            if (outputDims[2] == 1 && outputDims[3] == 1) outputCorrect = true;
        }

        if (!outputCorrect) {
            std::cout<<"Incorrect output dimensions for classification model";
            return 1;
        }
        // -----------------------------------------------------------------------------------------------------

        // --------------------------- 4. Loading model to the plugin ------------------------------------------
        std::cout << "Loading model to the plugin" << std::endl;






        std::map<std::string, std::string> config;
        if (FLAGS_performance_counter)
            config[PluginConfigParams::KEY_PERF_COUNT] = PluginConfigParams::YES;
        if (FLAGS_device.find("CPU") != std::string::npos) {  // CPU supports few special performance-oriented keys
            // limit threading for CPU portion of inference
            config[PluginConfigParams::KEY_CPU_THREADS_NUM] = std::to_string(FLAGS_infer_num_threads);
            // pin threads for CPU portion of inference
            config[PluginConfigParams::KEY_CPU_BIND_THREAD] = FLAGS_cpu_threads_pinning;
            // for pure CPU execution, more throughput-oriented execution via streams
            if (FLAGS_device == "CPU")
                config[PluginConfigParams::KEY_CPU_THROUGHPUT_STREAMS] = std::to_string(FLAGS_ninfer_request);
        }
        ExecutableNetwork executable_network = plugin.LoadNetwork(network, config);





        inputInfoItem.second = {};
        outputInfo = {};
        network = {};
        networkReader = {};
        // -----------------------------------------------------------------------------------------------------

        // --------------------------- 5. Create infer request -------------------------------------------------
        InferRequest infer_request = executable_network.CreateInferRequest();
        // -----------------------------------------------------------------------------------------------------

        // --------------------------- 6. Prepare input --------------------------------------------------------
        /** Iterate over all the input blobs **/
        for (const auto & item : inputInfo) {
            /** Creating input blob **/
            Blob::Ptr input = infer_request.GetBlob(item.first);

            /** Filling input tensor with images. First b channel, then g and r channels **/
            size_t num_channels = input->getTensorDesc().getDims()[1];
            size_t image_size = input->getTensorDesc().getDims()[2] * input->getTensorDesc().getDims()[3];

            //auto data = input->buffer().as<PrecisionTrait<Precision::U8>::value_type*>();
            auto data = input->buffer().as<PrecisionTrait<Precision::FP32>::value_type*>();

            /** Iterate over all input images **/
            for (size_t image_id = 0; image_id < imagesData.size(); ++image_id) {
                /** Iterate over all pixel in image (b,g,r) **/
                for (size_t pid = 0; pid < image_size; pid++) {
                    /** Iterate over all channels **/
                    for (size_t ch = 0; ch < num_channels; ++ch) {
                        /**          [images stride + channels stride + pixel id ] all in bytes            **/
                        data[image_id * image_size * num_channels + ch * image_size + pid ] = imagesData[image_id].at<cv::Vec3f>(pid)[ch];
                    }
                }
            }
        }
        inputInfo = {};
        // -----------------------------------------------------------------------------------------------------

        // --------------------------- 7. Do inference ---------------------------------------------------------
        std::cout << "Starting inference (" << FLAGS_iterations_count << " iterations)" << std::endl;

        typedef std::chrono::high_resolution_clock Time;
        typedef std::chrono::duration<double, std::ratio<1, 1000>> ms;
        typedef std::chrono::duration<float> fsec;

        double total = 0.0;
        /** Start inference & calc performance **/
        for (size_t iter = 0; iter < FLAGS_iterations_count; ++iter) {
            auto t0 = Time::now();
            infer_request.Infer();
            auto t1 = Time::now();
            fsec fs = t1 - t0;
            ms d = std::chrono::duration_cast<ms>(fs);
            total += d.count();
        }
        // -----------------------------------------------------------------------------------------------------

        // --------------------------- 8. Process output -------------------------------------------------------
        std::cout << "Processing output blobs" << std::endl;

        const Blob::Ptr output_blob = infer_request.GetBlob(firstOutputName);

        /** Validating -nt value **/
        const size_t resultsCnt = output_blob->size() / batchSize;
        if (FLAGS_ntop > resultsCnt || FLAGS_ntop < 1) {
            std::cout << "-nt " << FLAGS_ntop << " is not available for this network (-nt should be less than " \
                      << resultsCnt+1 << " and more than 0)\n            will be used maximal value : " << resultsCnt;
            FLAGS_ntop = resultsCnt;
        }



        std::vector<float> results;
        cout<<"classid"<<"    "<<"probability"<<"    "<<"label"<<endl;
        cout<<"-------    -----------    -----"<<endl;
        for (unsigned int image_id = 0; image_id < batchSize; ++image_id) {
            for (size_t id = image_id * FLAGS_ntop; id < (image_id + 1) * FLAGS_ntop; ++id) {
                float result = output_blob->buffer().as<InferenceEngine::PrecisionTrait<InferenceEngine::Precision::FP32>::value_type*>()[id+image_id*resultsCnt];
                results.push_back(result);
                cout<<id<<"              "<<result<<"            "<<id<<endl;
            }
        }



        // -----------------------------------------------------------------------------------------------------
        if (std::fabs(total) < std::numeric_limits<double>::epsilon()) {
            std::cout<<"total can't be equal to zero"<<endl;
            return 1;
        }
        std::cout << std::endl << "total inference time: " << total << std::endl;
        std::cout << "Average running time of one iteration: " << total / static_cast<double>(FLAGS_iterations_count) << " ms" << std::endl;
        std::cout << std::endl << "Throughput: " << 1000 * static_cast<double>(FLAGS_iterations_count) * batchSize / total << " FPS" << std::endl;
        std::cout << std::endl;

        /** Show performance results **/
        if (FLAGS_performance_counter) {
            printPerformanceCounts(infer_request, std::cout);
        }
    }
    catch (const std::exception& error) {
        std::cout << "" << error.what() << std::endl;
        return 1;
    }
    catch (...) {
        std::cout << "Unknown/internal exception happened." << std::endl;
        return 1;
    }

    std::cout << "Execution successful" << std::endl;
    return 0;
}
