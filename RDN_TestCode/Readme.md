# Torch test code for CVPR18RDN with BI, BD, DN degradation models.

## Quick start:
1. Download models for our paper and place them in '/RDN_TestCode/model'.

    All the models can be downloaded from Dropbox
    https://www.dropbox.com/sh/ngcvqdas167gol2/AAAdJe9w6s2fpo_KEGZe7d4Ra?dl=0
    
    or Baidu
    https://pan.baidu.com/s/116FAzKnaJnAdxY_B6ENp_A

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

## The whole test pipeline
1. Prepare test data.

    Place the original test sets (e.g., Set5, other test sets are available from [GoogleDrive](https://drive.google.com/drive/folders/1xyiuTr6ga6ni-yfTP7kyPHRmfBakWovo?usp=sharing) or [Baidu](https://pan.baidu.com/s/1yBI_-rknXT2lm1UAAB_bag)) in 'OriginalTestData'.

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










