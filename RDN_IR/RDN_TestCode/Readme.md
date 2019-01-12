# Residual Dense Network for Image Restoration
This repository is for RDN introduced in the following papers

[Yulun Zhang](http://yulunzhang.com/), [Yapeng Tian](http://yapengtian.org/), [Yu Kong](http://www1.ece.neu.edu/~yukong/), [Bineng Zhong](https://scholar.google.de/citations?user=hvRBydsAAAAJ&hl=en), and [Yun Fu](http://www1.ece.neu.edu/~yunfu/), "Residual Dense Network for Image Super-Resolution", CVPR 2018 (spotlight), [[arXiv]](https://arxiv.org/abs/1802.08797) 

[Yulun Zhang](http://yulunzhang.com/), [Yapeng Tian](http://yapengtian.org/), [Yu Kong](http://www1.ece.neu.edu/~yukong/), [Bineng Zhong](https://scholar.google.de/citations?user=hvRBydsAAAAJ&hl=en), and [Yun Fu](http://www1.ece.neu.edu/~yunfu/), "Residual Dense Network for Image Restoration", arXiv 2018, [[arXiv]](https://arxiv.org/abs/1812.10477) 


The code is built on [EDSR (Torch)](https://github.com/LimBee/NTIRE2017) and tested on Ubuntu 14.04 environment (Torch7, CUDA8.0, cuDNN5.1) with Titan X/1080Ti/Xp GPUs.

Other implementations: [PyTorch_version](https://github.com/thstkdgus35/EDSR-PyTorch) has been implemented by Nguyễn Trần Toàn (trantoan060689@gmail.com) and merged into [EDSR_PyTorch](https://github.com/thstkdgus35/EDSR-PyTorch). [TensorFlow_version](https://github.com/hengchuan/RDN-TensorFlow) by hengchuan.

To be updated!!!

## Contents
1. [Test](#test)
2. [Results](#results)
3. [Citation](#citation)
4. [Acknowledgements](#acknowledgements)

## Test
### Quick start for SR (BI degradation model, training data: DIV2K+Flickr2K, input size: 48x48)
1. Download models for our paper and place them in '/RDN_IR/RDN_TestCode/RDN_SR_RGB/model'.

    All the models can be downloaded from [Baidu](https://pan.baidu.com/s/1Qj0QAMFBT9VTSzRqQyjrKQ).

2. Run 'TestRDN.lua'

    **You can use the following scripts to produce results for our paper.**

    ```bash
    # No self-ensemble: RDN
    # BI degradation model, X2, X3, X4, X8
    th TestRDN.lua -model RDN_DF2K_BIX2 -degradation BI -scale 2 -selfEnsemble false -dataset Set5
    th TestRDN.lua -model RDN_DF2K_BIX3 -degradation BI -scale 3 -selfEnsemble false -dataset Set5
    th TestRDN.lua -model RDN_DF2K_BIX4 -degradation BI -scale 4 -selfEnsemble false -dataset Set5
    th TestRDN.lua -model RDN_DF2K_BIX8 -degradation BI -scale 8 -selfEnsemble false -dataset Set5

    # With self-ensemble: RDN+
    # BI degradation model, X2, X3, X4, X8
    th TestRDN.lua -model RDN_DF2K_BIX2 -degradation BI -scale 2 -selfEnsemble true -dataset Set5
    th TestRDN.lua -model RDN_DF2K_BIX3 -degradation BI -scale 3 -selfEnsemble true -dataset Set5
    th TestRDN.lua -model RDN_DF2K_BIX4 -degradation BI -scale 4 -selfEnsemble true -dataset Set5
    th TestRDN.lua -model RDN_DF2K_BIX8 -degradation BI -scale 8 -selfEnsemble true -dataset Set5
    ```
### Quick start for DN_Gray
1. Download models for our paper and place them in '/RDN_IR/RDN_TestCode/RDN_DN_Gray/model'.

    All the models can be downloaded from [Baidu](https://pan.baidu.com/s/13sbwGX8QauNCPpp0oUWUmQ).

2. Run 'TestRDN_DN_Gray.lua'

    **You can use the following scripts to produce results for our paper.**

    ```bash
    # No self-ensemble: RDN
    th TestRDN_DN_Gray.lua -model RDN_DN_Gray_N10 -noise 10 -selfEnsemble false -dataset Kodak24 
    th TestRDN_DN_Gray.lua -model RDN_DN_Gray_N30 -noise 30 -selfEnsemble false -dataset Kodak24 
    th TestRDN_DN_Gray.lua -model RDN_DN_Gray_N50 -noise 50 -selfEnsemble false -dataset Kodak24 
    th TestRDN_DN_Gray.lua -model RDN_DN_Gray_N70 -noise 70 -selfEnsemble false -dataset Kodak24 

    # With self-ensemble: RDN+
    th TestRDN_DN_Gray.lua -model RDN_DN_Gray_N10 -noise 10 -selfEnsemble true -dataset Kodak24 
    th TestRDN_DN_Gray.lua -model RDN_DN_Gray_N30 -noise 30 -selfEnsemble true -dataset Kodak24 
    th TestRDN_DN_Gray.lua -model RDN_DN_Gray_N50 -noise 50 -selfEnsemble true -dataset Kodak24 
    th TestRDN_DN_Gray.lua -model RDN_DN_Gray_N70 -noise 70 -selfEnsemble true -dataset Kodak24 
    ```
### Quick start for DN_RGB
1. Download models for our paper and place them in '/RDN_IR/RDN_TestCode/RDN_DN_RGB/model'.

    All the models can be downloaded from [Baidu](https://pan.baidu.com/s/1rQ9Mofa1C8Ls73H96oYHFQ).

2. Run 'TestRDN_DN_RGB.lua'

    **You can use the following scripts to produce results for our paper.**

    ```bash
    # No self-ensemble: RDN
    th TestRDN_DN_RGB.lua -model RDN_DN_RGB_N10 -noise 10 -selfEnsemble false -dataset Kodak24 
    th TestRDN_DN_RGB.lua -model RDN_DN_RGB_N30 -noise 30 -selfEnsemble false -dataset Kodak24 
    th TestRDN_DN_RGB.lua -model RDN_DN_RGB_N50 -noise 50 -selfEnsemble false -dataset Kodak24 
    th TestRDN_DN_RGB.lua -model RDN_DN_RGB_N70 -noise 70 -selfEnsemble false -dataset Kodak24 

    # With self-ensemble: RDN+
    th TestRDN_DN_RGB.lua -model RDN_DN_RGB_N10 -noise 10 -selfEnsemble true -dataset Kodak24 
    th TestRDN_DN_RGB.lua -model RDN_DN_RGB_N30 -noise 30 -selfEnsemble true -dataset Kodak24 
    th TestRDN_DN_RGB.lua -model RDN_DN_RGB_N50 -noise 50 -selfEnsemble true -dataset Kodak24 
    th TestRDN_DN_RGB.lua -model RDN_DN_RGB_N70 -noise 70 -selfEnsemble true -dataset Kodak24 
    ```
### Quick start for CAR_Y
1. Download models for our paper and place them in '/RDN_IR/RDN_TestCode/RDN_CAR_Y/model'.

    All the models can be downloaded from [Baidu](https://pan.baidu.com/s/1taQIng9vPdNJ4ax3qLrE4Q).

2. Run 'TestRDN_CAR_Y.lua'

    **You can use the following scripts to produce results for our paper.**

    ```bash
    # No self-ensemble: RDN
    th TestRDN_CAR_Y.lua -model RDN_CAR_Y_Q10 -noise 10 -selfEnsemble false -dataset Classic5
    th TestRDN_CAR_Y.lua -model RDN_CAR_Y_Q20 -noise 20 -selfEnsemble false -dataset Classic5
    th TestRDN_CAR_Y.lua -model RDN_CAR_Y_Q30 -noise 30 -selfEnsemble false -dataset Classic5
    th TestRDN_CAR_Y.lua -model RDN_CAR_Y_Q40 -noise 40 -selfEnsemble false -dataset Classic5

    ## With self-ensemble: RDN+
    th TestRDN_CAR_Y.lua -model RDN_CAR_Y_Q10 -noise 10 -selfEnsemble true -dataset Classic5
    th TestRDN_CAR_Y.lua -model RDN_CAR_Y_Q20 -noise 20 -selfEnsemble true -dataset Classic5
    th TestRDN_CAR_Y.lua -model RDN_CAR_Y_Q30 -noise 30 -selfEnsemble true -dataset Classic5
    th TestRDN_CAR_Y.lua -model RDN_CAR_Y_Q40 -noise 40 -selfEnsemble true -dataset Classic5
    ```

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
