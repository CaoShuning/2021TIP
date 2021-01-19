
clear all; 
close all;
clc;

Path_ori = 'D:\caoshuning\caoshuning\spot5\gt\';

% Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\degradation2098\Nonperiodical\G\';
Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\spot5(1)-degradation\';
suffix = '.tif';
Gs = dir(fullfile(Path_G,strcat('*',suffix)));

%save path
Path_est_S = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\UTV\915\est_S\';%est_S
if ~exist(Path_est_S,'dir')
    mkdir(Path_est_S)
end
Path_F = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\UTV\915\F\';%U
if ~exist(Path_F,'dir')
    mkdir(Path_F)
end
%% 读取或加载图像

%     ori = im2double(imread([Path_ori, Gs(i).name(1),'.tif']));
    [filename, filepath, FilterIndex ] = uigetfile('D:\caoshuning\caoshuning\TEST_github\dataset\spot5(1)-degradation/*.*','Read image');
    [filename_ori, filepath_ori, FilterIndex ] = uigetfile('D:\caoshuning\caoshuning\spot5\gt\/*.*','Read image');
    ori = im2double(imread(fullfile(filepath_ori,filename_ori)));
    I =  im2double(imread(fullfile(filepath,filename)));%degrade g

    f = transpose(I); % 将竖条带转换为横条带 
    figure; imshow(f',[]); title('Striped image');

    %%% 参数设置
    stripe_level = str2double(filename(end-9:end-8));
    SIG = str2double(filename(end-15:end-13));
    [opt] = Para4UTV(stripe_level,SIG);
    alpha = opt.alpha; omega2 = opt.omega2;
    belta = opt.belta; lamda = opt.lamda;
    omega1 = opt.omega1;
    MaxIter = opt.MaxIter;
    tic
    %%% 主程序
    u = UTVdestripe(f,f,alpha,belta,lamda,omega1,omega2,MaxIter);
    figure,imshow(u',[])
    toc
    G = I;
    s = G - u';
    f = u';
    obs_psnr = psnr(ori, G);
    obs_ssim = ssim(ori, G);
    res_psnr = psnr(ori, f);
    res_ssim = ssim(ori, f);
    fprintf(['Proposed ','image:(spot5: ',filename,'),',' PSNR_g = %2.4f,',' SSIM_g = %2.4f,',...
    ' PSNR_f = %2.4f,',' SSIM_f = %2.4f\n'],obs_psnr,obs_ssim,res_psnr,res_ssim);
