function [alphaLB, alphaUB] = AlphaNB(Data, muLowerBound, muUpperBound, sbar)

%% initial tuning
verbose = 0;

%% define Ltmin and Ltmax function
Ltmin = @(x) max(0, 2*max(x) - sum(x));
Ltmax = @(x) sum(x);

N = size(Data, 1);
K = size(Data, 2);

decInd = zeros(1, N);
p = zeros(2^K, 1);
mu = zeros(2^K, K);
SigmaUB = zeros(2^K, K);
SigmaLB = zeros(2^K, K);
SigmaClever = zeros(2^K, K);
SigmaLBSum = zeros(2^K, 1);
ResponseInd = ~isnan(Data);

for iter = 1:N
    decInd(iter) = bin2dec(sprintf('%d', ResponseInd(iter, :))) + 1;
end


%% compute p, mu, 
for iterPattern = 1:2^K
    % compute missing indices and nonmissing indices under iterPattern
    mappingBack = find(decInd == iterPattern, 1);
    obsInd = ResponseInd(mappingBack, :);
    missingInd = ~obsInd;
    
    % compute the probability vector p
    p(iterPattern) = sum(decInd == iterPattern)/N;
    if p(iterPattern) == 0
        continue;
    else
        mu(iterPattern, :) = mean(Data(decInd == iterPattern, :));
        if p(iterPattern) == 1/N || iterPattern == 1
            SigmaUB(iterPattern, :) = NaN(1, K);
            SigmaLBSum(iterPattern) = 0;
            SigmaClever(iterPattern, :) = NaN(1, K);
        elseif iterPattern == 2^K
            SigmaUB(iterPattern, :) = std(Data(decInd == iterPattern, :));
            SigmaLBSum(iterPattern) = std(sum(Data(decInd == iterPattern, obsInd), 2));
            SigmaClever(iterPattern, :) = std(sum(Data(decInd == iterPattern, obsInd), 2))/K;
        else
            SigmaUB(iterPattern, :) = std(Data(decInd == iterPattern, :));
            SigmaLBSum(iterPattern) = Ltmin([std(sum(Data(decInd == iterPattern, obsInd), 2)), ...
                sqrt(sbar) * ones(1, sum(missingInd))]);
            SigmaClever(iterPattern, :) = NaN;
            SigmaClever(iterPattern, obsInd) = std(sum(Data(decInd == iterPattern, obsInd), 2))/sum(obsInd);
        end
    end 
end

SigmaLB = SigmaUB;
SigmaLB(isnan(SigmaUB)) = sbar; 

% compute Js
Js = sum(p .* SigmaLBSum.^2);

% compute Ds
Ds = sum(p .* sum(SigmaLB.^2, 2));

%% compute lower bound
numNaN = sum(sum(isnan(mu)));
x0 = zeros(numNaN, 1);
mu_lb = muLowerBound * ones(numNaN, 1);
mu_ub = muUpperBound * ones(numNaN, 1);

gs = GlobalSearch;

fun = @(x) AlphaLowerFun(x, mu, p, Js, Ds);

opts = optimoptions('fmincon', 'MaxFunEvals', 3e3, ...
    'MaxIter', 1e3);
    
problem = createOptimProblem('fmincon', 'x0', x0, ...
        'objective', fun, 'lb', mu_lb, 'ub', mu_ub, 'options', opts);
    
x = run(gs, problem);
Fmin = AlphaLowerFun(x, mu, p, Js, Ds);

alphaLB = K/(K-1) * (1 - 1/Fmin);

if verbose
    disp(['lower bound for alpha is: ', num2str(alphaLB)]);
end



%% compute upper bound
numNaN_mu = sum(sum(isnan(mu)));
numNaN_Sigma = sum(sum(isnan(SigmaUB)));
numNaN = numNaN_mu + numNaN_Sigma;

mu_lb = muLowerBound * ones(numNaN_mu, 1);
mu_ub = muUpperBound * ones(numNaN_mu, 1);
s_lb = 0 * ones(numNaN_Sigma, 1);
s_ub = sbar * ones(numNaN_Sigma, 1);
x_lb = [mu_lb; s_lb];
x_ub = [mu_ub; s_ub];
x0 = x_lb;

gs = GlobalSearch;

fun = @(x) -1 * AlphaUpperFun(x, mu, p, SigmaUB, SigmaClever);

opts = optimoptions('fmincon', 'MaxFunEvals', 3e3, ...
    'MaxIter', 1e3);

problem = createOptimProblem('fmincon', 'x0', x0, ...
        'objective', fun, 'lb', x_lb, 'ub', x_ub, 'options', opts);
    
x = run(gs, problem);
    
Fmax = AlphaUpperFun(x, mu, p, SigmaUB, SigmaClever);
alphaUB = K/(K-1) * (1 - 1/Fmax);

if verbose
    disp(['Upper bound for alpha is: ', num2str(alphaUB)]);
end


end