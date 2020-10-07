clc,clear all;
filePath1 = 'C:\Users\caoshuning\Desktop\caoshuning\caoshuning\Kernel_modify\data729\results_729';
filePath2 = 'C:\Users\caoshuning\Desktop\caoshuning\caoshuning\Kernel_modify\data729\test';
% filePath3 = 'C:\Users\caoshuning\Desktop\caoshuning\caoshuning\Kernel_modify\test2\label';
suffix1 = '.png';
suffix2 = '.mat';
% suffix3 = '.tif';
files1 = dir(fullfile(filePath1,strcat('*', suffix1)));
files2 = dir(fullfile(filePath2,strcat('*', suffix2)));
% files3 = dir(fullfile(filePath3,strcat('*', suffix3)));
for file_i = 1:length(files1)
    filename1 = files1(file_i).name;
    k1 = im2double(imread(strcat(filePath1,'\',files1(file_i).name)));
    k1Amp = imresize(im2double(k1), 10);
    filenameAmp1 = sprintf('%s%s%s%s', filename1(1:end-4),'_','amp','.tif');
    
    
    filename2 = files2(file_i).name;
%     h = imread(strcat(filePath2,'\',files2(file_i).name));
    I = load([filePath2,'\',files2(file_i).name]);
    h = I.x3;
    k = I.x4;
    hAmp = imresize(im2double(h), 10);
    kAmp = imresize(im2double(k), 10);
%     filenameAmp2 = sprintf('%s%s%s%s', filename2(1:end-4),'_','amp','.tif');

%     
%     filename3 = files3(file_i).name;
%     k = imread(strcat(filePath3,'\',files3(file_i).name));
%     kAmp = imresize(im2double(k), 10);
%     filenameAmp3 = sprintf('%s%s%s%s', filename3(1:end-4),'_','amp','.tif');
    
    figure(1);imagesc(k1),colormap(gray);
%     figure(1);imagesc(k1Amp),colormap(gray);
%     imwrite(k1Amp, filenameAmp1);
    
    figure(2);imagesc(h),colormap(gray);
%     figure(1);imagesc(k1Amp),colormap(gray);
%     imwrite(h, filenameAmp2);
    
    figure(3);imagesc(k),colormap(gray);
%     figure(1);imagesc(k1Amp),colormap(gray);
%     imwrite(k, filenameAmp3);
    
    NMSE = norm(im2double(k)-im2double(k1),'fro')/norm(im2double(k1),'fro');
    PSNR = psnr(im2double(k), im2double(k1));
    PSNR_BAD = psnr(im2double(k), im2double(h));
    resdual = k1Amp - kAmp;
%     [row, column] = size(resdual);
%     [X, Y] = meshgrid(1:row, 1:column);
%     mesh(X, Y, resdual);
%     axis(1 row 1 column )
end