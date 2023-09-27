%% Generate a dataset
K = 5; N = 1000; 

% generate true data from a multivariate normal distribution
mu_pop = zeros(K, 1);
Sigma_pop = 0.7 * ones(K) + 0.3 * eye(K);
Data = mvnrnd(mu_pop, Sigma_pop, N);

% generate missing pattern
ResponseInd_pop = binornd(1, 0.9 * ones(N, K));

% generate observed data
Data(~logical(ResponseInd_pop)) = NaN;


%% Compute Nonparametric bounds for Alpha

[alphaLB, alphaUB] = AlphaNB(Data, 1, 0, 1);

%% Compute Alpha using list-wise deletion

alpha = AlphaWithDeletion(Data);
