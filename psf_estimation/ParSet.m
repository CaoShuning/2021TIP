function  [opts]=ParSet

%% The first is the Lagranian parameter, the second is the regularization parameter
opts.belta = 0.003; opts.lamda2 = 0.0005; % total variational row constraint       
opts.gamma = 0.03; opts.lamda3 = 0.005; % total variational colomn constraint
opts.delta = 0.03;  opts.tau = 0.005;   % low-rank constraint
opts.MaxIter = 200;
opts.Innerloop_B = 1;
opts.rank_B = 5;                          % pre-estimation the rank of the stripe.  
