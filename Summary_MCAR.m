%% Load data
load('/Users/leishi/Documents/GitHub/AlphaNLB/Record_alphaDel.mat')
load('/Users/leishi/Documents/GitHub/AlphaNLB/Record_alphaLB.mat')
load('/Users/leishi/Documents/GitHub/AlphaNLB/Record_alphaUB.mat')



%% summarize simulation results
K = 4;
numIter = 30;
p_Missing_Candidate = [0.85, 0.9];
c_avg_Candidate = [0.5, 0.7, 0.9];
mu_abs_Candidate = [0.5, 1, 1.5];
sbar_Candidate = 0.25 * (2:6);

avg_alphaLB = mean(Record_alphaLB, 1);
avg_alphaUB = mean(Record_alphaUB, 1);
avg_alphaDel = mean(Record_alphaDel, 1);
alphaStar = K*c_avg_Candidate./(1+(K-1)*c_avg_Candidate);



%% create plots for upper bounds: p = 0.85

figure;
hold on;

plot(sbar_Candidate, avg_alphaUB(1, :, 1, 1, 1), '-+',...
    'Color', 'r',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaUB(1, :, 2, 1, 1), '-o',...
    'Color', 'b',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaUB(1, :, 3, 1, 1), '-x',...
    'Color', 'g',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, alphaStar(1) * ones(1,5), '--')
legend({'mu bound = 0.5', 'mu bound = 1.0', 'mu bound = 1.5', strcat("alpha = ", num2str(alphaStar(1), 3))}, 'Location', 'southeast');
ylim([0.79 0.87]);
% title('Correlation = 0.5');
xlabel('Bound for variance', 'FontWeight', 'bold', 'FontSize', 14);
ylabel('Upper bound for alpha', 'FontWeight', 'bold', 'FontSize', 14);

ax = gca;
ax.FontSize = 16;

sname = 'alpha';
S = hgexport('readstyle', sname);
S.Format = 'png';
% S.ApplyStyle = '1';
hgexport(gcf, "Simulation_MCAR_results/upper-p85-c50-MCAR.png", S);

hold off;





% exportgraphics(ax, 'upper-p85-c50-MCAR.png', '', '');

figure;
hold on;

plot(sbar_Candidate, avg_alphaUB(1, :, 1, 2, 1), '-+',...
    'Color', 'r',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaUB(1, :, 2, 2, 1), '-o',...
    'Color', 'b',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaUB(1, :, 3, 2, 1), '-x',...
    'Color', 'g',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, alphaStar(2) * ones(1,5), '--')
legend({'mu bound = 0.5', 'mu bound = 1.0', 'mu bound = 1.5', strcat("alpha = ", num2str(alphaStar(2), 3))}, 'Location', 'southeast');

% title('Correlation = 0.7');
xlabel('Bound for variance', 'FontWeight', 'bold', 'FontSize', 14);
ylabel('Upper bound for alpha', 'FontWeight', 'bold', 'FontSize', 14);
ax = gca;
ax.FontSize = 16;

sname = 'alpha';
S = hgexport('readstyle', sname);
S.Format = 'png';
% S.ApplyStyle = '1';
hgexport(gcf, "Simulation_MCAR_results/upper-p85-c70-MCAR.png", S);

hold off;





figure;
hold on;

plot(sbar_Candidate, avg_alphaUB(1, :, 1, 3, 1), '-+',...
    'Color', 'r',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaUB(1, :, 2, 3, 1), '-o',...
    'Color', 'b',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaUB(1, :, 3, 3, 1), '-x',...
    'Color', 'g',...
    'LineWidth',2,...
    'MarkerSize',10);

plot(sbar_Candidate, alphaStar(3) * ones(1,5), '--')
legend('mu bound = 0.5', 'mu bound = 1.0', 'mu bound = 1.5', strcat("alpha = ", num2str(alphaStar(3), 3)), 'Location', 'southeast');

% title('Correlation = 0.9');
xlabel('Bound for variance', 'FontWeight', 'bold', 'FontSize', 14);
ylabel('Upper bound for alpha', 'FontWeight', 'bold', 'FontSize', 14);
ax = gca;
ax.FontSize = 16;

sname = 'alpha';
S = hgexport('readstyle', sname);
S.Format = 'png';
% S.ApplyStyle = '1';
hgexport(gcf, "Simulation_MCAR_results/upper-p85-c90-MCAR.png", S);

hold off;


%% create plots for lower bounds: p = 0.85
figure;
hold on;

plot(sbar_Candidate, avg_alphaLB(1, :, 1, 1, 1), '-+',...
    'Color', 'r',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaLB(1, :, 2, 1, 1), '-o',...
    'Color', 'b',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaLB(1, :, 3, 1, 1), '-x',...
    'Color', 'g',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, alphaStar(1) * ones(1,5), '--')
