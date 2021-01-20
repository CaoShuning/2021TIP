% WFAF destriping code used in Pande-Chhetri & Abd-Elrahman (2011).
% WFAF stands for Wavelet Frequency Adaptive filtering.
% 3 parameters are input - no of decomposition level, wavelet type and adaptive threshold k value.
% Proposed algorithm is based on and refinement of the algorithms proposed by Torres & Infante (2001) and Munch et al(2009).

clear all; 
close all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Path_Ori = 'D:\caoshuning\code_DestripeDeblur\Data\ori\';

% Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\degradation2098\Nonperiodical\G\';
Path_G = 'D:\caoshuning\code_DestripeDeblur\Data\simulation\19-Jan-2021\G\';
suffix = '.tif';
Gs = dir(fullfile(Path_G,strcat('*',suffix)));

date = '19-Jan-2021';
%save path
Path_est_S = ['C:\Users\caoshuning\Desktop\Submit_text\result\simulation\WFAF\',date ,'\est_S\'];%est_S
if ~exist(Path_est_S,'dir')
    mkdir(Path_est_S)
end
Path_F = ['C:\Users\caoshuning\Desktop\Submit_text\result\simulation\WFAF\',date ,'\F\'];%U
if ~exist(Path_F,'dir')
    mkdir(Path_F)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for file_i = 166:length(Gs)
%     [ filename, pathname ] = uigetfile('D:\caoshuning\caoshuning\TEST_github\dataset\degrade66/*.*', 'load image');
%     I = double(imread( fullfile( pathname, filename ) ));
    ori = im2double(imread([Path_Ori, Gs(file_i).name(1),'.tif']));
    Is = im2double(imread([Path_G, Gs(file_i).name]));
    %  rand('seed',0);
    % kk = randperm(307,107);
    %  Is(:,kk(1:30))=I(:,kk(1:30))-40; Is(:,kk(31:60))=I(:,kk(31:60))+35; Is(:,kk(61:90))=I(:,kk(61:90))-35;Is(:,kk(91:107))=I(:,kk(91:107))+25;
    % img = Is;
    % figure, imshow(img,[]);
    img = Is;
    %% User input parameters
    numlev = 4;
    wavtyp = 'db2';
    k = 1;

%     tic
    % wavelet decomposition
    for i=1:numlev
       [img,hd{i},vd{i},dd{i}] =dwt2(img,wavtyp);
    end

    %%% FFT transform
    vd = adpative_FFT( vd, numlev,k);

    % Reconstruction
    newimg=img;
    for i=numlev:-1:1
       newimg=newimg(1:size(hd{i},1),1:size(hd{i},2));
       newimg=idwt2(newimg,hd{i},vd{i},dd{i},wavtyp);
    end
    [H,W] = size(ori);
    newimg = newimg(1:H,1:W);
%     figure,imshow(newimg,[]);
%     toc
    G = Is;
    s = Is - newimg;
    f = newimg;
    obs_psnr = psnr(ori, G);
    obs_ssim = ssim(ori, G);
    res_psnr = psnr(ori, f);
    res_ssim = ssim(ori, f);
    fprintf(['Proposed ','image:(spot5: ',Gs(file_i).name,'),',' PSNR_g = %2.4f,',' SSIM_g = %2.4f,',...
    ' PSNR_f = %2.4f,',' SSIM_f = %2.4f\n'],obs_psnr,obs_ssim,res_psnr,res_ssim);
    
    imagesc(f);colormap(gray); axis off; axis equal;
    print(gcf,'-depsc2',[Path_F,Gs(file_i).name(1:end-4),'.eps'],'-r600')
    imwrite(f,[Path_F,Gs(file_i).name(1:end-4),'.tif']);
    
    imagesc(s);colormap(gray); axis off; axis equal;
    print(gcf,'-depsc2',[Path_est_S,Gs(file_i).name(1:end-4),'.eps'],'-r600')
    imwrite(s,[Path_est_S,Gs(file_i).name(1:end-4),'.tif']);
    close all;
end