%% test quadprog function

H = [1 -1; -1 2]; 
f = [-2; -6];
A = [1 1; -1 2; 2 1];
b = [2; 2; 3];
% lb = zeros(3,1);
% ub = ones(size(lb));
% Aeq = ones(1,3);
% beq = 1/2;

[x fval] = quadprog(H, f, A, b);






%% test quadprog function

H = [-1 0; 0 -1]; 
f = [0; 0]; 
A = []; 
b = []; 
lb = -ones(2,1); 
ub = ones(2,1); 
Aeq = []; 
beq = []; 
x0 = [0; 0];

options = optimoptions('quadprog', 'Algorithm', 'trust-region-reflective');

% from interior point convex
% [x, fval] = quadprog(H, f, A, b, [], [], lb, ub, x0, options);
% from active set method
[x, fval] = quadprog(H, f, A, b, [], [], lb, ub, x0, options);


%% test

H = [-1 0; 0 -1]; 
f = [0; 0]; 
A = []; 
b = []; 
lb = -ones(2,1); 
ub = ones(2,1); 
Aeq = []; 
beq = []; 
x0 = [0; 0];
fun = @(x) x' * H * x + 2 * f' * x;
[x, fval] = fmincon(fun, x0, A, b, Aeq, beq, lb, ub);




%% test function
K = 2;

sbar = 1; mu_lb = 0 * ones(4,1); mu_ub = 2 * ones(4,1);
p  = [5/8, 1/8, 1/8, 1/8]; % 11 10 01 00
mu1 = [0.3, 0.5, NaN, NaN]; % 11 10 01 00
mu2 = [0.6, NaN, 0.1, NaN]; % 11 10 01 00


s1 = [1, 1, NaN, NaN]; % 11 10 01 00
s2 = [1, NaN, 1, NaN]; % 11 10 01 00

mu11 = [1;1];
mu10 = [1;NaN];
mu01 = [NaN;1];
mu00 = [NaN; NaN];

mu = [mu11; mu10; mu01; mu00];

missing_ind = isnan(mu);
obs_ind = ~missing_ind;

s11 = [1, 0; 
        0, 1];
s10 = [1, NaN;
        NaN, NaN];
s01 = [NaN, NaN;
        NaN, 1];
s00 = [NaN, NaN;
        NaN, NaN];


IndMap = [1;5;2;6;3;7;4;8];


% compute Js and Ds parts

Js = p(1) * sum(s11(:)) + p(2) * (sqrt(sbar) - sqrt(s10(1,1)))^2 + p(3) * (sqrt(sbar) - sqrt(s01(2,2)))^2;
Ds = p(1) * (s11(1,1) + s11(2,2)) + p(2) * (sbar + s10(1,1)) + p(3) * (sbar + s01(2,2)) + 2 * p(4);


% 1/2 xTHx + fT x + b

HJ_full = blkdiag(p(1) * ones(2), p(2) * ones(2), p(3) * ones(2), p(4) * ones(2)) ...
    - reshape(repmat(p,[2,1]), [], 1) * reshape(repmat(p,[2,1]), [], 1)';

HD_full = diag([p,p]) - blkdiag(p'*p, p'*p);
HD_full = HD_full(IndMap, IndMap);


% find arguments for J = x' * HJ * x + 2 * fJ' * x + cJ

HJ = HJ_full(missing_ind, missing_ind);
fJ = HJ_full(missing_ind, obs_ind) * mu(obs_ind);
cJ = mu(obs_ind)' * HJ_full(obs_ind, obs_ind) * mu(obs_ind) + Js;


% find arguments for D(mu) = x' * HD * x + 2 * fD' * x + cD

HD = HD_full(missing_ind, missing_ind);
fD = HD_full(missing_ind, obs_ind) * mu(obs_ind);
cD = mu(obs_ind)' * HD_full(obs_ind, obs_ind) * mu(obs_ind) + Ds;


% solve for the parametric function

F0 = Fpara2(0, HJ, fJ, cJ, HD, fD, cD, mu_lb, mu_ub);
F1 = Fpara2(1, HJ, fJ, cJ, HD, fD, cD, mu_lb, mu_ub);

Fq = zeros(100, 1);
x  = zeros(4, 100);
for iter = 1:100
    [Fq(iter), x(:, iter)] = Fpara2(iter/100, HJ, fJ, cJ, HD, fD, cD, mu_lb, mu_ub);
end

plot((1:100)/100, Fq);
grid on;



function [Fq, x] = Fpara(q, HJ, fJ, cJ, HD, fD, cD, lb, ub)
    H = HJ - q * HD;
    f = fJ - q * fD;
%   c = - (cJ - q * cD);
    x0 = lb;
    options = optimoptions('quadprog', 'Algorithm', 'trust-region-reflective');

    % from active set method
    [x, ~] = quadprog(H, f, [], [], [], [], lb, ub, x0, options);
    
    Fq = x' * HJ * x + 2 * fJ' * x + cJ - q * (x' * HD * x + 2 * fD' * x + cD);

end


function [Fq, x] = Fpara2(q, HJ, fJ, cJ, HD, fD, cD, lb, ub)
    x0 = lb;
    
    fun = @(x) x' * HJ * x + 2 * fJ' * x + cJ - q * (x' * HD * x + 2 * fD' * x + cD);
    gs = GlobalSearch;
    
    problem = createOptimProblem('fmincon', 'x0', x0, ...
        'objective', fun, 'lb', lb, 'ub', ub);
    
    x = run(gs, problem);
    
    Fq = x' * HJ * x + 2 * fJ' * x + cJ - q * (x' * HD * x + 2 * fD' * x + cD);

end
























