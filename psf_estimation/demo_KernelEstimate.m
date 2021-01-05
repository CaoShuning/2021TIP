%code for kernel estimation
clc, clear all; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load degradation images kernel
<<<<<<< HEAD
Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\real\';
[file, path] = uigetfile([Path_G, '*.tif']);              %get degraded image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%save path
SavePath = 'C:\Users\caoshuning\Desktop\Submit_text\result\real\Proposed\h_1226\';
=======
% [file, path] = uigetfile('*.png');              %get degraded image
Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\spot5(1)-degradation\';% simulated data
suffix = '.tif';
Gs = dir(fullfile(Path_G,strcat('*',suffix)));

Path_K = 'D:\caoshuning\caoshuning\TEST_github\dataset\degradation2098\Nonperiodical\K\';
suffix = '.tif';
Ks = dir(fullfile(Path_K,strcat('*',suffix)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%save path
SavePath = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\Proposed\h_1001\';
>>>>>>> 79b7b7b88e8b3cfe379b2c435dbbd56f66658257
if exist(SavePath,'dir') == 0
    mkdir(SavePath);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

<<<<<<< HEAD
%para setting for real data
lambda = 5; gamma = 5; 
MK =15;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
y_gray = im2double(imread([path, file]));
[u_dy, h] = destripeDeblur(y_gray,lambda, gamma, MK);
imwrite(h,[SavePath,'h_', num2str(lambda),'_' num2str(gamma), '_',file(1:end-4),'.tif']);
parsave([SavePath,'h_', num2str(lambda),'_' ,num2str(gamma),'_',file(1:end-4),'.mat'], h, lambda, gamma);    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function parsave(fname,  h, lambda, gamma)
    save(fname, 'h', 'lambda', 'gamma','-v6');
=======
%para setting
% lambda = 5; gamma = 30; 
MK =15;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(Gs)
    
    y_gray = im2double(imread([Path_G, Gs(i).name]));
    K = im2double(imread([Path_K, Gs(i).name]));
%     if str2double(Gs(i).name(end-10:end-8)) ~= 100
        SIG = str2double(Gs(i).name(end-15:end-13));
%     elseif str2double(Gs(i).name(end-16:end-14))
%         SIG = str2double(Gs(i).name(end-16:end-14));
%     end
    [lambda, gamma] = Para1(SIG);
%     if str2double(Gs(i).name(end-9:end-8)) ~= 20
        [u_dy, h] = destripeDeblur(y_gray,lambda, gamma, MK);
        NMSE_PSF = norm(h - K, 'fro')/norm(h, 'fro');
        PSNR_PSF = psnr(h, K);
        SIG = Gs(i).name(3:5);
        SIZ = Gs(i).name(7);
        imwrite(h,[SavePath,'h', '_', Gs(i).name]);
        parsave([SavePath,'h',Gs(i).name(1:end-4),'.mat'], SIG, SIZ, h, K, NMSE_PSF, PSNR_PSF, lambda, gamma);
%     end    
end    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function parsave(fname, SIG, SIZ, h, K, NMSE_PSF, PSNR_PSF, lambda, gamma)
    save(fname,'SIG', 'SIZ', 'h', 'K', 'NMSE_PSF', 'PSNR_PSF', 'lambda', 'gamma','-v6');
>>>>>>> 79b7b7b88e8b3cfe379b2c435dbbd56f66658257
end