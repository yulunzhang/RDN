# Prepare training data 

1. Download DIV2K training data (800 training + 100 validtion images) from [DIV2K dataset](https://data.vision.ee.ethz.ch/cvl/DIV2K/) or [SNU_CVLab](https://cv.snu.ac.kr/research/EDSR/DIV2K.tar).

2. Place all the HR images in 'Prepare_TrainData/DIV2K/DIV2K_HR'.

3. Run 'Prepare_TrainData_HR_LR_BI/BD/DN.m' in matlab to generate LR images for BI, BD, and DN models respectively.

4. Run 'th png_to_t7.lua' to convert each .png image to .t7 file in new folder 'DIV2K_decoded'.

5. Specify the path of 'DIV2K_decoded' to '-datadir' in 'RDN_TrainCode/code/opts.lua'.

For more informaiton, please refer to [EDSR(Torch)](https://github.com/LimBee/NTIRE2017).

