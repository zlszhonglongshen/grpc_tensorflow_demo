æę
Į
9
Add
x"T
y"T
z"T"
Ttype:
2	

ArgMax

input"T
	dimension"Tidx
output"output_type"
Ttype:
2	"
Tidxtype0:
2	"
output_typetype0	:
2	
x
Assign
ref"T

value"T

output_ref"T"	
Ttype"
validate_shapebool("
use_lockingbool(
{
BiasAdd

value"T	
bias"T
output"T"
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
8
Const
output"dtype"
valuetensor"
dtypetype
Č
Conv2D

input"T
filter"T
output"T"
Ttype:
2"
strides	list(int)"
use_cudnn_on_gpubool(""
paddingstring:
SAMEVALID"-
data_formatstringNHWC:
NHWCNCHW
.
Identity

input"T
output"T"	
Ttype
o
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:

2

Max

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( "
Ttype:
2	"
Tidxtype0:
2	
Ó
MaxPool

input"T
output"T"
Ttype0:
2
	"
ksize	list(int)(0"
strides	list(int)(0""
paddingstring:
SAMEVALID":
data_formatstringNHWC:
NHWCNCHWNCHW_VECT_C
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(
<
Mul
x"T
y"T
z"T"
Ttype:
2	

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
}
RandomUniform

shape"T
output"dtype"
seedint "
seed2int "
dtypetype:
2"
Ttype:
2	
A
Relu
features"T
activations"T"
Ttype:
2		
[
Reshape
tensor"T
shape"Tshape
output"T"	
Ttype"
Tshapetype0:
2	
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
H
ShardedFilename
basename	
shard

num_shards
filename
8
Softmax
logits"T
softmax"T"
Ttype:
2
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
9
Sub
x"T
y"T
z"T"
Ttype:
2	
s

VariableV2
ref"dtype"
shapeshape"
dtypetype"
	containerstring "
shared_namestring "serve*1.4.02v1.4.0-rc1-11-g130a514ŪĆ
x
inputPlaceholder*
dtype0*/
_output_shapes
:’’’’’’’’’*$
shape:’’’’’’’’’
©
.conv2d/kernel/Initializer/random_uniform/shapeConst* 
_class
loc:@conv2d/kernel*%
valueB"         @   *
dtype0*
_output_shapes
:

,conv2d/kernel/Initializer/random_uniform/minConst*
dtype0*
_output_shapes
: * 
_class
loc:@conv2d/kernel*
valueB
 *8JĢ½

,conv2d/kernel/Initializer/random_uniform/maxConst* 
_class
loc:@conv2d/kernel*
valueB
 *8JĢ=*
dtype0*
_output_shapes
: 
š
6conv2d/kernel/Initializer/random_uniform/RandomUniformRandomUniform.conv2d/kernel/Initializer/random_uniform/shape*
T0* 
_class
loc:@conv2d/kernel*
seed2 *
dtype0*&
_output_shapes
:@*

seed 
Ņ
,conv2d/kernel/Initializer/random_uniform/subSub,conv2d/kernel/Initializer/random_uniform/max,conv2d/kernel/Initializer/random_uniform/min*
_output_shapes
: *
T0* 
_class
loc:@conv2d/kernel
ģ
,conv2d/kernel/Initializer/random_uniform/mulMul6conv2d/kernel/Initializer/random_uniform/RandomUniform,conv2d/kernel/Initializer/random_uniform/sub*&
_output_shapes
:@*
T0* 
_class
loc:@conv2d/kernel
Ž
(conv2d/kernel/Initializer/random_uniformAdd,conv2d/kernel/Initializer/random_uniform/mul,conv2d/kernel/Initializer/random_uniform/min*&
_output_shapes
:@*
T0* 
_class
loc:@conv2d/kernel
³
conv2d/kernel
VariableV2*
dtype0*&
_output_shapes
:@*
shared_name * 
_class
loc:@conv2d/kernel*
	container *
shape:@
Ó
conv2d/kernel/AssignAssignconv2d/kernel(conv2d/kernel/Initializer/random_uniform*
use_locking(*
T0* 
_class
loc:@conv2d/kernel*
validate_shape(*&
_output_shapes
:@

conv2d/kernel/readIdentityconv2d/kernel*
T0* 
_class
loc:@conv2d/kernel*&
_output_shapes
:@

conv2d/bias/Initializer/zerosConst*
dtype0*
_output_shapes
:@*
_class
loc:@conv2d/bias*
valueB@*    

conv2d/bias
VariableV2*
dtype0*
_output_shapes
:@*
shared_name *
_class
loc:@conv2d/bias*
	container *
shape:@
¶
conv2d/bias/AssignAssignconv2d/biasconv2d/bias/Initializer/zeros*
use_locking(*
T0*
_class
loc:@conv2d/bias*
validate_shape(*
_output_shapes
:@
n
conv2d/bias/readIdentityconv2d/bias*
T0*
_class
loc:@conv2d/bias*
_output_shapes
:@
e
conv2d/dilation_rateConst*
valueB"      *
dtype0*
_output_shapes
:
Ć
conv2d/Conv2DConv2Dinputconv2d/kernel/read*
T0*
strides
*
data_formatNHWC*
use_cudnn_on_gpu(*
paddingSAME*/
_output_shapes
:’’’’’’’’’@

conv2d/BiasAddBiasAddconv2d/Conv2Dconv2d/bias/read*
data_formatNHWC*/
_output_shapes
:’’’’’’’’’@*
T0
½
max_pooling2d/MaxPoolMaxPoolconv2d/BiasAdd*
T0*
strides
*
data_formatNHWC*
ksize
*
paddingVALID*/
_output_shapes
:’’’’’’’’’@
­
0conv2d_1/kernel/Initializer/random_uniform/shapeConst*
dtype0*
_output_shapes
:*"
_class
loc:@conv2d_1/kernel*%
valueB"      @      

.conv2d_1/kernel/Initializer/random_uniform/minConst*
dtype0*
_output_shapes
: *"
_class
loc:@conv2d_1/kernel*
valueB
 *ļ[q½

.conv2d_1/kernel/Initializer/random_uniform/maxConst*
dtype0*
_output_shapes
: *"
_class
loc:@conv2d_1/kernel*
valueB
 *ļ[q=
÷
8conv2d_1/kernel/Initializer/random_uniform/RandomUniformRandomUniform0conv2d_1/kernel/Initializer/random_uniform/shape*
dtype0*'
_output_shapes
:@*

seed *
T0*"
_class
loc:@conv2d_1/kernel*
seed2 
Ś
.conv2d_1/kernel/Initializer/random_uniform/subSub.conv2d_1/kernel/Initializer/random_uniform/max.conv2d_1/kernel/Initializer/random_uniform/min*
_output_shapes
: *
T0*"
_class
loc:@conv2d_1/kernel
õ
.conv2d_1/kernel/Initializer/random_uniform/mulMul8conv2d_1/kernel/Initializer/random_uniform/RandomUniform.conv2d_1/kernel/Initializer/random_uniform/sub*'
_output_shapes
:@*
T0*"
_class
loc:@conv2d_1/kernel
ē
*conv2d_1/kernel/Initializer/random_uniformAdd.conv2d_1/kernel/Initializer/random_uniform/mul.conv2d_1/kernel/Initializer/random_uniform/min*
T0*"
_class
loc:@conv2d_1/kernel*'
_output_shapes
:@
¹
conv2d_1/kernel
VariableV2*
shared_name *"
_class
loc:@conv2d_1/kernel*
	container *
shape:@*
dtype0*'
_output_shapes
:@
Ü
conv2d_1/kernel/AssignAssignconv2d_1/kernel*conv2d_1/kernel/Initializer/random_uniform*
validate_shape(*'
_output_shapes
:@*
use_locking(*
T0*"
_class
loc:@conv2d_1/kernel

conv2d_1/kernel/readIdentityconv2d_1/kernel*
T0*"
_class
loc:@conv2d_1/kernel*'
_output_shapes
:@

conv2d_1/bias/Initializer/zerosConst*
dtype0*
_output_shapes	
:* 
_class
loc:@conv2d_1/bias*
valueB*    

conv2d_1/bias
VariableV2*
shared_name * 
_class
loc:@conv2d_1/bias*
	container *
shape:*
dtype0*
_output_shapes	
:
æ
conv2d_1/bias/AssignAssignconv2d_1/biasconv2d_1/bias/Initializer/zeros*
use_locking(*
T0* 
_class
loc:@conv2d_1/bias*
validate_shape(*
_output_shapes	
:
u
conv2d_1/bias/readIdentityconv2d_1/bias*
_output_shapes	
:*
T0* 
_class
loc:@conv2d_1/bias
g
conv2d_2/dilation_rateConst*
dtype0*
_output_shapes
:*
valueB"      
Ų
conv2d_2/Conv2DConv2Dmax_pooling2d/MaxPoolconv2d_1/kernel/read*
strides
*
data_formatNHWC*
use_cudnn_on_gpu(*
paddingSAME*0
_output_shapes
:’’’’’’’’’*
T0

conv2d_2/BiasAddBiasAddconv2d_2/Conv2Dconv2d_1/bias/read*
data_formatNHWC*0
_output_shapes
:’’’’’’’’’*
T0
Ā
max_pooling2d_2/MaxPoolMaxPoolconv2d_2/BiasAdd*0
_output_shapes
:’’’’’’’’’*
T0*
strides
*
data_formatNHWC*
ksize
*
paddingVALID
^
Reshape/shapeConst*
valueB"’’’’  *
dtype0*
_output_shapes
:
{
ReshapeReshapemax_pooling2d_2/MaxPoolReshape/shape*(
_output_shapes
:’’’’’’’’’1*
T0*
Tshape0

-dense/kernel/Initializer/random_uniform/shapeConst*
_class
loc:@dense/kernel*
valueB"  ō  *
dtype0*
_output_shapes
:

+dense/kernel/Initializer/random_uniform/minConst*
_class
loc:@dense/kernel*
valueB
 *Y×ó¼*
dtype0*
_output_shapes
: 

+dense/kernel/Initializer/random_uniform/maxConst*
_class
loc:@dense/kernel*
valueB
 *Y×ó<*
dtype0*
_output_shapes
: 
ē
5dense/kernel/Initializer/random_uniform/RandomUniformRandomUniform-dense/kernel/Initializer/random_uniform/shape*
T0*
_class
loc:@dense/kernel*
seed2 *
dtype0* 
_output_shapes
:
1ō*

seed 
Ī
+dense/kernel/Initializer/random_uniform/subSub+dense/kernel/Initializer/random_uniform/max+dense/kernel/Initializer/random_uniform/min*
T0*
_class
loc:@dense/kernel*
_output_shapes
: 
ā
+dense/kernel/Initializer/random_uniform/mulMul5dense/kernel/Initializer/random_uniform/RandomUniform+dense/kernel/Initializer/random_uniform/sub* 
_output_shapes
:
1ō*
T0*
_class
loc:@dense/kernel
Ō
'dense/kernel/Initializer/random_uniformAdd+dense/kernel/Initializer/random_uniform/mul+dense/kernel/Initializer/random_uniform/min*
T0*
_class
loc:@dense/kernel* 
_output_shapes
:
1ō
„
dense/kernel
VariableV2*
dtype0* 
_output_shapes
:
1ō*
shared_name *
_class
loc:@dense/kernel*
	container *
shape:
1ō
É
dense/kernel/AssignAssigndense/kernel'dense/kernel/Initializer/random_uniform*
use_locking(*
T0*
_class
loc:@dense/kernel*
validate_shape(* 
_output_shapes
:
1ō
w
dense/kernel/readIdentitydense/kernel* 
_output_shapes
:
1ō*
T0*
_class
loc:@dense/kernel

dense/bias/Initializer/zerosConst*
dtype0*
_output_shapes	
:ō*
_class
loc:@dense/bias*
valueBō*    


dense/bias
VariableV2*
dtype0*
_output_shapes	
:ō*
shared_name *
_class
loc:@dense/bias*
	container *
shape:ō
³
dense/bias/AssignAssign
dense/biasdense/bias/Initializer/zeros*
validate_shape(*
_output_shapes	
:ō*
use_locking(*
T0*
_class
loc:@dense/bias
l
dense/bias/readIdentity
dense/bias*
T0*
_class
loc:@dense/bias*
_output_shapes	
:ō

dense/MatMulMatMulReshapedense/kernel/read*
T0*(
_output_shapes
:’’’’’’’’’ō*
transpose_a( *
transpose_b( 

dense/BiasAddBiasAdddense/MatMuldense/bias/read*
T0*
data_formatNHWC*(
_output_shapes
:’’’’’’’’’ō
T

dense/ReluReludense/BiasAdd*
T0*(
_output_shapes
:’’’’’’’’’ō
£
/dense_1/kernel/Initializer/random_uniform/shapeConst*!
_class
loc:@dense_1/kernel*
valueB"ō  
   *
dtype0*
_output_shapes
:

-dense_1/kernel/Initializer/random_uniform/minConst*!
_class
loc:@dense_1/kernel*
valueB
 *#Ž½*
dtype0*
_output_shapes
: 

-dense_1/kernel/Initializer/random_uniform/maxConst*!
_class
loc:@dense_1/kernel*
valueB
 *#Ž=*
dtype0*
_output_shapes
: 
ģ
7dense_1/kernel/Initializer/random_uniform/RandomUniformRandomUniform/dense_1/kernel/Initializer/random_uniform/shape*
T0*!
_class
loc:@dense_1/kernel*
seed2 *
dtype0*
_output_shapes
:	ō
*

seed 
Ö
-dense_1/kernel/Initializer/random_uniform/subSub-dense_1/kernel/Initializer/random_uniform/max-dense_1/kernel/Initializer/random_uniform/min*
_output_shapes
: *
T0*!
_class
loc:@dense_1/kernel
é
-dense_1/kernel/Initializer/random_uniform/mulMul7dense_1/kernel/Initializer/random_uniform/RandomUniform-dense_1/kernel/Initializer/random_uniform/sub*
T0*!
_class
loc:@dense_1/kernel*
_output_shapes
:	ō

Ū
)dense_1/kernel/Initializer/random_uniformAdd-dense_1/kernel/Initializer/random_uniform/mul-dense_1/kernel/Initializer/random_uniform/min*
_output_shapes
:	ō
*
T0*!
_class
loc:@dense_1/kernel
§
dense_1/kernel
VariableV2*
dtype0*
_output_shapes
:	ō
*
shared_name *!
_class
loc:@dense_1/kernel*
	container *
shape:	ō

Š
dense_1/kernel/AssignAssigndense_1/kernel)dense_1/kernel/Initializer/random_uniform*
use_locking(*
T0*!
_class
loc:@dense_1/kernel*
validate_shape(*
_output_shapes
:	ō

|
dense_1/kernel/readIdentitydense_1/kernel*
T0*!
_class
loc:@dense_1/kernel*
_output_shapes
:	ō


dense_1/bias/Initializer/zerosConst*
_class
loc:@dense_1/bias*
valueB
*    *
dtype0*
_output_shapes
:


dense_1/bias
VariableV2*
	container *
shape:
*
dtype0*
_output_shapes
:
*
shared_name *
_class
loc:@dense_1/bias
ŗ
dense_1/bias/AssignAssigndense_1/biasdense_1/bias/Initializer/zeros*
use_locking(*
T0*
_class
loc:@dense_1/bias*
validate_shape(*
_output_shapes
:

q
dense_1/bias/readIdentitydense_1/bias*
_output_shapes
:
*
T0*
_class
loc:@dense_1/bias

dense_2/MatMulMatMul
dense/Reludense_1/kernel/read*
T0*'
_output_shapes
:’’’’’’’’’
*
transpose_a( *
transpose_b( 

dense_2/BiasAddBiasAdddense_2/MatMuldense_1/bias/read*
T0*
data_formatNHWC*'
_output_shapes
:’’’’’’’’’

W
dense_2/ReluReludense_2/BiasAdd*
T0*'
_output_shapes
:’’’’’’’’’

Q
outputSoftmaxdense_2/Relu*'
_output_shapes
:’’’’’’’’’
*
T0
V
prediction/dimensionConst*
dtype0*
_output_shapes
: *
value	B :


predictionArgMaxoutputprediction/dimension*
output_type0	*#
_output_shapes
:’’’’’’’’’*

Tidx0*
T0
V
ConstConst*
valueB"       *
dtype0*
_output_shapes
:
_
probabilityMaxoutputConst*
T0*
_output_shapes
: *

Tidx0*
	keep_dims( 
Ą
initNoOp^conv2d/kernel/Assign^conv2d/bias/Assign^conv2d_1/kernel/Assign^conv2d_1/bias/Assign^dense/kernel/Assign^dense/bias/Assign^dense_1/kernel/Assign^dense_1/bias/Assign
P

save/ConstConst*
valueB Bmodel*
dtype0*
_output_shapes
: 
Ō
save/SaveV2/tensor_namesConst*
dtype0*
_output_shapes
:*
value~B|Bconv2d/biasBconv2d/kernelBconv2d_1/biasBconv2d_1/kernelB
dense/biasBdense/kernelBdense_1/biasBdense_1/kernel
s
save/SaveV2/shape_and_slicesConst*
dtype0*
_output_shapes
:*#
valueBB B B B B B B B 
å
save/SaveV2SaveV2
save/Constsave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesconv2d/biasconv2d/kernelconv2d_1/biasconv2d_1/kernel
dense/biasdense/kerneldense_1/biasdense_1/kernel*
dtypes

2
}
save/control_dependencyIdentity
save/Const^save/SaveV2*
_output_shapes
: *
T0*
_class
loc:@save/Const
o
save/RestoreV2/tensor_namesConst*
dtype0*
_output_shapes
:* 
valueBBconv2d/bias
h
save/RestoreV2/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices*
_output_shapes
:*
dtypes
2
 
save/AssignAssignconv2d/biassave/RestoreV2*
use_locking(*
T0*
_class
loc:@conv2d/bias*
validate_shape(*
_output_shapes
:@
s
save/RestoreV2_1/tensor_namesConst*
dtype0*
_output_shapes
:*"
valueBBconv2d/kernel
j
!save/RestoreV2_1/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2_1	RestoreV2
save/Constsave/RestoreV2_1/tensor_names!save/RestoreV2_1/shape_and_slices*
_output_shapes
:*
dtypes
2
“
save/Assign_1Assignconv2d/kernelsave/RestoreV2_1*
validate_shape(*&
_output_shapes
:@*
use_locking(*
T0* 
_class
loc:@conv2d/kernel
s
save/RestoreV2_2/tensor_namesConst*
dtype0*
_output_shapes
:*"
valueBBconv2d_1/bias
j
!save/RestoreV2_2/shape_and_slicesConst*
dtype0*
_output_shapes
:*
valueB
B 

save/RestoreV2_2	RestoreV2
save/Constsave/RestoreV2_2/tensor_names!save/RestoreV2_2/shape_and_slices*
_output_shapes
:*
dtypes
2
©
save/Assign_2Assignconv2d_1/biassave/RestoreV2_2*
use_locking(*
T0* 
_class
loc:@conv2d_1/bias*
validate_shape(*
_output_shapes	
:
u
save/RestoreV2_3/tensor_namesConst*
dtype0*
_output_shapes
:*$
valueBBconv2d_1/kernel
j
!save/RestoreV2_3/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2_3	RestoreV2
save/Constsave/RestoreV2_3/tensor_names!save/RestoreV2_3/shape_and_slices*
_output_shapes
:*
dtypes
2
¹
save/Assign_3Assignconv2d_1/kernelsave/RestoreV2_3*
use_locking(*
T0*"
_class
loc:@conv2d_1/kernel*
validate_shape(*'
_output_shapes
:@
p
save/RestoreV2_4/tensor_namesConst*
valueBB
dense/bias*
dtype0*
_output_shapes
:
j
!save/RestoreV2_4/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2_4	RestoreV2
save/Constsave/RestoreV2_4/tensor_names!save/RestoreV2_4/shape_and_slices*
_output_shapes
:*
dtypes
2
£
save/Assign_4Assign
dense/biassave/RestoreV2_4*
validate_shape(*
_output_shapes	
:ō*
use_locking(*
T0*
_class
loc:@dense/bias
r
save/RestoreV2_5/tensor_namesConst*!
valueBBdense/kernel*
dtype0*
_output_shapes
:
j
!save/RestoreV2_5/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2_5	RestoreV2
save/Constsave/RestoreV2_5/tensor_names!save/RestoreV2_5/shape_and_slices*
_output_shapes
:*
dtypes
2
¬
save/Assign_5Assigndense/kernelsave/RestoreV2_5*
validate_shape(* 
_output_shapes
:
1ō*
use_locking(*
T0*
_class
loc:@dense/kernel
r
save/RestoreV2_6/tensor_namesConst*
dtype0*
_output_shapes
:*!
valueBBdense_1/bias
j
!save/RestoreV2_6/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2_6	RestoreV2
save/Constsave/RestoreV2_6/tensor_names!save/RestoreV2_6/shape_and_slices*
_output_shapes
:*
dtypes
2
¦
save/Assign_6Assigndense_1/biassave/RestoreV2_6*
use_locking(*
T0*
_class
loc:@dense_1/bias*
validate_shape(*
_output_shapes
:

t
save/RestoreV2_7/tensor_namesConst*#
valueBBdense_1/kernel*
dtype0*
_output_shapes
:
j
!save/RestoreV2_7/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save/RestoreV2_7	RestoreV2
save/Constsave/RestoreV2_7/tensor_names!save/RestoreV2_7/shape_and_slices*
_output_shapes
:*
dtypes
2
Æ
save/Assign_7Assigndense_1/kernelsave/RestoreV2_7*
validate_shape(*
_output_shapes
:	ō
*
use_locking(*
T0*!
_class
loc:@dense_1/kernel

save/restore_allNoOp^save/Assign^save/Assign_1^save/Assign_2^save/Assign_3^save/Assign_4^save/Assign_5^save/Assign_6^save/Assign_7

init_all_tablesNoOp
R
save_1/ConstConst*
dtype0*
_output_shapes
: *
valueB Bmodel

save_1/StringJoin/inputs_1Const*<
value3B1 B+_temp_a51a5e64c3ff4e8f81dd7a96c7b0ff7e/part*
dtype0*
_output_shapes
: 
{
save_1/StringJoin
StringJoinsave_1/Constsave_1/StringJoin/inputs_1*
N*
_output_shapes
: *
	separator 
S
save_1/num_shardsConst*
dtype0*
_output_shapes
: *
value	B :
^
save_1/ShardedFilename/shardConst*
dtype0*
_output_shapes
: *
value	B : 

save_1/ShardedFilenameShardedFilenamesave_1/StringJoinsave_1/ShardedFilename/shardsave_1/num_shards*
_output_shapes
: 
Ö
save_1/SaveV2/tensor_namesConst*
value~B|Bconv2d/biasBconv2d/kernelBconv2d_1/biasBconv2d_1/kernelB
dense/biasBdense/kernelBdense_1/biasBdense_1/kernel*
dtype0*
_output_shapes
:
u
save_1/SaveV2/shape_and_slicesConst*#
valueBB B B B B B B B *
dtype0*
_output_shapes
:
÷
save_1/SaveV2SaveV2save_1/ShardedFilenamesave_1/SaveV2/tensor_namessave_1/SaveV2/shape_and_slicesconv2d/biasconv2d/kernelconv2d_1/biasconv2d_1/kernel
dense/biasdense/kerneldense_1/biasdense_1/kernel*
dtypes

2

save_1/control_dependencyIdentitysave_1/ShardedFilename^save_1/SaveV2*
T0*)
_class
loc:@save_1/ShardedFilename*
_output_shapes
: 
£
-save_1/MergeV2Checkpoints/checkpoint_prefixesPacksave_1/ShardedFilename^save_1/control_dependency*
T0*

axis *
N*
_output_shapes
:

save_1/MergeV2CheckpointsMergeV2Checkpoints-save_1/MergeV2Checkpoints/checkpoint_prefixessave_1/Const*
delete_old_dirs(

save_1/IdentityIdentitysave_1/Const^save_1/control_dependency^save_1/MergeV2Checkpoints*
_output_shapes
: *
T0
q
save_1/RestoreV2/tensor_namesConst*
dtype0*
_output_shapes
:* 
valueBBconv2d/bias
j
!save_1/RestoreV2/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save_1/RestoreV2	RestoreV2save_1/Constsave_1/RestoreV2/tensor_names!save_1/RestoreV2/shape_and_slices*
_output_shapes
:*
dtypes
2
¤
save_1/AssignAssignconv2d/biassave_1/RestoreV2*
use_locking(*
T0*
_class
loc:@conv2d/bias*
validate_shape(*
_output_shapes
:@
u
save_1/RestoreV2_1/tensor_namesConst*"
valueBBconv2d/kernel*
dtype0*
_output_shapes
:
l
#save_1/RestoreV2_1/shape_and_slicesConst*
dtype0*
_output_shapes
:*
valueB
B 

save_1/RestoreV2_1	RestoreV2save_1/Constsave_1/RestoreV2_1/tensor_names#save_1/RestoreV2_1/shape_and_slices*
_output_shapes
:*
dtypes
2
ø
save_1/Assign_1Assignconv2d/kernelsave_1/RestoreV2_1*
validate_shape(*&
_output_shapes
:@*
use_locking(*
T0* 
_class
loc:@conv2d/kernel
u
save_1/RestoreV2_2/tensor_namesConst*
dtype0*
_output_shapes
:*"
valueBBconv2d_1/bias
l
#save_1/RestoreV2_2/shape_and_slicesConst*
dtype0*
_output_shapes
:*
valueB
B 

save_1/RestoreV2_2	RestoreV2save_1/Constsave_1/RestoreV2_2/tensor_names#save_1/RestoreV2_2/shape_and_slices*
_output_shapes
:*
dtypes
2
­
save_1/Assign_2Assignconv2d_1/biassave_1/RestoreV2_2*
validate_shape(*
_output_shapes	
:*
use_locking(*
T0* 
_class
loc:@conv2d_1/bias
w
save_1/RestoreV2_3/tensor_namesConst*
dtype0*
_output_shapes
:*$
valueBBconv2d_1/kernel
l
#save_1/RestoreV2_3/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save_1/RestoreV2_3	RestoreV2save_1/Constsave_1/RestoreV2_3/tensor_names#save_1/RestoreV2_3/shape_and_slices*
_output_shapes
:*
dtypes
2
½
save_1/Assign_3Assignconv2d_1/kernelsave_1/RestoreV2_3*
validate_shape(*'
_output_shapes
:@*
use_locking(*
T0*"
_class
loc:@conv2d_1/kernel
r
save_1/RestoreV2_4/tensor_namesConst*
dtype0*
_output_shapes
:*
valueBB
dense/bias
l
#save_1/RestoreV2_4/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save_1/RestoreV2_4	RestoreV2save_1/Constsave_1/RestoreV2_4/tensor_names#save_1/RestoreV2_4/shape_and_slices*
_output_shapes
:*
dtypes
2
§
save_1/Assign_4Assign
dense/biassave_1/RestoreV2_4*
use_locking(*
T0*
_class
loc:@dense/bias*
validate_shape(*
_output_shapes	
:ō
t
save_1/RestoreV2_5/tensor_namesConst*
dtype0*
_output_shapes
:*!
valueBBdense/kernel
l
#save_1/RestoreV2_5/shape_and_slicesConst*
dtype0*
_output_shapes
:*
valueB
B 

save_1/RestoreV2_5	RestoreV2save_1/Constsave_1/RestoreV2_5/tensor_names#save_1/RestoreV2_5/shape_and_slices*
_output_shapes
:*
dtypes
2
°
save_1/Assign_5Assigndense/kernelsave_1/RestoreV2_5*
use_locking(*
T0*
_class
loc:@dense/kernel*
validate_shape(* 
_output_shapes
:
1ō
t
save_1/RestoreV2_6/tensor_namesConst*!
valueBBdense_1/bias*
dtype0*
_output_shapes
:
l
#save_1/RestoreV2_6/shape_and_slicesConst*
dtype0*
_output_shapes
:*
valueB
B 

save_1/RestoreV2_6	RestoreV2save_1/Constsave_1/RestoreV2_6/tensor_names#save_1/RestoreV2_6/shape_and_slices*
_output_shapes
:*
dtypes
2
Ŗ
save_1/Assign_6Assigndense_1/biassave_1/RestoreV2_6*
use_locking(*
T0*
_class
loc:@dense_1/bias*
validate_shape(*
_output_shapes
:

v
save_1/RestoreV2_7/tensor_namesConst*
dtype0*
_output_shapes
:*#
valueBBdense_1/kernel
l
#save_1/RestoreV2_7/shape_and_slicesConst*
dtype0*
_output_shapes
:*
valueB
B 

save_1/RestoreV2_7	RestoreV2save_1/Constsave_1/RestoreV2_7/tensor_names#save_1/RestoreV2_7/shape_and_slices*
_output_shapes
:*
dtypes
2
³
save_1/Assign_7Assigndense_1/kernelsave_1/RestoreV2_7*
validate_shape(*
_output_shapes
:	ō
*
use_locking(*
T0*!
_class
loc:@dense_1/kernel
Ŗ
save_1/restore_shardNoOp^save_1/Assign^save_1/Assign_1^save_1/Assign_2^save_1/Assign_3^save_1/Assign_4^save_1/Assign_5^save_1/Assign_6^save_1/Assign_7
1
save_1/restore_allNoOp^save_1/restore_shard"B
save_1/Const:0save_1/Identity:0save_1/restore_all (5 @F8"æ
trainable_variables§¤
i
conv2d/kernel:0conv2d/kernel/Assignconv2d/kernel/read:02*conv2d/kernel/Initializer/random_uniform:0
X
conv2d/bias:0conv2d/bias/Assignconv2d/bias/read:02conv2d/bias/Initializer/zeros:0
q
conv2d_1/kernel:0conv2d_1/kernel/Assignconv2d_1/kernel/read:02,conv2d_1/kernel/Initializer/random_uniform:0
`
conv2d_1/bias:0conv2d_1/bias/Assignconv2d_1/bias/read:02!conv2d_1/bias/Initializer/zeros:0
e
dense/kernel:0dense/kernel/Assigndense/kernel/read:02)dense/kernel/Initializer/random_uniform:0
T
dense/bias:0dense/bias/Assigndense/bias/read:02dense/bias/Initializer/zeros:0
m
dense_1/kernel:0dense_1/kernel/Assigndense_1/kernel/read:02+dense_1/kernel/Initializer/random_uniform:0
\
dense_1/bias:0dense_1/bias/Assigndense_1/bias/read:02 dense_1/bias/Initializer/zeros:0"*
saved_model_main_op

init_all_tables"µ
	variables§¤
i
conv2d/kernel:0conv2d/kernel/Assignconv2d/kernel/read:02*conv2d/kernel/Initializer/random_uniform:0
X
conv2d/bias:0conv2d/bias/Assignconv2d/bias/read:02conv2d/bias/Initializer/zeros:0
q
conv2d_1/kernel:0conv2d_1/kernel/Assignconv2d_1/kernel/read:02,conv2d_1/kernel/Initializer/random_uniform:0
`
conv2d_1/bias:0conv2d_1/bias/Assignconv2d_1/bias/read:02!conv2d_1/bias/Initializer/zeros:0
e
dense/kernel:0dense/kernel/Assigndense/kernel/read:02)dense/kernel/Initializer/random_uniform:0
T
dense/bias:0dense/bias/Assigndense/bias/read:02dense/bias/Initializer/zeros:0
m
dense_1/kernel:0dense_1/kernel/Assigndense_1/kernel/read:02+dense_1/kernel/Initializer/random_uniform:0
\
dense_1/bias:0dense_1/bias/Assigndense_1/bias/read:02 dense_1/bias/Initializer/zeros:0*Æ
predict_images
/
image&
input:0’’’’’’’’’"
probability
probability:0 )
result
prediction:0	’’’’’’’’’tensorflow/serving/predict