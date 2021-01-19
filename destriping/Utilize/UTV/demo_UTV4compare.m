
clear all; 
close all;
clc;

Path_ori = 'D:\caoshuning\caoshuning\spot5\gt\';

% Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\degradation2098\Nonperiodical\G\';
Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\spot5(1)-degradation\';
suffix = '.tif';
Gs = dir(fullfile(Path_G,strcat('*',suffix)));

%save path
Path_est_S = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\UTV\1005\est_S\';%est_S
if ~exist(Path_est_S,'dir')
    mkdir(Path_est_S)
end
Path_F = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\UTV\1005\F\';%U
if ~exist(Path_F,'dir')
    mkdir(Path_F)
end
%% 读取或加载图像
for i = 1:length(Gs)  
%     ori = im2double(imread([Path_ori, Gs(i).name(1),'.tif']));
%     [filename, filepath, FilterIndex ] = uigetfile('/*.*','Read image');
%     I =  im2double(imread(fullfile(filepath,filename)));%degrade g
    ori = im2double(imread([Path_ori, Gs(i).name(1),'.tif']));
    I = im2double(imread([Path_G, Gs(i).name]));
    f = transpose(I); % 将竖条带转换为横条带 
    figure; imshow(f',[]); title('Striped image');

    %%% 参数设置
%     alpha = 1000;omega2 = 10;
%     belta = 100;lamda = 1;
%     omega1 = 0.0001;
%     MaxIter = 30;
    stripe_level = str2double(Gs(i).name(end-9:end-8));
    SIG = str2double(Gs(i).name(end-15:end-13));
    [opt] = Para4UTV(stripe_level,SIG);
    alpha = opt.alpha; omega2 = opt.omega2;
    belta = opt.belta; lamda = opt.lamda;
    omega1 = opt.omega1;
    MaxIter = opt.MaxIter;
%     tic
    %%% 主程序
    u = UTVdestripe(f,alpha,belta,lamda,omega1,omega2,MaxIter);
    [u,h,out] = Deblur(u,ori,0.0001,0.05,0.00001,0.005,100);
    G = I;
    s = G - u';
    f = u';
    obs_psnr = psnr(ori, G);
    obs_ssim = ssim(ori, G);
    res_psnr = psnr(ori, f);
    res_ssim = ssim(ori, f);
    fprintf(['Proposed ','image:(spot5: ',Gs(i).name,'),',' PSNR_g = %2.4f,',' SSIM_g = %2.4f,',...
    ' PSNR_f = %2.4f,',' SSIM_f = %2.4f\n'],obs_psnr,obs_ssim,res_psnr,res_ssim);
    
    imagesc(f);colormap(gray); axis off; axis equal;
    print(gcf,'-depsc2',[Path_F,Gs(i).name(1:end-4),'.eps'],'-r600')
    imwrite(f,[Path_F,Gs(i).name(1:end-4),'.tif']);
    
    imagesc(s);colormap(gray); axis off; axis equal;
    print(gcf,'-depsc2',[Path_est_S,Gs(i).name(1:end-4),'.eps'],'-r600')
    imwrite(s,[Path_est_S,Gs(i).name(1:end-4),'.tif']);
    close all;
%     figure,imshow(u',[])
%     toc
end