legend({'mu bound = 0.5', 'mu bound = 1.0', 'mu bound = 1.5', strcat("alpha = ", num2str(alphaStar(1), 3))}, 'Location', 'northeast');
ylim([0 1]);
% title('Correlation = 0.5');
xlabel('Bound for variance', 'FontWeight', 'bold', 'FontSize', 14);
ylabel('Lower bound for alpha', 'FontWeight', 'bold', 'FontSize', 14);
ax = gca;
ax.FontSize = 16;

sname = 'alpha';
S = hgexport('readstyle', sname);
S.Format = 'png';
% S.ApplyStyle = '1';
hgexport(gcf, "Simulation_MCAR_results/lower-p85-c50-MCAR.png", S);

hold off;

figure;
hold on;

plot(sbar_Candidate, avg_alphaLB(1, :, 1, 2, 1), '-+',...
    'Color', 'r',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaLB(1, :, 2, 2, 1), '-o',...
    'Color', 'b',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaLB(1, :, 3, 2, 1), '-x',...
    'Color', 'g',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, alphaStar(2) * ones(1,5), '--')
legend({'mu bound = 0.5', 'mu bound = 1.0', 'mu bound = 1.5', strcat("alpha = ", num2str(alphaStar(2), 3))}, 'Location', 'northeast');
ylim([0 1]);
% title('Correlation = 0.7');
xlabel('Bound for variance', 'FontWeight', 'bold', 'FontSize', 14);
ylabel('Lower bound for alpha', 'FontWeight', 'bold', 'FontSize', 14);
ax = gca;
ax.FontSize = 16;

sname = 'alpha';
S = hgexport('readstyle', sname);
S.Format = 'png';
% S.ApplyStyle = '1';
hgexport(gcf, "Simulation_MCAR_results/lower-p85-c70-MCAR.png", S);

hold off;


figure;
hold on;

plot(sbar_Candidate, avg_alphaLB(1, :, 1, 3, 1), '-+',...
    'Color', 'r',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaLB(1, :, 2, 3, 1), '-o',...
    'Color', 'b',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaLB(1, :, 3, 3, 1), '-x',...
    'Color', 'g',...
    'LineWidth',2,...
    'MarkerSize',10);

plot(sbar_Candidate, alphaStar(3) * ones(1,5), '--')
legend('mu bound = 0.5', 'mu bound = 1.0', 'mu bound = 1.5', strcat("alpha = ", num2str(alphaStar(3), 3)), 'Location', 'northeast');
ylim([0 1]);
% title('Correlation = 0.9');
xlabel('Bound for variance', 'FontWeight', 'bold', 'FontSize', 14);
ylabel('Lower bound for alpha', 'FontWeight', 'bold', 'FontSize', 14);
ax = gca;
ax.FontSize = 16;

sname = 'alpha';
S = hgexport('readstyle', sname);
S.Format = 'png';
% S.ApplyStyle = '1';
hgexport(gcf, "Simulation_MCAR_results/lower-p85-c90-MCAR.png", S);

hold off;




%% create plots for upper bounds: p = 0.90

figure;
hold on;

plot(sbar_Candidate, avg_alphaUB(1, :, 1, 1, 2), '-+',...
    'Color', 'r',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaUB(1, :, 2, 1, 2), '-o',...
    'Color', 'b',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaUB(1, :, 3, 1, 2), '-x',...
    'Color', 'g',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, alphaStar(1) * ones(1,5), '--')
legend({'mu bound = 0.5', 'mu bound = 1.0', 'mu bound = 1.5', strcat("alpha = ", num2str(alphaStar(1), 3))}, 'Location', 'southeast');
yticks(0.78:0.005:0.85);
% title('Correlation = 0.5');
xlabel('Bound for variance', 'FontWeight', 'bold', 'FontSize', 14);
ylabel('Upper bound for alpha', 'FontWeight', 'bold', 'FontSize', 14);
ylim([0.79 0.85]);
ax = gca;
ax.FontSize = 16;

sname = 'alpha';
S = hgexport('readstyle', sname);
S.Format = 'png';
% S.ApplyStyle = '1';
hgexport(gcf, "Simulation_MCAR_results/upper-p90-c50-MCAR.png", S);

hold off;


figure;
hold on;

plot(sbar_Candidate, avg_alphaUB(1, :, 1, 2, 2), '-+',...
    'Color', 'r',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaUB(1, :, 2, 2, 2), '-o',...
    'Color', 'b',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaUB(1, :, 3, 2, 2), '-x',...
    'Color', 'g',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, alphaStar(2) * ones(1,5), '--')
legend({'mu bound = 0.5', 'mu bound = 1.0', 'mu bound = 1.5', strcat("alpha = ", num2str(alphaStar(2), 3))}, 'Location', 'southeast');

% title('Correlation = 0.7');
xlabel('Bound for variance', 'FontWeight', 'bold', 'FontSize', 14);
ylabel('Upper bound for alpha', 'FontWeight', 'bold', 'FontSize', 14);
ax = gca;
ax.FontSize = 16;

