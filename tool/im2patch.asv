clc; clear all; close all;
datapath = 'D:\caoshuning\caoshuning\TEST_github\dataset\';
IMGname = 'zy1_02c.tif';
CropSize = 256;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
savepath = [datapath, IMGname(1:end-4), '\', CropSize, '\';];
if~exist(savepath, 'dir')
    mkdir(savepath);
end

suffix = '.tif';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F = imread([datapath, IMGname]);
[H, W, C] = size(F);

Num = (H/100)*(W/100);
% Num = floor((H*W)/CropSize);
% rng(1);
% POSITION_H = randperm(H-CropSize,H/100);
% POSITION_W = randperm(W-CropSize,W/100);
% for i = 1:length(POSITION_H)
%     for j = 1:length(POSITION_W)
% %         position = [POSITION_H(i), POSITION_H(i)+CropSize-1, POSITION_W(j), POSITION_W(j)+CropSize-1];
%         Patch = F(POSITION_H(i):POSITION_H(i)+CropSize-1, POSITION_W(j):POSITION_W(j)+CropSize-1);
%         position = ['(',num2str(POSITION_H(i)), ',' ,num2str(POSITION_W(j)),')'];
%         imshow(Patch);
%         imwrite(Patch, [savepath, position, suffix]);
%     end
% end

for i = 1:Num
    POSITION_H = randperm(H-CropSize,1);
    POSITION_W = randperm(H-CropSize,1);
    Patch = F(POSITION_H:POSITION_H+CropSize-1, POSITION_W:POSITION_W+CropSize-1);
    position = ['(',num2str(POSITION_H), ',' ,num2str(POSITION_W),')'];
    imshow(Patch);
    imwrite(Patch, [savepath, position, suffix]);
end

