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

% board setup
S = [1:16]; % states
A = [1:4]; % actions
P = CS4300_get_P_matrix(S,A, true);
ROWS = 4;
COLS = 4;

R = ((S * 0) + 1) * -0.04;
R(16) = 1;  % gold
R(7) = -1;  % pit
R(11) = -1; % wumpus
R(12) = -1; % pit

% hyper parameters
eta = 0.05;
max_iter = 10000;
gamma = [0.9, 0.99, 0.999, 0.9999, 0.99999, 0.999999];

[u,utrace] = CS4300_MDP_value_iteration(S,A,P,R,gamma(1),eta,max_iter);

CS4300_print_matrix(u,ROWS,COLS);