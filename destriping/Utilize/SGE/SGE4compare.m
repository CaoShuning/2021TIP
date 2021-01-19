clear all; 
close all;
clc;
%%% 加载文件夹
addpath(genpath('images\'));
addpath(genpath('Codes\'));
%% 读取或加载图像
Path_ori = 'D:\caoshuning\caoshuning\spot5\gt\';

% Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\degradation2098\Nonperiodical\G\';
Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\spot5(1)-degradation\';
suffix = '.tif';
Gs = dir(fullfile(Path_G,strcat('*',suffix)));

%save path
Path_est_S = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\SGE\915\est_S\';%est_S
if ~exist(Path_est_S,'dir')
    mkdir(Path_est_S)
end
Path_F = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\SGE\915\F\';%U
if ~exist(Path_F,'dir')
    mkdir(Path_F)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [filename, filepath, FilterIndex ] = uigetfile('D:\caoshuning\caoshuning\TEST_github\dataset\degrade66/*.*','Read image');
for i = 1:length(Gs)   
    ori = im2double(imread([Path_ori, Gs(i).name(1),'.tif']));
    y = im2double(imread([Path_G, Gs(i).name]));
    % y =  double(rgb2gray(imread(fullfile(filepath,filename))));
%     y = y/256;
    [R,C] = size(y);
    % g_th = 1 + .1*randn(1,C);
    % 
    % for c=1:C;
    %     y(:,c) = y(:,c)*g_th(c);
    % end

    n_it = 20;
    phi=2;
    s=0.1;
    lambda = 1000;

    % Matrices I and D (sparse structure)
    D = spdiags([ones(C-1,1),-ones(C-1,1)],0:1,C-1,C);
    I = speye(C,C);
    % Dyl = D*log(y)';
    Dyl = D*y';
    gl = zeros(C,1); % Initialization
    for it=1:n_it    % Iterations
        b = zeros(C-1,1);
        w = zeros(C-1,1);
        % Compute b and W from eq. (12)
        for r=1:R    % Sweeping rows
            w_r = phiprimeover2x(D*gl-Dyl(:,r),phi,s);
            b = b + w_r.*Dyl(:,r);
            w = w + w_r;
        end
        % Sparse matrix W
        W = spdiags(w,0,C-1,C-1);
        % Solve tridiagonal system of eq. (13)
        gl = (D'*W*D + lambda*I)\(D'*b);
    end
    g = gl;
    y_c = y;
    for c=1:C
        y_c(:,c) = y_c(:,c)-g(c);
    end
    figure,imshow(y,[]);
    figure,imshow(y_c,[])
    figure,plot(g,'r');
%     imwrite(y_c,['D:\caoshuning\caoshuning\TEST_github\result65\SGE\','f_',filename]);
    G = y;
    f = y_c;
    s = G - f;
    obs_psnr = psnr(ori, G);
    obs_ssim = ssim(ori, G);
    res_psnr = psnr(ori, f);
    res_ssim = ssim(ori, f);
    fprintf(['Proposed ','image:(spot5: ',Gs(i).name,'),',' PSNR_g = %2.4f,',' SSIM_g = %2.4f,',...
    ' PSNR_f = %2.4f,',' SSIM_f = %2.4f\n'],obs_psnr,obs_ssim,res_psnr,res_ssim);
    
    imagesc(f);colormap(gray); axis off; axis equal;
    print(gcf,'-depsc2',[Path_F,Gs(i).name(1:end-4),'.eps'],'-r600')
    imwrite(f,[Path_F,Gs(i).name(1:end-4),'.tif']);
    
    imagesc(s);colormap(gray); axis off; axis equal;
    print(gcf,'-depsc2',[Path_est_S,Gs(i).name(1:end-4),'.eps'],'-r600')
    imwrite(s,[Path_est_S,Gs(i).name(1:end-4),'.tif']);
    close all;
%     return;
end
