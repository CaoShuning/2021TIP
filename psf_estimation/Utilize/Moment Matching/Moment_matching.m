%将矩匹配法做成一个非常普适性的方法
clc;
close all;
clear all;


[filename,filepath] = uigetfile('E:\CY\data\*.*','Read Images');
inputdata = imread(fullfile(filepath,filename));
inputdata = inputdata';
figure,imshow(mat2gray(inputdata'));title('Input Image');
[M,N] = size(inputdata);
averageValue = MeanDN(inputdata);
figure;plot(averageValue);xlim([1,M]);ylim([0,250]);title('Before profiles');

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


for i = 1 :size(kk,1)
    for j = 1 : N
        OutputImg(kk(i),j) = (inputdata( kk(i) ,j ) - meanStr(kk(i)))*(stdRef(kk(i))/stdStr(kk(i))) + meanRef(kk(i));
    end
end
% for i = 2 :10: M
%     for j = 1 : N
%         OutputImg(i,j) = (inputdata( i ,j ) - meanStr(i))*(stdRef(i)/stdStr(i)) + meanRef(i);
%     end
% end



OutputImg(OutputImg<0)=0;
OutputImg(OutputImg>255)=255;
averageValue = MeanDN(OutputImg);
figure;plot(averageValue);xlim([1,M]);ylim([0,250]);title('After profiles');
figure,imshow(uint8(OutputImg'));title('去条带结果');
grid on
