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

opts.kernel_size = 15;  saturation = 0;
lambda_dark = 4e-3; lambda_grad = 4e-3; 
lambda_tv = 0.001; lambda_l0 = 1e-3; weight_ring = 1;
%% Note:
%% lambda_tv, lambda_l0, weight_ring are non-necessary, they are not used in kernel estimation.
%%
Path_ori = 'D:\caoshuning\code_DestripeDeblur\Data\ori\';
Path_g = 'D:\caoshuning\code_DestripeDeblur\Data\simulation\19-Jan-2021\G\';

Method = 'SGE'; date = '19-Jan-2021';
FILE = dir(fullfile(['C:\Users\caoshuning\Desktop\Submit_text\result\simulation\',Method,'\',date,'\F\*.tif']));

% checkpoint = dir(fullfile('C:\Users\caoshuning\Desktop\JieTi\result\tank\k\*.png'));

%save path
Path_U = ['C:\Users\caoshuning\Desktop\Submit_text\result\simulation\',Method,'\',date,'\U\'];%U
if ~exist(Path_U,'dir')
    mkdir(Path_U)
end

Path_h = ['C:\Users\caoshuning\Desktop\Submit_text\result\simulation\',Method,'\',date,'\k\'];%U
if ~exist(Path_h,'dir')
    mkdir(Path_h)
end

% cp = floor((length(checkpoint))/8)*8+2;
for i = 133:length(FILE)
    imgname = FILE(i).name;
    filename = ['C:\Users\caoshuning\Desktop\Submit_text\result\simulation\',Method,'\',date,'\F\', imgname];
    oriname = [Path_ori, imgname(1:1),'.tif'];
    ori = im2double(imread(oriname));
    gname = [Path_g, imgname];
    g = im2double(imread(gname));
    %===================================
    y = imread(filename);

    isselect = 0; %false or true
    if isselect ==1
        figure, imshow(y);
        tips = msgbox('Please choose the area for deblurring:');
        fprintf('Please choose the area for deblurring:\n');
        h = imrect;
        position = wait(h);
        close;
        B_patch = imcrop(y,position);
        y = (B_patch);
    else
        y = y;
    end
    if size(y,3)==3
        yg = im2double(rgb2gray(y));
    else
        yg = im2double(y);
    end
%     tic;
    [kernel, interim_latent] = blind_deconv(yg, lambda_dark, lambda_grad, opts);
%     toc


    %% Algorithm is done!
    %% ============Non-blind deconvolution ((Just use text deblurring methods))====================%%
    y = im2double(y);
    %% Final Deblur: 
    if ~saturation
        %% 1. TV-L2 denoising method
        Latent = ringing_artifacts_removal(y, kernel, lambda_tv, lambda_l0, weight_ring);
    else
        %% 2. Whyte's deconvolution method (For saturated images)
        Latent = whyte_deconv(y, kernel);
    end
    figure; imshow(Latent)
    %%
    k = kernel - min(kernel(:));
    k = k./max(k(:)); 
    h = k;
    u = im2double(Latent);
    
    imagesc(u);colormap(gray); axis off; axis equal;
    print(gcf,'-depsc2',[Path_U,imgname(1:end-4),'.eps'],'-r600')
    imwrite(u,[Path_U,imgname(1:end-4),'.tif']);
    
    imagesc(h);colormap(gray); axis off; axis equal;
    print(gcf,'-depsc2',[Path_h,imgname(1:end-4),'.eps'],'-r600')
    imwrite(h,[Path_h,imgname(1:end-4),'.tif']);
    
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
