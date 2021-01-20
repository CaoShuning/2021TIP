function     [Q,P] = adp_Q(image,k)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

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
sum_row = zeros(1,c);
        for i=1:r
           sum_row(i) = sum(inputdata(i,:))./c;
        end
        for i=1:r-2
            if ((sum_row( i ) - sum_row( i + 1 ) > 10) && (sum_row(i + 2) - sum_row( i+1 ) > 10))
                Q(i+1,:) = 0;
                P(i+1,:) = 50;
            elseif ((sum_row( i + 1 ) - sum_row( i ) > 10) && (sum_row(i + 1) - sum_row( i + 2 ) > 10))
                Q(i+1,:) = 0;
                P(i+1,:) = 50;
            end
        end
        
        for i=1:10
            for j=1:fix(r/10)-1
                Q(i,1)= Q(i,1) + Q(10*j+i,1);
            end
            if Q(i,1) > 45
                for j=0:fix(r/10)-1
                    Q(i+10*j,:) = 1;
                end
            else 
                for j=0:fix(r/10)-1
                    Q(i+10*j,:) = 0;
                end
            end
        end
        if k==1
         figure,imshow(Q',[]);
        end
        
end



