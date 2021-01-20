%����ƥ�䷨����һ���ǳ������Եķ���
clc;
close all;
clear all;


[filename,filepath] = uigetfile('E:\CY\data\*.*','Read Images');
inputdata = imread(fullfile(filepath,filename));
% load('..\data\PMMW');
% inputdata = PMMW;
figure,imshow(mat2gray(inputdata'));title('Input Image');
[M,N] = size(inputdata);
averageValue = MeanDN(inputdata);
figure;plot(averageValue);xlim([1,M]);ylim([70,170]);title('Before profiles');
% inputdata = inputdata';

%% ��8��������������ֱ��ͼͳ��
% histArray = zeros(M,N);
% inputdata = uint8(inputdata);
% for i = 1 : M
%     histArray(i,:) = imhist(inputdata(i,:));
% end
% figure,plot(histArray(10,:));xlim([1,256]);ylim([0,255]);title('Gray histgram');

%% ȥ��ֱ��ͼ��ǰ��1%,��Լǰ����3����
meanStr = zeros( M,1 );
stdStr = zeros( M,1 );

for i = 1:M
    %����һ�����е�ֵ��һ�����򣬼�ȥǰ��3��������С��ֵ
    truncatedRow = sort(inputdata(i,:));
    CutNum = ceil( M*0.01 );
    truncatedRow([1:CutNum, N-CutNum+1:N] ) = [];
    
    
    truncatedRow = double(truncatedRow);
    meanStr(i) = mean( truncatedRow );
    stdStr(i) = std( truncatedRow );
end

%% �Ծ�ֵ�ͷ�������ȡ�м��ֵ,��Ϊ�ο��ľ�ֵ�ͷ���
%������Ҫ֪�������е�����
period = 10;
meanRef = zeros( M,1 );
stdRef = zeros( M,1 );
for i = 1:period:M-10
temp1 = sort(meanStr(i:i+period-1));
meanVal = temp1( floor(period/2) );

temp2 = sort(stdStr(i:i+period-1));
stdVal = temp2( floor(period/2) );
meanRef( i:i+period-1 ) = meanVal;
stdRef( i:i+period-1 ) = stdVal;
end

%% �Ǿ����Ե�У��
inputdata = double( inputdata );
OutputImg = inputdata;

for i = 2 :10: M
    for j = 1 : N
        OutputImg(i,j) = (inputdata( i ,j ) - meanStr(i))*(stdRef(i)/stdStr(i)) + meanRef(i);
    end
end
OutputImg(M,:) = OutputImg(M-1,:);
averageValue = meanDN(OutputImg);
figure;plot(averageValue);xlim([1,M]);ylim([70,170]);title('After profiles');
figure,imshow(mat2gray(OutputImg'),[]);title('ȥ�������');
grid on

%%% ����ID
imgori = inputdata;
imgdestriped = OutputImg;

% [Q0 w] = periodo(transpose(imgori));
% [Q1 w] = periodo(transpose(imgdestriped));

[Q0 w] = periodogram(imgori(:));
[Q1 w] = periodogram(imgdestriped(:));

ID = 1 - 1/max(size(Q0)).*(sum(abs(Q1(:)-Q0(:))./(Q0(:))));

%% ROF filter process
ROF_filter = [0 0.25 0;0.25 0 0.25;0 0.25 0];
ROF_output = conv2(ROF_filter,imgdestriped);
ROF_output = ROF_output(2:M+1,2:N+1);
figure,imshow(mat2gray(ROF_output'),[]);title('ȥ�������');