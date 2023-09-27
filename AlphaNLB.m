%% test 
K = 2;

sbar = 1; mu_lb = 0 * ones(4,1); mu_ub = 0 * ones(4,1);
% p  = [5/8, 1/8, 1/8, 1/8]; % 11 10 01 00
p  = [0.2, 0, 0, 0.8]; % 11 10 01 00
mu1 = [0.3, 0.5, NaN, NaN]; % 11 10 01 00
mu2 = [0.6, NaN, 0.1, NaN]; % 11 10 01 00

s1 = [1, 1, NaN, NaN]; % 11 10 01 00
s2 = [1, NaN, 1, NaN]; % 11 10 01 00

mu11 = [0;0];
mu10 = [0;NaN];
mu01 = [NaN;0];
mu00 = [NaN; NaN];

mu = [mu11; mu10; mu01; mu00];

missing_ind = isnan(mu);
obs_ind = ~missing_ind;

s11 = [1, 1; 
        1, 1];
s10 = [1, NaN;
        NaN, NaN];
s01 = [NaN, NaN;
        NaN, 1];
s00 = [NaN, NaN;
        NaN, NaN];


IndMap = [1;5;2;6;3;7;4;8];


% compute Js and Ds parts for a lower bound

Js = p(1) * sum(s11(:)) + p(2) * (sqrt(sbar) - sqrt(s10(1,1)))^2 + p(3) * (sqrt(sbar) - sqrt(s01(2,2)))^2;
Ds = p(1) * (s11(1,1) + s11(2,2)) + p(2) * (sbar + s10(1,1)) + p(3) * (sbar + s01(2,2)) + 2 * p(4) * sbar;


% 1/2 xTHx + fT x + b

HJ_full = blkdiag(p(1) * ones(2), p(2) * ones(2), p(3) * ones(2), p(4) * ones(2)) ...
    - reshape(repmat(p,[2,1]), [], 1) * reshape(repmat(p,[2,1]), [], 1)';

HD_full = diag([p,p]) - blkdiag(p'*p, p'*p);
HD_full = HD_full(IndMap, IndMap);


% find arguments for J = x' * HJ * x + 2 * fJ' * x + cJ

HJ = HJ_full(missing_ind, missing_ind);
fJ = HJ_full(missing_ind, obs_ind) * mu(obs_ind);
cJ = mu(obs_ind)' * HJ_full(obs_ind, obs_ind) * mu(obs_ind) + Js;
cJJ = mu(obs_ind)' * HJ_full(obs_ind, obs_ind) * mu(obs_ind);

% find arguments for D(mu) = x' * HD * x + 2 * fD' * x + cD

HD = HD_full(missing_ind, missing_ind);
fD = HD_full(missing_ind, obs_ind) * mu(obs_ind);
cD = mu(obs_ind)' * HD_full(obs_ind, obs_ind) * mu(obs_ind) + Ds;
cDD = mu(obs_ind)' * HD_full(obs_ind, obs_ind) * mu(obs_ind);

% find Js part
HJs = [p(2) 0 0 0
       0 p(3) 0 0
       0 0 p(4) p(4)
       0 0 p(4) p(4)];
fJs = [p(2)*sqrt(s10(1,1)); p(3)*sqrt(s01(2,2)); 0; 0];
cJs = p(1) * sum(s11(:)) + p(2) * s10(1,1) + p(3) * s01(2,2);

% find Ds part
HDs = diag([p(2), p(3), p(4), p(4)]);
fDs = [0;0;0;0];
cDs = p(1) * (s11(1,1) + s11(2,2)) + p(2)*s10(1,1) + p(3) * s01(2,2);

% 

[Fmin, x] = Fpara3(HJ, fJ, cJ, HD, fD, cD, mu_lb, mu_ub);
alpha = K/(K-1) * (1 - 1/Fmin);
disp(['lower bound for alpha is: ', num2str(alpha)]);

%
x_lb = [mu_lb; 0*ones(4,1)];
x_ub = [mu_ub;sqrt(sbar)*ones(4,1)];
[Fmax, x] = Fpara4(HJ, fJ, cJJ, HD, fD, cDD, HJs, fJs, cJs, HDs, fDs, cDs, x_lb, x_ub);
alpha = K/(K-1) * (1 - 1/Fmax);
disp(['upper bound for alpha is: ', num2str(alpha)]);

function [Fmin, x] = Fpara3(HJ, fJ, cJ, HD, fD, cD, lb, ub)
    x0 = lb;
    
    fun = @(x) (x' * HJ * x + 2 * fJ' * x + cJ) / (x' * HD * x + 2 * fD' * x + cD);
    gs = GlobalSearch;
    
    problem = createOptimProblem('fmincon', 'x0', x0, ...
        'objective', fun, 'lb', lb, 'ub', ub);
    
    x = run(gs, problem);
    
    Fmin = fun(x);

end


function [Fmax, x] = Fpara4(HJ, fJ, cJJ, HD, fD, cDD, HJs, fJs, cJs, HDs, fDs, cDs, lb, ub)
    x0 = lb;
    
    fun = @(x) - (x(1:4)' * HJ * x(1:4) + 2 * fJ' * x(1:4) + cJJ + x(5:8)' * HJs * x(5:8) + 2 * fJs' * x(5:8) + cJs) / (x(1:4)' * HD * x(1:4) + 2 * fD' * x(1:4) + cDD + x(5:8)' * HDs * x(5:8) + 2 * fDs' * x(5:8) + cDs);
    gs = GlobalSearch;
    
    problem = createOptimProblem('fmincon', 'x0', x0, ...
        'objective', fun, 'lb', lb, 'ub', ub);
    
    x = run(gs, problem);
    disp(x);
    disp((x(1:4)' * HJ * x(1:4) + 2 * fJ' * x(1:4) + cJJ + x(5:8)' * HJs * x(5:8) + 2 * fJs' * x(5:8) + cJs));
    disp((x(1:4)' * HD * x(1:4) + 2 * fD' * x(1:4) + cDD + x(5:8)' * HDs * x(5:8) + 2 * fDs' * x(5:8) + cDs));
    
    Fmax = -fun(x);

end