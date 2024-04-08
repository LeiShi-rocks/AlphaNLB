% Simulation setup
rng(2023, 'twister'); % generate random seed
numIter = 25;
p_Missing_Candidate = [0.90, 0.95];
c_avg_Candidate = [0.5, 0.7, 0.9];
mu_abs_Candidate = [0.5, 1, 1.5];
sbar_Candidate = 0.25 * (2:6);

K = 4; N = 1000;
Record_alphaLB_MNAR = zeros(numIter, length(sbar_Candidate), length(mu_abs_Candidate), ...
    length(c_avg_Candidate), length(p_Missing_Candidate));
Record_alphaUB_MNAR = zeros(numIter, length(sbar_Candidate), length(mu_abs_Candidate), ...
    length(c_avg_Candidate), length(p_Missing_Candidate));
Record_alphaDel_MNAR = zeros(numIter, length(sbar_Candidate), length(mu_abs_Candidate), ...
    length(c_avg_Candidate), length(p_Missing_Candidate));

alphaStar = K*c_avg_Candidate./(1+(K-1)*c_avg_Candidate);

%% Simulation study
for piter = 1:length(p_Missing_Candidate)
    for citer = 1:length(c_avg_Candidate)
        for muiter = 1:length(mu_abs_Candidate)
            for siter = 1:length(sbar_Candidate)
                for iter = 1:numIter
                    %% Print
                    disp(' ');
                    disp(['piter: ', num2str(piter), ...
                        ', citer: ', num2str(citer), ...
                        ', muiter: ', num2str(muiter), ...
                        ', siter: ', num2str(siter), ...
                        ', iter: ', num2str(iter)]);
                    
                    %% Getting setup parameters
                    pMissing = p_Missing_Candidate(piter);
                    cavg = c_avg_Candidate(citer);
                    mu_abs = mu_abs_Candidate(muiter);
                    sbar = sbar_Candidate(siter);
                    
                    %% Generate a dataset
                    % generate true data from a multivariate normal distribution
                    mu_pop = zeros(K, 1);
                    Sigma_pop = cavg * ones(K) + (1-cavg) * eye(K);
                    Data = mvnrnd(mu_pop, Sigma_pop, N);
                    
                    % generate missing pattern
                    obsProb = exp(-abs(Data) * (1 - pMissing));
                    ResponseInd_pop = binornd(1, obsProb);
                    
                    % generate observed data
                    Data(~logical(ResponseInd_pop)) = NaN;                
                    
                    %% Compute Nonparametric bounds for alpha
                    [alphaLB, alphaUB] = AlphaNB(Data, -mu_abs, mu_abs, sbar);
                    Record_alphaLB_MNAR(iter, siter, muiter, citer, piter) = alphaLB;
                    Record_alphaUB_MNAR(iter, siter, muiter, citer, piter) = alphaUB;
                                     
                    %% Compute alpha using list-wise deletion
                    alpha = AlphaWithDeletion(Data);
                    Record_alphaDel_MNAR(iter, siter, muiter, citer, piter) = alpha;
                                   
                end
            end 
        end
    end
end

%% Save data
save('Record_alphaLB_MNAR.mat', 'Record_alphaLB_MNAR')
save('Record_alphaUB_MNAR.mat', 'Record_alphaUB_MNAR')
save('Record_alphaDel_MNAR.mat', 'Record_alphaDel_MNAR')

