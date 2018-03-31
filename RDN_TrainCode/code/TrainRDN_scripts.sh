## train
# BI, scale 2, 3, 4
##################################################################################################################################
# BI, scale 2, 3, 4
# BIX2F64D18C6G64P48, input=48x48, output=96x96
LOG=./../experiment/BIX2F64D18C6G64P48-`date +%Y-%m-%d-%H-%M-%S`.txt
CUDA_VISIBLE_DEVICES=1 th main.lua -scale 2 -netType RDN -nFeat 64 -nFeaSDB 64 -nDenseBlock 16 -nDenseConv 8 -growthRate 64 -patchSize 96 -dataset div2k -datatype t7  -DownKernel BI -splitBatch 4 -trainOnly true 2>&1 | tee $LOG

# BIX3F64D18C6G64P32, input=32x32, output=96x96
LOG=./../experiment/BIX3F64D18C6G64P32-`date +%Y-%m-%d-%H-%M-%S`.txt
CUDA_VISIBLE_DEVICES=1 th main.lua -scale 3 -netType resnet_cu -nFeat 64 -nFeaSDB 64 -nDenseBlock 16 -nDenseConv 8 -growthRate 64 -patchSize 96 -dataset div2k -datatype t7  -DownKernel BI -splitBatch 4 -trainOnly true  -preTrained ../experiment/model/RDN_BIX2.t7 2>&1 | tee $LOG

# BIX4F64D18C6G64P32, input=32x32, output=128x128
LOG=./../experiment/BIX4F64D18C6G64P32-`date +%Y-%m-%d-%H-%M-%S`.txt
CUDA_VISIBLE_DEVICES=1 th main.lua -scale 4 -nGPU 1 -netType resnet_cu -nFeat 64 -nFeaSDB 64 -nDenseBlock 16 -nDenseConv 8 -growthRate 64 -patchSize 128 -dataset div2k -datatype t7  -DownKernel BI -splitBatch 4 -trainOnly true -nEpochs 1000 -preTrained ../experiment/model/RDN_BIX2.t7 2>&1 | tee $LOG

# BD, scale 3
# BDX3F64D18C6G64P32, input=32x32, output=96x96
LOG=./../experiment/BDX3F64D18C6G64P32-`date +%Y-%m-%d-%H-%M-%S`.txt
CUDA_VISIBLE_DEVICES=2 th main.lua -scale 3 -nGPU 1 -netType resnet_cu -nFeat 64 -nFeaSDB 64 -nDenseBlock 16 -nDenseConv 8 -growthRate 64 -patchSize 96 -dataset div2k -datatype t7  -DownKernel BD -splitBatch 4 -trainOnly true -nEpochs 200 -preTrained ../experiment/model/RDN_BIX3.t7 2>&1 | tee $LOG

# DN, scale 3
# DNX3F64D18C6G64P32, input=32x32, output=96x96
LOG=./../experiment/DNX3F64D18C6G64P32-`date +%Y-%m-%d-%H-%M-%S`.txt
CUDA_VISIBLE_DEVICES=1 th main.lua -scale 3 -nGPU 1 -netType resnet_cu -nFeat 64 -nFeaSDB 64 -nDenseBlock 16 -nDenseConv 8 -growthRate 64 -patchSize 96 -dataset div2k -datatype t7  -DownKernel DN -splitBatch 4 -trainOnly true  -nEpochs 200 -preTrained ../experiment/model/RDN_BIX3.t7 2>&1 | tee $LOG




## other comments
# we use '-trainOnly true' to save GPU memory. Then we can train models with input patch size of 48x48. This allows us to keep the same input size as that in other methods (e.g.,EDSR). 
# In our arXiv paper, we reported the results with input patch size of 32x32. And the results with input size of 48x48 should be better.







