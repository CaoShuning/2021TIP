function [B]   =  SVD_shrink(I, X, svdMethod, opts )

rank_B = opts.rank_B;

for iter = 1:opts.Innerloop_B
    %% Ìõ´ø B-subproblem
    
    switch lower(svdMethod)
        case 'svdlibc'
            [U, diagS, V] = svdlibc(I- X, rank_B+1);
        case 'propack'
            [U,S,V] = lansvd(I- X,rank_FPN+1,'L');
            diagS = diag(S);
        case 'svds' %yes
            [U, S, V] = svds(I- X, rank_B+1, 'L');
            diagS = diag(S);
        otherwise
            [U,S,V] = svd(I- X,0);
            diagS = diag(S);
    end
    temp    = (diagS-opts.mu) .* double( (diagS-opts.mu) > 0 );
    B       = U * diag(temp) * V';
    
    
    % % % % %     %     opts.tau = opts.tau/opts.delta;
    % % % % %     %     temp    = (diagS-opts.tau).*double( (diagS-opts.tau) > 0 );
    % % % % %     %     B       = U * diag(temp) * V';
    % % % % %     %     rank_B   = sum(diagS>opts.tau);
    % % % % %     %     opts.tau = opts.tau*opts.delta;
    
    %% Calculate the low rank image
    %     sv = 12;
    %     [M, N] = size(I);
    %     temp = I - X;
    %     if choosvd(N, sv) == 1
    %         [U, S, V] = lansvd(temp, sv, 'L');
    %     else
    %         [U, S, V] = svd(temp, 'econ');
    %     end
    %     diagS = diag(S);
    %     %lengthS = length(diagS);
    %     svp = length(find(diagS > (opts.lambda /opts.delta)));
    %     if svp < sv
    %         sv = min(svp + 1, N);
    %     else
    %         sv = min(svp + round(0.05*N), N);
    %     end
    %     B = U(:, 1:svp) * diag(diagS(1:svp,:) - (opts.lambda /opts.delta)) * V(:, 1:svp)';
    
    
end
