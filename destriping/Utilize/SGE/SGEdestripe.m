
function y_c = SLDdestripe(y,n_it,phi,s,lambda)

[R,C] = size(y);

% Matrices I and D (sparse structure)
D = spdiags([ones(C-1,1),-ones(C-1,1)],0:1,C-1,C);
I = speye(C,C);
% Dyl = D*log(y)';
Dyl = D*y';
gl = zeros(C,1); % Initialization
for it=1:n_it    % Iterations
    b = zeros(C-1,1);
    w = zeros(C-1,1);
    % Compute b and W from eq. (12)
    for r=1:R    % Sweeping rows
        w_r = phiprimeover2x(D*gl-Dyl(:,r),phi,s);
        b = b + w_r.*Dyl(:,r);
        w = w + w_r;
    end
    % Sparse matrix W
    W = spdiags(w,0,C-1,C-1);
    % Solve tridiagonal system of eq. (13)
    gl = (D'*W*D + lambda*I)\(D'*b);
end
g = gl;
y_c = y;
for c=1:C;
    y_c(:,c) = y_c(:,c)-g(c);
end

return;
