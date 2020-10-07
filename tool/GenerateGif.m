function GenerateGif()
for i=5:-1:0
    str = strcat('ԭͼ_',num2str(i), '_blur.png');
    A=im2double(imread(str));
    A_rgb(:,:,1)=A;
    A_rgb(:,:,2)=A;
    A_rgb(:,:,3)=A;
    [I,map]=rgb2ind(A_rgb,256);
    if(i==5)
        imwrite(I,map,'ԭͼ_1.gif','DelayTime',1,'LoopCount',Inf)
    else
        imwrite(I,map,'ԭͼ_1.gif','WriteMode','append','DelayTime',1)    
    end
end

A_rgb=[];
for i=5:-1:0
    str = strcat('bridge_128_',num2str(i), '_blur.png');
    A=im2double(imread(str));
    A_rgb(:,:,1)=A;
    A_rgb(:,:,2)=A;
    A_rgb(:,:,3)=A;
    [I,map]=rgb2ind(A_rgb,256);
    if(i==5)
        imwrite(I,map,'bridge_128_1.gif','DelayTime',1,'LoopCount',Inf)
    else
        imwrite(I,map,'bridge_128_1.gif','WriteMode','append','DelayTime',1)    
    end
end
end