
clear; clc;

mask_file  = '/Users/JamieBlair/Desktop/Whole_Brain_Masks/rWhiteMatter_Mask_VBM.nii';

mask_nii   = spm_vol(mask_file);

mask_img   = spm_read_vols(mask_nii);

tot_vol = nansum(mask_img(:));

disp(tot_vol)


