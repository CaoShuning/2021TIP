%this is a code for jointly non-blind deblurring ande destriping for
%simulation data
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
Path_Ori = 'D:\caoshuning\code_DestripeDeblur\Data\ori\';
[file_Ori, path_Ori] = uigetfile([Path_Ori, '*.tif']);

Path_G = 'D:\caoshuning\code_DestripeDeblur\Data\simulation\19-Jan-2021\G\';
[file_G, path_G] = uigetfile([Path_G, '*.tif']);              %get degraded image

Path_Hr = ['C:\Users\caoshuning\Desktop\Submit_text\result\simulation\Proposed\',date ,'\h_refine\'];%h_refine
[file_Hr, path_Hr] = uigetfile([Path_Hr, '*.mat']);
% Path_H = 'C:\Users\caoshuning\Desktop\Submit_text\result\real\Proposed\h\';%h
% suffix = '.mat';
% H = dir(fullfile(Path_H,strcat('*',suffix)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%save path
Path_est_S = ['C:\Users\caoshuning\Desktop\Submit_text\result\simulation\Proposed\',date ,'\est_S\'];%est_S
if ~exist(Path_est_S,'dir')
    mkdir(Path_est_S);
end
Path_U = ['C:\Users\caoshuning\Desktop\Submit_text\result\simulation\Proposed\',date ,'\U\'];%U
if ~exist(Path_U,'dir')
    mkdir(Path_U);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([Path_Hr, file_Hr]);
imagesc(h_refine);colormap(gray); axis off; axis equal;
% h = im2double(imread([Path_H, 'h_', Gs(i).name]));
G = im2double(imread([path_G, file_G]));
Ori = im2double(imread([path_Ori, file_Ori]));

% [opt] = Para4real(file_G);
[opt] = Para2(10, 1.6);
[u, s] = image_destripe(G,h_refine, Ori, opt);

figure;imagesc(u);colormap(gray); axis off; axis equal;
print(gcf,'-depsc2',[Path_U, file_G,'.eps'],'-r600')
imwrite(u,[Path_U,file_G,'.tif']);
    
imagesc(s);colormap(gray); axis off; axis equal;
print(gcf,'-depsc2',[Path_est_S,file_G,'.eps'],'-r600')
imwrite(s,[Path_est_S,file_G,'.tif']);

close all;
figure;imagesc(u);colormap(gray); axis off; axis equal;
figure;imagesc(G);colormap(gray); axis off; axis equal;


