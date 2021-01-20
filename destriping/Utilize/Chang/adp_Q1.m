function     [Q,P] = adp_Q1(image)

inputdata = image;
% image_temp = image;
% if k ==1
% inputdata = anisodiff2D(image_temp, 10, 1/7, 4, 2);
% end
% if k>1
%     inputdata = image;
% end
[r,c] = size(image);
Q = 1*ones(r,c);
P =ones(r,c);

A = zeros(c,1);
B = zeros(c,1);
C = zeros(c,1);
D = zeros(c,1);
for i = 1:c-1
    A(i,1) = length(find((inputdata(i,:) - inputdata(i+1,:))>10));
    B(i,1) = length(find((inputdata(i+2,:) - inputdata(i+1,:))>10));
    C(i,1) = length(find((inputdata(i+1,:) - inputdata(i,:))>10));
    D(i,1) = length(find((inputdata(i+1,:) - inputdata(i+2,:))>10));
    if (A(i,1)/r>0.9)&&(B(i,1)/r>0.9)
        Q(i+1,:) = 0;
        P(i+1,:) = 10;
    end
    if (C(i,1)/r>0.9)&&(D(i,1)/r>0.9)
        Q(i+1,:) = 0;
        P(i+1,:) = 10;
    end
end