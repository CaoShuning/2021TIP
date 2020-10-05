%%% 受以下命令调用
%%%  [Q0 w] = periodo(transpose(imgori));
%%%  [Q1 w] = periodo(transpose(imgdestriped));
%%%  ID = 1 - 1/max(size(Q0)).*(sum(abs(Q1(:)-Q0(:))./(Q0(:))));
function [P,ws] = periodo(signal)
[sx sy] = size(signal);
P = 0;
for i=1:sy
    [Px,ws] = periodogram( double(signal(:,i)) );
    P = P + Px;
end;
P = P/sy;
