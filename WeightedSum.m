clear; clc;


% nifti directory
nifti_dir = '';

% mask filename
mask_file  = '';
% Colin27 brain

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
niftis = dir(nifti_dir); % extract directory properties
nifti_filenames = {niftis.name}; % grab file name
% nifti_filenames = nifti_filenames(4:end)'; % get rid of hidden directories

idx_rm = [];
for n = 1:length(nifti_filenames)
    if strcmp(nifti_filenames{n},'.') || strcmp(nifti_filenames{n},'..') || strcmp(nifti_filenames{n},'.DS_Store')
        idx_rm = [idx_rm,n];
    end
end
nifti_filenames(idx_rm) = [];

vol_output = cell(length(nifti_filenames),2); % set up output array
mask_nii   = spm_vol(mask_file);mask_img   = spm_read_vols(mask_nii);

for k = 1:numel(mask_img)
    if isnan(mask_img(k))
        mask_img(k) = 0;
    end
end

cd(nifti_dir) % move to nifti directory

for k = 1:length(nifti_filenames)

nii = spm_vol(nifti_filenames{k}); % Load nifti
img = spm_read_vols(nii); % Load image

for j = 1:numel(img)
    if isnan(img(j))
        img(j) = 0;
    end
end

sub_roi = img.*mask_img;
tot_vol = sum(sum(sum(sub_roi))); % Sum voxel values

vol_output{k,1} = nifti_filenames{k}; % write nifti name to array
vol_output{k,2} = tot_vol; % write volume to array

