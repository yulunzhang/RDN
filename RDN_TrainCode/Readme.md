# Torch train code for CVPR18RDN with BI, BD, DN degradation models.

## Train:
1. (optional) Download models for our paper and place them in '/RDN_TrainCode/experiment/model'.

    All the models can be downloaded from Dropbox
    https://www.dropbox.com/sh/ngcvqdas167gol2/AAAdJe9w6s2fpo_KEGZe7d4Ra?dl=0
    
    or Baidu
    https://pan.baidu.com/s/116FAzKnaJnAdxY_B6ENp_A

2. Cd to 'RDN_TrainCode/code', Run the following scripts to train models.

    **You can use scripts in file 'TrainRDN_scripts' to train models for our paper.**

    ```bash
    # BI, scale 2, 3, 4
    # BIX2F64D18C6G64P48, input=48x48, output=96x96
    th main.lua -scale 2 -netType RDN -nFeat 64 -nFeaSDB 64 -nDenseBlock 16 -nDenseConv 8 -growthRate 64 -patchSize 96 -dataset div2k -datatype t7  -DownKernel BI -splitBatch 4 -trainOnly true

    # BIX3F64D18C6G64P32, input=32x32, output=96x96, fine-tune on RDN_BIX2.t7
    th main.lua -scale 3 -netType resnet_cu -nFeat 64 -nFeaSDB 64 -nDenseBlock 16 -nDenseConv 8 -growthRate 64 -patchSize 96 -dataset div2k -datatype t7  -DownKernel BI -splitBatch 4 -trainOnly true  -preTrained ../experiment/model/RDN_BIX2.t7

    # BIX4F64D18C6G64P32, input=32x32, output=128x128, fine-tune on RDN_BIX2.t7
    th main.lua -scale 4 -nGPU 1 -netType resnet_cu -nFeat 64 -nFeaSDB 64 -nDenseBlock 16 -nDenseConv 8 -growthRate 64 -patchSize 128 -dataset div2k -datatype t7  -DownKernel BI -splitBatch 4 -trainOnly true -nEpochs 1000 -preTrained ../experiment/model/RDN_BIX2.t7 

    # BD, scale 3
    # BDX3F64D18C6G64P32, input=32x32, output=96x96, fine-tune on RDN_BIX3.t7
    LOG=./../experiment/BDX3F64D18C6G64P32-`date +%Y-%m-%d-%H-%M-%S`.txt
    CUDA_VISIBLE_DEVICES=2 th main.lua -scale 3 -nGPU 1 -netType resnet_cu -nFeat 64 -nFeaSDB 64 -nDenseBlock 16 -nDenseConv 8 -growthRate 64 -patchSize 96 -dataset div2k -datatype t7  -DownKernel BD -splitBatch 4 -trainOnly true -nEpochs 200 -preTrained ../experiment/model/RDN_BIX3.t7

    # DN, scale 3
    # DNX3F64D18C6G64P32, input=32x32, output=96x96, fine-tune on RDN_BIX3.t7
    LOG=./../experiment/DNX3F64D18C6G64P32-`date +%Y-%m-%d-%H-%M-%S`.txt
    CUDA_VISIBLE_DEVICES=1 th main.lua -scale 3 -nGPU 1 -netType resnet_cu -nFeat 64 -nFeaSDB 64 -nDenseBlock 16 -nDenseConv 8 -growthRate 64 -patchSize 96 -dataset div2k -datatype t7  -DownKernel DN -splitBatch 4 -trainOnly true  -nEpochs 200 -preTrained ../experiment/model/RDN_BIX3.t7
    ```

## The whole test pipeline
1. Prepare test data.

    Place the original test sets (e.g., Set5) in 'OriginalTestData'.

    Run 'Prepare_TestData_HR_LR.m' in Matlab to generate HR/LR images with different degradation models.
2. Conduct image SR. 

    See **Quick start**
3. Evaluate the results.

    Run 'Evaluate_PSNR_SSIM.m' to obtain PSNR/SSIM values for paper.

## Citation
If you find our code helpful in your resarch or work, please cite our paper.
```
@inproceedings{zhang2018residual,
    title={Residual Dense Network for Image Super-Resolution},
    author={Zhang, Yulun and Tian, Yapeng and Kong, Yu and Zhong, Bineng and Fu, Yun},
    booktitle={CVPR},
    year={2018}
}
```
## Acknowledgements
This code is built on [EDSR (Torch)](https://github.com/LimBee/NTIRE2017). We thank the authors for sharing their codes of EDSR [Torch version](https://github.com/LimBee/NTIRE2017) and [PyTorch version](https://github.com/thstkdgus35/EDSR-PyTorch). 










