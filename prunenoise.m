function k =  prunenoise(k)
CC = bwconncomp(k,8); %bwconncomp(k, 8)是找出二值图像k中所有的连接体
for ii=1:CC.NumObjects
    currsum = sum(k(CC.PixelIdxList{ii}));
    if currsum < 0.1 %old 0.1
        k(CC.PixelIdxList{ii}) = 0;
    end
end
k(k<0) = 0;
k=k/sum(k(:));