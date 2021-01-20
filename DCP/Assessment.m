clc;
clear;
close all;
addpath(genpath('image'));
addpath(genpath('whyte_code'));
addpath(genpath('cho_code'));
opts.prescale = 1; %%downsampling
opts.xk_iter = 5; %% the iterations
opts.gamma_correct = 1.0;
opts.k_thresh = 20;
%% Note:
%% lambda_tv, lambda_l0, weight_ring are non-necessary, they are not used in kernel estimation.
%%
Path_ori = 'D:\caoshuning\caoshuning\spot5\gt\';

Method = 'Proposed';
FILE = dir(fullfile(['C:\Users\caoshuning\Desktop\Submit_text\result\simulation\',Method,'\1226\F\*.tif']));
% checkpoint = dir(fullfile('C:\Users\caoshuning\Desktop\JieTi\result\tank\k\*.png'));

Path_U = ['C:\Users\caoshuning\Desktop\Submit_text\result\simulation\',Method,'\1226\U\'];%U
if ~exist(Path_U,'dir')
    mkdir(Path_U)
end

Path_h = ['C:\Users\caoshuning\Desktop\Submit_text\result\simulation\',Method,'\1226\k\'];%U
if ~exist(Path_h,'dir')
    mkdir(Path_h)
end
Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\Degrade1226\';

% cp = floor((length(checkpoint))/8)*8+2;
for i = 1:length(FILE)
    imgname = FILE(i).name;
    filename = ['C:\Users\caoshuning\Desktop\Submit_text\result\simulation\',Method,'\1226\F\', imgname];
    oriname = [Path_ori, imgname(1:1),'.tif'];
    uname = [Path_U,imgname(1:end-4),'.tif'];
    gname = [Path_G, imgname];
    
    ori = im2double(imread(oriname));
    y = im2double(imread(filename));
    g = im2double(imread(gname));
    u = im2double(imread(uname));
    
    obs_psnr = psnr(ori, g);
    obs_ssim = ssim(ori, g);
    res_psnr = psnr(ori, u);
    res_ssim = ssim(ori, u);
    fprintf(['Proposed ','image:(spot5: ',imgname,'),',' PSNR_g = %2.4f,',' SSIM_g = %2.4f,',...
    ' PSNR_u = %2.4f,',' SSIM_u = %2.4f\n'],obs_psnr,obs_ssim,res_psnr,res_ssim);
%     imwrite(k,['C:\Users\caoshuning\Desktop\JieTi\result\tank\k\' ,imgname(3:end-4), '_kernel.png']);
%     imwrite(Latent,['C:\Users\caoshuning\Desktop\JieTi\result\tank\latent\' ,imgname(3:end-4), '_result.png']);
%     imwrite(interim_latent,['C:\Users\caoshuning\Desktop\JieTi\result\tank\interim_latent' ,imgname(3:end-4), '_interim_result.png']);
    close all;
end
    %%
%% ============Use Cho et al., ICCV 11 for non-blind deconvolution (For saturated images???)====================%%
%deblurred0 = deconv_outlier(y, kernel, 5/255, 0.003);
