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
NAME = 'CapitolCrop1';
% FILE = dir(fullfile('C:\Users\caoshuning\Desktop\JieTi\data\相干斑抑制\',NAME,'\*.bmp'));
% FILE = dir(fullfile('C:\Users\caoshuning\Desktop\JieTi\data\点目标\denoise640x512\*.bmp'));
Imgpath = 'C:\Users\caoshuning\Desktop\JieTi\data\图\';
FILE = dir(fullfile([Imgpath,'*.jpg']));

kernelpath = 'C:\Users\caoshuning\Desktop\JieTi\参考\data\levin_kernel\';
KERNEL = dir(fullfile([kernelpath,'\*.mat']));

for i = 7:length(FILE)
    for j = 1:length(KERNEL)

    imgname = FILE(i).name;
    filename = [Imgpath, imgname];
    savepath_k = ['C:\Users\caoshuning\Desktop\JieTi\data\zouxu\k\'];
    if ~exist(savepath_k,'dir')
        mkdir(savepath_k);
    end
    savepath_latent = ['C:\Users\caoshuning\Desktop\JieTi\data\zouxu\latent\'];
    if ~exist(savepath_latent,'dir')
        mkdir(savepath_latent);
    end
    savepath_int = ['C:\Users\caoshuning\Desktop\JieTi\data\zouxu\interim_latent\'];
    if ~exist(savepath_int,'dir')
        mkdir(savepath_int);
    end
    
    savepath_g = ['C:\Users\caoshuning\Desktop\JieTi\data\zouxu\g\'];
    if ~exist(savepath_g,'dir')
        mkdir(savepath_g);
    end

    % filename = 'image\flower.jpg'; 
    opts.kernel_size = 20;  saturation = 1;
    lambda_dark = 4e-3; lambda_grad = 4e-3; 
    lambda_tv = 0.001; lambda_l0 = 1e-3; weight_ring = 1;
    %%
    %===================================
    
    I = im2double(imread(filename));
    
    Kname = KERNEL(j).name;
    load([kernelpath, Kname]);
    y = conv2(I, f, 'same');
    imshow(y);

    % y = y(3:end-2,3:end-2,:);
    % y = imfilter(y,fspecial('gaussian',5,1),'same','replicate'); 
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
    tic;
    [kernel, interim_latent] = blind_deconv(yg, lambda_dark, lambda_grad, opts);
    toc


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

    imwrite(k,[savepath_k ,num2str(i), '_', num2str(j), '_kernel.png']);
    imwrite(Latent,[savepath_latent ,num2str(i), '_', num2str(j), '_result.png']);
    imwrite(y,[savepath_g ,num2str(i), '_', num2str(j), '_g.png']);
    end
end
    %%
%% ============Use Cho et al., ICCV 11 for non-blind deconvolution (For saturated images???)====================%%
%deblurred0 = deconv_outlier(y, kernel, 5/255, 0.003);
