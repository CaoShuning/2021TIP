function result = MeanDN(PMMWimg)
tempImg = PMMWimg;
[M,N] = size(tempImg);
AvgValue = zeros(1,M);
for i = 1:M
    AvgValue(1,i) = mean(tempImg(i,:));
end
result = AvgValue;
end