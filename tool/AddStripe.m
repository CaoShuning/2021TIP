clc, clear all; close all;
datapath = 'D:\caoshuning\caoshuning\TEST_github\dataset\zy1-02c_256\f\';
savepath_g = 'D:\caoshuning\caoshuning\TEST_github\dataset\zy1-02c_256\g\';
savepath_s = 'D:\caoshuning\caoshuning\TEST_github\dataset\zy1-02c_256\s\';

FILE = dir(fullfile([datapath, '*.tif']));
S_LEVEL = 10;
for i = 1:length(FILE)
    f = im2double(imread([datapath, FILE(i).name]));
    [g, s] = Stripe(f, S_LEVEL);
    imwrite(g, [savepath_g, FILE(i).name(1:end-4), '_', num2str(i), '_', num2str(S_LEVEL), '.tif']);
    imwrite(s, [savepath_s, FILE(i).name(1:end-4), '_', num2str(i), '_', num2str(S_LEVEL), '.tif']);
end


function [g, s] = Stripe(f, S_LEVEL)
    [H, W] = size(f);
    s = zeros(H, W);
    S_INT = 2*S_LEVEL.*rand(1, W) - S_LEVEL;
    for i = 1:H
        s(i,:) = S_INT./255;
    end
    g = f + s;
end