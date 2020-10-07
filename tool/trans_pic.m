clc,clear all;
close all;
addpath(genpath('D:\caoshuning\caoshuning\TEST_github'));
addpath(genpath('C:\Users\caoshuning\Desktop\latexCVPR_final\picture\fig2\'))
imagePath = 'C:\Users\caoshuning\Desktop\latexCVPR_final\picture\fig2\';
files = dir(fullfile(imagePath, strcat('*','.png')));
% filename = 'D:\caoshuning\caoshuning\TEST_github\DestripeReference\spot\spot5(2).tif';
for i = 1:length(files)
ori = rgb2gray(imread(files(i).name));
ori1 = imcomplement(10.*ori);
% [g,s,K] = demo_GenerateBlur(ori,0.7, 9, 0, 15);
imshow(ori);axis off; axis equal;
% figure,imagesc(g);colormap(gray); axis off; axis equal;
saveName = sprintf('%s',imagePath,'\',files(i).name(1:end-4),'.eps');
print(gcf,'-depsc2',saveName,'-r600');
end