clc;
clear all;
close all;

[filename,filepath] = uigetfile('F:\hdfÊı¾İ\*.*','Read a image');
inputdata = imread(fullfile(filepath,filename));
inputdata =inputdata';
figure;imshow(uint8(inputdata));title('original image');
pouxiantu(inputdata);
power_spectrum(inputdata);
[m,n]=size(inputdata);
outputdata = inputdata;
for i=2:n-3
        if(mod(i,10)==2)
            h1 = imhist(inputdata(i-1,:));
            g1 = histeq(inputdata(i,:),h1);
            outputdata(i,:) = g1;
        end
        if(mod(i,10)==4)
            h1 = imhist(inputdata(i-1,:));
            g1 = histeq(inputdata(i,:),h1);
            outputdata(i,:) = g1;
        end
        if(mod(i,10)==5)
            h1 = imhist(inputdata(i-2,:));
            g1 = histeq(inputdata(i,:),h1);
            outputdata(i,:) = g1;
        end

        if(mod(i,10)==8)
            h1 = imhist(inputdata(i-1,:));
            g1 = histeq(inputdata(i,:),h1);
            outputdata(i,:) = g1;
        end
        
        if(mod(i,10)==9)
            h1 = imhist(inputdata(i+1,:));
            g1 = histeq(inputdata(i,:),h1);
            outputdata(i,:) = g1;
        end
       
end

figure;imshow(uint8(outputdata));title('Destriping image');
pouxiantu(outputdata);
power_spectrum(outputdata);
NR = Fun_NR(inputdata,outputdata);
ICV1 = Fun_ICV( outputdata(100:109,100:109));
ICV2 = Fun_ICV( outputdata(200:209,200:209));
[Q0 w] = periodo(transpose(inputdata));
[Q1 w] = periodo(transpose(outputdata));
ID = 1 - 1/max(size(Q0)).*(sum( abs(Q1(:)-Q0(:))./(Q0(:)) ) );
lowpass_output = lowpass_filter( inputdata );
[ IF1 IF2 ] = Fun_IF( inputdata ,outputdata,lowpass_output);

