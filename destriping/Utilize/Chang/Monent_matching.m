%将矩匹配法做成一个非常普适性的方法
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

%% 对8个传感器的行做直方图统计
% histArray = zeros(M,N);
% inputdata = uint8(inputdata);
% for i = 1 : M
%     histArray(i,:) = imhist(inputdata(i,:));
% end
% figure,plot(histArray(10,:));xlim([1,256]);ylim([0,255]);title('Gray histgram');

%% 去掉直方图的前后1%,大约前后都是3个点
meanStr = zeros( M,1 );
stdStr = zeros( M,1 );

for i = 1:M
    %将这一行所有的值做一个排序，减去前后3个最大和最小的值
    truncatedRow = sort(inputdata(i,:));
    CutNum = ceil( M*0.01 );
    truncatedRow([1:CutNum, N-CutNum+1:N] ) = [];
    
    
    truncatedRow = double(truncatedRow);
    meanStr(i) = mean( truncatedRow );
    stdStr(i) = std( truncatedRow );
end

%% 对均值和方差排序，取中间的值,作为参考的均值和方差
%这里需要知道条带行的周期
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

%% 非均匀性的校正
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
figure,imshow(mat2gray(OutputImg'),[]);title('去条带结果');
grid on

%%% 计算ID
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
figure,imshow(mat2gray(ROF_output'),[]);title('去条带结果');