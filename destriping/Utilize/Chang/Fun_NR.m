function    NR = Fun_NR( inputdata ,outputdata )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[sx sy]=size(inputdata);
P=0;
for i=1:sy
[Px,w] = periodogram(double(inputdata(:,i)));
P=P+Px;
end;
P=P/sy;
A1 = [P(52),P(103),P(155),P(206),P(257)];
% A1 = [P(27),P(52),P(78),P(103)];
N1 = sum(A1);


[sx sy]=size(outputdata);
P=0;
for i=1:sy
[Px,w] = periodogram(double(outputdata(:,i)));
P=P+Px;
end;
P=P/sy;
A2 = [P(52),P(103),P(155),P(206),P(257)];
% A2 = [P(27),P(52),P(78),P(103)];
N2 = sum(A2);

NR = N1/N2;

end

