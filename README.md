# Residual Dense Network for Image Super-Resolution
This repository is for RDN introduced in the following paper

[Yulun Zhang](http://yulunzhang.com/), [Yapeng Tian](http://yapengtian.org/), [Yu Kong](http://www1.ece.neu.edu/~yukong/), [Bineng Zhong](https://scholar.google.de/citations?user=hvRBydsAAAAJ&hl=en), and [Yun Fu](http://www1.ece.neu.edu/~yunfu/), "Residual Dense Network for Image Super-Resolution", CVPR 2018 (spotlight), [[arXiv]](https://arxiv.org/abs/1802.08797) 

[Yulun Zhang](http://yulunzhang.com/), [Yapeng Tian](http://yapengtian.org/), [Yu Kong](http://www1.ece.neu.edu/~yukong/), [Bineng Zhong](https://scholar.google.de/citations?user=hvRBydsAAAAJ&hl=en), and [Yun Fu](http://www1.ece.neu.edu/~yunfu/), "Residual Dense Network for Image Restoration", arXiv 2018, [[arXiv]](https://arxiv.org/abs/1812.10477) 


The code is built on [EDSR (Torch)](https://github.com/LimBee/NTIRE2017) and tested on Ubuntu 14.04 environment (Torch7, CUDA8.0, cuDNN5.1) with Titan X/1080Ti/Xp GPUs.

Other implementations: [PyTorch_version](https://github.com/thstkdgus35/EDSR-PyTorch) has been implemented by Nguyễn Trần Toàn (trantoan060689@gmail.com) and merged into [EDSR_PyTorch](https://github.com/thstkdgus35/EDSR-PyTorch). [TensorFlow_version](https://github.com/hengchuan/RDN-TensorFlow) by hengchuan.

## Contents
1. [Introduction](#introduction)
2. [Train](#train)
3. [Test](#test)
4. [Results](#results)
5. [Citation](#citation)
6. [Acknowledgements](#acknowledgements)

## Introduction
A very deep convolutional neural network (CNN) has recently achieved great success for image super-resolution (SR) and offered hierarchical features as well. However, most deep CNN based SR models do not make full use of the hierarchical features from the original low-resolution (LR) images, thereby achieving relatively-low performance. In this paper, we propose a novel residual dense network (RDN) to address this problem in image SR. We fully exploit the hierarchical features from all the convolutional layers. Speciﬁcally, we propose residual dense block (RDB) to extract abundant local features via dense connected convolutional layers. RDB further allows direct connections from the state of preceding RDB to all the layers of current RDB, leading to a contiguous memory (CM) mechanism. Local feature fusion in RDB is then used to adaptively learn more effective features from preceding and current local features and stabilizes the training of wider network. After fully obtaining dense local features, we use global feature fusion to jointly and adaptively learn global hierarchical features in a holistic way. Experiments on benchmark datasets with different degradation models show that our RDN achieves favorable performance against state-of-the-art methods.

![RDB](/Figs/RDB.png)
Figure 1. Residual dense block (RDB) architecture.
![RDN](/Figs/RDN.png)
Figure 2. The architecture of our proposed residual dense network (RDN).

## Train
### Prepare training data 

1. Download DIV2K training data (800 training + 100 validtion images) from [DIV2K dataset](https://data.vision.ee.ethz.ch/cvl/DIV2K/) or [SNU_CVLab](https://cv.snu.ac.kr/research/EDSR/DIV2K.tar).

2. Place all the HR images in 'Prepare_TrainData/DIV2K/DIV2K_HR'.

3. Run 'Prepare_TrainData_HR_LR_BI/BD/DN.m' in matlab to generate LR images for BI, BD, and DN models respectively.

4. Run 'th png_to_t7.lua' to convert each .png image to .t7 file in new folder 'DIV2K_decoded'.

5. Specify the path of 'DIV2K_decoded' to '-datadir' in 'RDN_TrainCode/code/opts.lua'.

For more informaiton, please refer to [EDSR(Torch)](https://github.com/LimBee/NTIRE2017).

### Begin to train

1. (optional) Download models for our paper and place them in '/RDN_TrainCode/experiment/model'.

    All the models can be downloaded from [Dropbox](https://www.dropbox.com/sh/ngcvqdas167gol2/AAAdJe9w6s2fpo_KEGZe7d4Ra?dl=0) or [Baidu](https://pan.baidu.com/s/116FAzKnaJnAdxY_B6ENp_A).

2. Cd to 'RDN_TrainCode/code', run the following scripts to train models.

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
    th main.lua -scale 3 -nGPU 1 -netType resnet_cu -nFeat 64 -nFeaSDB 64 -nDenseBlock 16 -nDenseConv 8 -growthRate 64 -patchSize 96 -dataset div2k -datatype t7  -DownKernel BD -splitBatch 4 -trainOnly true -nEpochs 200 -preTrained ../experiment/model/RDN_BIX3.t7

    # DN, scale 3
    # DNX3F64D18C6G64P32, input=32x32, output=96x96, fine-tune on RDN_BIX3.t7
    th main.lua -scale 3 -nGPU 1 -netType resnet_cu -nFeat 64 -nFeaSDB 64 -nDenseBlock 16 -nDenseConv 8 -growthRate 64 -patchSize 96 -dataset div2k -datatype t7  -DownKernel DN -splitBatch 4 -trainOnly true  -nEpochs 200 -preTrained ../experiment/model/RDN_BIX3.t7
    ```
    Only RDN_BIX2.t7 was trained using 48x48 input patches. All other models were trained using 32x32 input patches in order to save training time.
    However, smaller input patch size in training would lower the performance to some degree. We also set '-trainOnly true' to save GPU memory.
## Test
### Quick start
1. Download models for our paper and place them in '/RDN_TestCode/model'.

    All the models can be downloaded from [Dropbox](https://www.dropbox.com/sh/ngcvqdas167gol2/AAAdJe9w6s2fpo_KEGZe7d4Ra?dl=0) or [Baidu](https://pan.baidu.com/s/116FAzKnaJnAdxY_B6ENp_A).

2. Run 'TestRDN.lua'

    **You can use scripts in file 'TestRDN_scripts' to produce results for our paper.**

    ```bash
    # No self-ensemble: RDN
    # BI degradation model, X2, X3, X4
    th TestRDN.lua -model RDN_BIX2 -degradation BI -scale 2 -selfEnsemble false -dataset Set5
    th TestRDN.lua -model RDN_BIX3 -degradation BI -scale 3 -selfEnsemble false -dataset Set5
    th TestRDN.lua -model RDN_BIX4 -degradation BI -scale 4 -selfEnsemble false -dataset Set5
    # BD degradation model, X3
    th TestRDN.lua -model RDN_BDX3 -degradation BD -scale 3 -selfEnsemble false -dataset Set5
    # DN degradation model, X3
    th TestRDN.lua -model RDN_DNX3 -degradation DN -scale 3 -selfEnsemble false -dataset Set5


    # With self-ensemble: RDN+
    # BI degradation model, X2, X3, X4
    th TestRDN.lua -model RDN_BIX2 -degradation BI -scale 2 -selfEnsemble true -dataset Set5
    th TestRDN.lua -model RDN_BIX3 -degradation BI -scale 3 -selfEnsemble true -dataset Set5
    th TestRDN.lua -model RDN_BIX4 -degradation BI -scale 4 -selfEnsemble true -dataset Set5
    # BD degradation model, X3
    th TestRDN.lua -model RDN_BDX3 -degradation BD -scale 3 -selfEnsemble true -dataset Set5
    # DN degradation model, X3
    th TestRDN.lua -model RDN_DNX3 -degradation DN -scale 3 -selfEnsemble true -dataset Set5
    ```

### The whole test pipeline
1. Prepare test data.

    Place the original test sets (e.g., Set5, other test sets are available from [GoogleDrive](https://drive.google.com/drive/folders/1xyiuTr6ga6ni-yfTP7kyPHRmfBakWovo?usp=sharing) or [Baidu](https://pan.baidu.com/s/1yBI_-rknXT2lm1UAAB_bag)) in 'OriginalTestData'.

    Run 'Prepare_TestData_HR_LR.m' in Matlab to generate HR/LR images with different degradation models.
2. Conduct image SR. 

    See **Quick start**
3. Evaluate the results.

    Run 'Evaluate_PSNR_SSIM.m' to obtain PSNR/SSIM values for paper.



## Results
![PSNR_SSIM_BI](/Figs/PSNR_SSIM_BI.png)
Table 1. Benchmark results with BI degradation model. Average PSNR/SSIM values for scaling factor ×2, ×3, and ×4.

![PSNR_SSIM_BD_DN](/Figs/PSNR_SSIM_BD_DN.png)
Table 2. Benchmark results with BD and DN degradation models. Average PSNR/SSIM values for scaling factor ×3.

## Citation
If you find the code helpful in your resarch or work, please cite the following papers.
```
@InProceedings{Lim_2017_CVPR_Workshops,
  author = {Lim, Bee and Son, Sanghyun and Kim, Heewon and Nah, Seungjun and Lee, Kyoung Mu},
  title = {Enhanced Deep Residual Networks for Single Image Super-Resolution},
  booktitle = {The IEEE Conference on Computer Vision and Pattern Recognition (CVPR) Workshops},
  month = {July},
  year = {2017}
}

@inproceedings{zhang2018residual,
    title={Residual Dense Network for Image Super-Resolution},
    author={Zhang, Yulun and Tian, Yapeng and Kong, Yu and Zhong, Bineng and Fu, Yun},
    booktitle={CVPR},
    year={2018}
}

@article{zhang2018rdnir,
    title={Residual Dense Network for Image Restoration},
    author={Zhang, Yulun and Tian, Yapeng and Kong, Yu and Zhong, Bineng and Fu, Yun},
    booktitle={arXiv},
    year={2018}
}

```
## Acknowledgements
This code is built on [EDSR (Torch)](https://github.com/LimBee/NTIRE2017). We thank the authors for sharing their codes of EDSR [Torch version](https://github.com/LimBee/NTIRE2017) and [PyTorch version](https://github.com/thstkdgus35/EDSR-PyTorch).
