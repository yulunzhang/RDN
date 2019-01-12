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
1. Download models for our paper and place them in '/RDN_TestCode/model'.

    All the models can be downloaded from [Dropbox](https://www.dropbox.com/sh/ngcvqdas167gol2/AAAdJe9w6s2fpo_KEGZe7d4Ra?dl=0) or [Baidu](https://pan.baidu.com/s/116FAzKnaJnAdxY_B6ENp_A).

2. Run 'TestRDN.lua'

    **You can use scripts in file 'TestRDN_scripts' to produce results for our paper.**

    ```bash
    # No self-ensemble: RDN
    # BI degradation model, X2, X3, X4, X8
    th TestRDN.lua -model RDN_BIX2 -degradation BI -scale 2 -selfEnsemble false -dataset Set5
    th TestRDN.lua -model RDN_BIX3 -degradation BI -scale 3 -selfEnsemble false -dataset Set5
    th TestRDN.lua -model RDN_BIX4 -degradation BI -scale 4 -selfEnsemble false -dataset Set5

    # With self-ensemble: RDN+
    # BI degradation model, X2, X3, X4, X8
    th TestRDN.lua -model RDN_BIX2 -degradation BI -scale 2 -selfEnsemble true -dataset Set5
    th TestRDN.lua -model RDN_BIX3 -degradation BI -scale 3 -selfEnsemble true -dataset Set5
    th TestRDN.lua -model RDN_BIX4 -degradation BI -scale 4 -selfEnsemble true -dataset Set5
    ```
### Quick start for DN_Gray
1. Download models for our paper and place them in '/RDN_TestCode/model'.

    All the models can be downloaded from [Dropbox](https://www.dropbox.com/sh/ngcvqdas167gol2/AAAdJe9w6s2fpo_KEGZe7d4Ra?dl=0) or [Baidu](https://pan.baidu.com/s/116FAzKnaJnAdxY_B6ENp_A).

2. Run 'TestRDN.lua'

    **You can use scripts in file 'TestRDN_scripts' to produce results for our paper.**

    ```bash
    # No self-ensemble: RDN
    # BI degradation model, X2, X3, X4, X8
    th TestRDN.lua -model RDN_BIX2 -degradation BI -scale 2 -selfEnsemble false -dataset Set5
    th TestRDN.lua -model RDN_BIX3 -degradation BI -scale 3 -selfEnsemble false -dataset Set5
    th TestRDN.lua -model RDN_BIX4 -degradation BI -scale 4 -selfEnsemble false -dataset Set5

    # With self-ensemble: RDN+
    # BI degradation model, X2, X3, X4, X8
    th TestRDN.lua -model RDN_BIX2 -degradation BI -scale 2 -selfEnsemble true -dataset Set5
    th TestRDN.lua -model RDN_BIX3 -degradation BI -scale 3 -selfEnsemble true -dataset Set5
    th TestRDN.lua -model RDN_BIX4 -degradation BI -scale 4 -selfEnsemble true -dataset Set5
    ```
### Quick start for DN_RGB
1. Download models for our paper and place them in '/RDN_TestCode/model'.

    All the models can be downloaded from [Dropbox](https://www.dropbox.com/sh/ngcvqdas167gol2/AAAdJe9w6s2fpo_KEGZe7d4Ra?dl=0) or [Baidu](https://pan.baidu.com/s/116FAzKnaJnAdxY_B6ENp_A).

2. Run 'TestRDN.lua'

    **You can use scripts in file 'TestRDN_scripts' to produce results for our paper.**

    ```bash
    # No self-ensemble: RDN
    # BI degradation model, X2, X3, X4, X8
    th TestRDN.lua -model RDN_BIX2 -degradation BI -scale 2 -selfEnsemble false -dataset Set5
    th TestRDN.lua -model RDN_BIX3 -degradation BI -scale 3 -selfEnsemble false -dataset Set5
    th TestRDN.lua -model RDN_BIX4 -degradation BI -scale 4 -selfEnsemble false -dataset Set5

    # With self-ensemble: RDN+
    # BI degradation model, X2, X3, X4, X8
    th TestRDN.lua -model RDN_BIX2 -degradation BI -scale 2 -selfEnsemble true -dataset Set5
    th TestRDN.lua -model RDN_BIX3 -degradation BI -scale 3 -selfEnsemble true -dataset Set5
    th TestRDN.lua -model RDN_BIX4 -degradation BI -scale 4 -selfEnsemble true -dataset Set5
    ```
### Quick start for CAR_Y
1. Download models for our paper and place them in '/RDN_TestCode/model'.

    All the models can be downloaded from [Dropbox](https://www.dropbox.com/sh/ngcvqdas167gol2/AAAdJe9w6s2fpo_KEGZe7d4Ra?dl=0) or [Baidu](https://pan.baidu.com/s/116FAzKnaJnAdxY_B6ENp_A).

2. Run 'TestRDN.lua'

    **You can use scripts in file 'TestRDN_scripts' to produce results for our paper.**

    ```bash
    # No self-ensemble: RDN
    # BI degradation model, X2, X3, X4, X8
    th TestRDN.lua -model RDN_BIX2 -degradation BI -scale 2 -selfEnsemble false -dataset Set5
    th TestRDN.lua -model RDN_BIX3 -degradation BI -scale 3 -selfEnsemble false -dataset Set5
    th TestRDN.lua -model RDN_BIX4 -degradation BI -scale 4 -selfEnsemble false -dataset Set5

    # With self-ensemble: RDN+
    # BI degradation model, X2, X3, X4, X8
    th TestRDN.lua -model RDN_BIX2 -degradation BI -scale 2 -selfEnsemble true -dataset Set5
    th TestRDN.lua -model RDN_BIX3 -degradation BI -scale 3 -selfEnsemble true -dataset Set5
    th TestRDN.lua -model RDN_BIX4 -degradation BI -scale 4 -selfEnsemble true -dataset Set5
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
