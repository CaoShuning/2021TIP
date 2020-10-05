% for para setting related to sig and intensity of stripe noise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;
addpath(genpath('Images\'));
addpath(genpath('psfestimation\'));
addpath(genpath('destriping\'));
addpath(genpath('PROPACK\'));
addpath(genpath('boundary_proc_code\'));
addpath(genpath('framelet\'));
% addpath(genpath('D:\caoshuning\caoshuning\TEST_github\'))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%para setting
opt.alphax = 0.0001;   %水平方向差分的惩罚参数
opt.ax = 0.999;        %alphax = alphax * 0.999;
opt.alphay = 0.00005;   %竖直方向差分的惩罚参数
opt.ay = 0.995;        %alphay = alphay * 0.995;
opt.taux = 0.0000025;     %水平方向差分的正则化参数
opt.tx = 1;        %taux=taux*1.01;
opt.tauy = 0.000025;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
opt.ty = 1;        %tauy = tauy*0.995;
opt.alphaz = 0.001;   %帧波惩罚参数
opt.tauz = 0.005;     %帧波正则化
opt.mu = 0.002;      %低秩分量的正则化参数
opt.MU = 1;        %opts.mu = opts.mu * 0.995;
opt.miu = 0.06;           %帧波参数
opt.MaxIter = 400; %最大迭代次数 for stripelevel 10, when iter reach to 300, PSNR curve go down
opt.Level = 4;
opt.frame = 1;
opt.wLevel = 0.5;
%para setting

opt.kernel_size =15;   %预估 PSF大小
opt.Innerloop_B =5;
opt.tol = 1e-6;  %迭代停止误差, 1e-6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 第二阶段：非盲图像恢复去条带
Path_ori = 'D:\caoshuning\caoshuning\spot5\gt\';

% Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\degradation2098\Nonperiodical\G\';
Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\spot5(1)-degradation\';
suffix = '.tif';
Gs = dir(fullfile(Path_G,strcat('*',suffix)));

Path_K = 'D:\caoshuning\caoshuning\TEST_github\dataset\degradation2098\Nonperiodical\K\';
suffix = '.tif';
Ks = dir(fullfile(Path_K,strcat('*',suffix)));

Path_Hr = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\h_refine\';%h_refine
suffix = '.mat';
Hrs = dir(fullfile(Path_Hr,strcat('*',suffix)));

Path_H = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\h\';%h
suffix = '.mat';
H = dir(fullfile(Path_H,strcat('*',suffix)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%save path
Path_est_S = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\est_S\';%est_S
Path_U = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\U\';%U
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[file_ori, path_ori] = uigetfile([Path_ori,'*.tif']);%read ori image
ori = im2double(imread([ path_ori,file_ori]));

[file_Hr, path_Hr] = uigetfile([Path_Hr,'*.mat']);%load h_refine
load([path_Hr, file_Hr]);

% [file_K, path_K] = uigetfile([Path_K,'*.tif']);%load K
% K = im2double(imread([ path_K,file_K]));
% % 
% [file_H, path_H] = uigetfile([Path_H,'*.mat']);%load h
% load([path_H, file_H]);

[file_G, path_G] = uigetfile([Path_G,'*.tif']);%read G
G = im2double(imread([ path_G,file_G]));

Gname = file_G;

stripe_level = str2double(Gname(end-9:end-8));
SIG = str2double(SIG);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
opt = Para2(stripe_level, SIG);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[u, s] = image_destripe(G,h_refine, ori, opt);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
obs_psnr = psnr(ori, G);
obs_ssim = ssim(ori, G);
res_psnr = psnr(ori, u);
res_ssim = ssim(ori, u);
fprintf(['Proposed ','image:(spot5: ',Gname,'),',' PSNR_g = %2.4f,',' SSIM_g = %2.4f,',...
' PSNR_u = %2.4f,',' SSIM_u = %2.4f\n'],obs_psnr,obs_ssim,res_psnr,res_ssim);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imagesc(u);colormap(gray); axis off; axis equal;
print(gcf,'-depsc2',[Path_U,Gname(1:end-4),'.eps'],'-r600')
imwrite(u,[Path_U,Gname(1:end-4),'.tif']);

imagesc(s);colormap(gray); axis off; axis equal;
print(gcf,'-depsc2',[Path_est_S,Gname(1:end-4),'.eps'],'-r600')
imwrite(s,[Path_est_S,Gname(1:end-4),'.tif']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%