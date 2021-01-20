clc, clear all; close all;
%paras setting
sig = [1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0, 2.1];
s_level = [10, 20, 30];
suffix = '.tif';
%data path
ORIpath = '..\data\Ori\';
% ORI = dir(fullfile([ORIpath, {'*.tif', '*.png', '*.bmp', '*.jpg'}]));
ORI = dir(fullfile([ORIpath, '*.tif']));
 
%save path
TYPE = 'simulation';
% TYPE = 'real';
date = '19-Jan-2021\';

Gpath = ['..\data\', TYPE, '\', date ,'\G\'];
Fpath = ['..\data\', TYPE, '\', date ,'\F\'];
Kpath = ['..\data\', TYPE, '\', date ,'\K\'];
Spath = ['..\data\', TYPE, '\', date ,'\S\'];

if ~exist(Gpath,'dir')
    mkdir(Gpath);
end
if ~exist(Fpath,'dir')
    mkdir(Fpath);
end
if ~exist(Kpath,'dir')
    mkdir(Kpath);
end
if ~exist(Spath,'dir')
    mkdir(Spath);
end

for i = 5:length(ORI)
    IMGname = ORI(i).name;
    I = imread([ORIpath, IMGname]);
    I = im2double(I);
    for j = 1:length(sig)
        SIG = sig(j);
        
        for m = 1:length(s_level)
            S_LEVEL = s_level(m);
            
            [G, F, K, S] = Degradation(I, SIG, S_LEVEL);
            
            imwrite(G, [Gpath, ORI(i).name(1:end-4), '_', num2str(SIG), '_', num2str(S_LEVEL), suffix]);
            imwrite(F, [Fpath, ORI(i).name(1:end-4), '_', num2str(SIG), '_', num2str(S_LEVEL), suffix]);
            imwrite(K, [Kpath, ORI(i).name(1:end-4), '_', num2str(SIG), '_', num2str(S_LEVEL), suffix]);
            imwrite(S, [Spath, ORI(i).name(1:end-4), '_', num2str(SIG), '_', num2str(S_LEVEL), suffix]);
        end
    end
end


function [g, f, k, s] = Degradation(I, SIG, S_LEVEL)
    [H, W] = size(I);
    s = zeros(H, W);
    KERNEL_SIZE = 15;
    k = fspecial('gaussian', KERNEL_SIZE, SIG);
    f = conv2c(I, k);
    S_INT = 2*S_LEVEL.*rand(1, W) - S_LEVEL;
    for i = 1:H
        s(i,:) = S_INT./255;
    end
    g = f + s;
end