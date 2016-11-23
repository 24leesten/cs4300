function CS4300_a7_driver
% CS4300_a7_driver - Runs a7 through all assignment specifications.
% Call:
%     CS4300_a7_driver;
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

TEST_R = true;

% board setup
S = [1:16]; % states
A = [1:4]; % actions
P = CS4300_get_P_matrix(S,A, true);
ROWS = 4;
COLS = 4;

R_base = ((S * 0) + 1);
all_R = [-0.011, -0.04, -0.2, -2];
R = R_base * all_R(3);
R(16) = 1;  % gold
R(7) = -1;  % pit
R(11) = -1; % wumpus
R(12) = -1; % pit

% hyper parameters
eta = 0.05;
max_iter = 10000;
gamma = [0.9, 0.99, 0.999, 0.9999, 0.99999, 0.999999];
gam = 0.999999;

if TEST_R
    for ridx = 1:length(all_R)
        R = R_base * all_R(ridx);
        R(16) = 1;  % gold
        R(7) = -1;  % pit
        R(11) = -1; % wumpus
        R(12) = -1; % pit
        
        [u,utrace] = CS4300_MDP_value_iteration(S,A,P,R,gam,eta,max_iter);
        
        disp '========================================';
        disp(sprintf('R = %f',all_R(ridx)));
        CS4300_print_matrix(u,ROWS,COLS);
        disp '========================================';
    end
    
    
else
    for gidx = 1:length(gamma)
        gam = gamma(gidx);
        [u,utrace] = CS4300_MDP_value_iteration(S,A,P,R,gam,eta,max_iter);

        disp '========================================';
        disp(sprintf('Gamma = %f',gam));
        CS4300_print_matrix(u,ROWS,COLS);
        disp '========================================';
    end
end