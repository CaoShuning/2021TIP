%this is a code for jointly non-blind deblurring ande destriping for
%real data
clc; clear all; close all; 
addpath(genpath('Images\'));
addpath(genpath('psfestimation\'));
addpath(genpath('destriping\'));
addpath(genpath('PROPACK\'));
addpath(genpath('boundary_proc_code\'));
addpath(genpath('framelet\'));
% addpath(genpath('D:\caoshuning\caoshuning\TEST_github\'))
%% 第二阶段：非盲图像恢复去条带

%% 第二阶段非盲反卷积去条带恢复图像
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load degradation images kernel
% [file, path] = uigetfile('*.png');              %get degraded image
% Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\degradation2098\Nonperiodical\G\';
Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\Degrade1226\g\';
[file_G, path_G] = uigetfile([Path_G, '*.tif']);              %get degraded image

Path_GT = 'D:\caoshuning\caoshuning\spot5\gt\';
[file_GT, path_GT] = uigetfile([Path_GT, '*.tif']);              %get degraded image

Path_Hr = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\Proposed\h_refine_1226\';%h_refine
[file_Hr, path_Hr] = uigetfile([Path_Hr, '*.mat']);
% Path_H = 'C:\Users\caoshuning\Desktop\Submit_text\result\real\Proposed\h\';%h
% suffix = '.mat';
% H = dir(fullfile(Path_H,strcat('*',suffix)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%save path
Path_est_S = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\Proposed\est_S_1226\';%est_S
if ~exist(Path_est_S,'dir')
    mkdir(Path_est_S);
end
Path_U = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\Proposed\U_1226\';%U
if ~exist(Path_U,'dir')
    mkdir(Path_U);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([Path_Hr, file_Hr]);
% h = im2double(imread([Path_H, 'h_', Gs(i).name]));
G = im2double(imread([path_G, file_G]));
GT = im2double(imread([path_GT, file_GT]));
s_level = str2num(file_G(end-5:end-4));
sig = str2num(file_G(end-9:end-7));
[opt] = Para2(s_level, sig);
[u, s] = image_destripe(G,h_refine, GT, opt);
   

imagesc(u);colormap(gray); axis off; axis equal;
print(gcf,'-depsc2',[Path_U, file_G,'.eps'],'-r600')
imwrite(u,[Path_U,file_G,'.tif']);
    
imagesc(s);colormap(gray); axis off; axis equal;
print(gcf,'-depsc2',[Path_est_S,file_G,'.eps'],'-r600')
imwrite(s,[Path_est_S,file_G,'.tif']);

% close all;
figure;imagesc(u);colormap(gray); axis off; axis equal;
figure;imagesc(G);colormap(gray); axis off; axis equal;

psnrnG = psnr(G, GT);
ssimnG = ssim(G, GT);
sprintf([file_G, 'G:', 'PSNR=', num2str(psnrnG), ',', 'SSIM=', num2str(ssimnG)])

psnrnU = psnr(u, GT);
ssimnU = ssim(u, GT);
sprintf([file_G, 'U:', 'PSNR=', num2str(psnrnU), ',', 'SSIM=', num2str(ssimnU)])