sname = 'alpha';
S = hgexport('readstyle', sname);
S.Format = 'png';
% S.ApplyStyle = '1';
hgexport(gcf, "Simulation_MCAR_results/upper-p90-c70-MCAR.png", S);

hold off;


figure;
hold on;

plot(sbar_Candidate, avg_alphaUB(1, :, 1, 3, 2), '-+',...
    'Color', 'r',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaUB(1, :, 2, 3, 2), '-o',...
    'Color', 'b',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaUB(1, :, 3, 3, 2), '-x',...
    'Color', 'g',...
    'LineWidth',2,...
    'MarkerSize',10);

plot(sbar_Candidate, alphaStar(3) * ones(1,5), '--')
legend('mu bound = 0.5', 'mu bound = 1.0', 'mu bound = 1.5', strcat("alpha = ", num2str(alphaStar(3), 3)), 'Location', 'southeast');

% title('Correlation = 0.9');
xlabel('Bound for variance', 'FontWeight', 'bold', 'FontSize', 14);
ylabel('Upper bound for alpha', 'FontWeight', 'bold', 'FontSize', 14);
ax = gca;
ax.FontSize = 16;

sname = 'alpha';
S = hgexport('readstyle', sname);
S.Format = 'png';
% S.ApplyStyle = '1';
hgexport(gcf, "Simulation_MCAR_results/upper-p90-c90-MCAR.png", S);

hold off;



%% create plots for lower bounds: p = 0.90
figure;
hold on;

plot(sbar_Candidate, avg_alphaLB(1, :, 1, 1, 2), '-+',...
    'Color', 'r',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaLB(1, :, 2, 1, 2), '-o',...
    'Color', 'b',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaLB(1, :, 3, 1, 2), '-x',...
    'Color', 'g',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, alphaStar(1) * ones(1,5), '--')
legend({'mu bound = 0.5', 'mu bound = 1.0', 'mu bound = 1.5', strcat("alpha = ", num2str(alphaStar(1), 3))}, 'Location', 'northeast');
ylim([0 1]);
% title('Correlation = 0.5');
xlabel('Bound for variance', 'FontWeight', 'bold', 'FontSize', 14);
ylabel('Lower bound for alpha', 'FontWeight', 'bold', 'FontSize', 14);
ax = gca;
ax.FontSize = 16;

sname = 'alpha';
S = hgexport('readstyle', sname);
S.Format = 'png';
% S.ApplyStyle = '1';
hgexport(gcf, "Simulation_MCAR_results/lower-p90-c50-MCAR.png", S);

hold off;






figure;
hold on;

plot(sbar_Candidate, avg_alphaLB(1, :, 1, 2, 2), '-+',...
    'Color', 'r',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaLB(1, :, 2, 2, 2), '-o',...
    'Color', 'b',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaLB(1, :, 3, 2, 2), '-x',...
    'Color', 'g',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, alphaStar(2) * ones(1,5), '--')
legend({'mu bound = 0.5', 'mu bound = 1.0', 'mu bound = 1.5', strcat("alpha = ", num2str(alphaStar(2), 3))}, 'Location', 'northeast');
ylim([0 1]);
% title('Correlation = 0.7');
xlabel('Bound for variance', 'FontWeight', 'bold', 'FontSize', 14);
ylabel('Lower bound for alpha', 'FontWeight', 'bold', 'FontSize', 14);
ax = gca;
ax.FontSize = 16;

sname = 'alpha';
S = hgexport('readstyle', sname);
S.Format = 'png';
% S.ApplyStyle = '1';
hgexport(gcf, "Simulation_MCAR_results/lower-p90-c70-MCAR.png", S);

hold off;


figure;
hold on;

plot(sbar_Candidate, avg_alphaLB(1, :, 1, 3, 2), '-+',...
    'Color', 'r',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaLB(1, :, 2, 3, 2), '-o',...
    'Color', 'b',...
    'LineWidth',2,...
    'MarkerSize',10);
plot(sbar_Candidate, avg_alphaLB(1, :, 3, 3, 2), '-x',...
    'Color', 'g',...
    'LineWidth',2,...
    'MarkerSize',10);

plot(sbar_Candidate, alphaStar(3) * ones(1,5), '--')
legend('mu bound = 0.5', 'mu bound = 1.0', 'mu bound = 1.5', strcat("alpha = ", num2str(alphaStar(3), 3)), 'Location', 'northeast');
ylim([0 1]);
% title('Correlation = 0.9');
xlabel('Bound for variance', 'FontWeight', 'bold', 'FontSize', 14);
ylabel('Lower bound for alpha', 'FontWeight', 'bold', 'FontSize', 14);
ax = gca;
ax.FontSize = 16;

sname = 'alpha';
S = hgexport('readstyle', sname);
S.Format = 'png';
% S.ApplyStyle = '1';
hgexport(gcf, "Simulation_MCAR_results/lower-p90-c90-MCAR.png", S);

hold off;



