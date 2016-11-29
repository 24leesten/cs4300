function CS4300_plot()
% CS4300_plot- create plots
% constants.
% Call:
%     Up = CS4300_plot();
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
TEST_R = true;

utility = [];


% board setup
S = [1:12]; % states
A = [1:4]; % actions
P = CS4300_get_P_matrix(S,A, false);

R_base = ((S * 0) + 1);
R = R_base * -0.04;
R(12) = 1;
R(8) = -1;
R(6) = 0;


%all_R = [-0.011, -0.04, -0.2, -2];
%R = R_base * all_R(3);

% hyper parameters
eta = 0.05;
max_iter = 30;
gamma = [0.9, 0.99, 0.999, 0.9999, 0.99999, 0.999999];
gam = 0.999999;

all_R = [1];


[p,u,ut]=CS6380_MDP_policy_iteration(S,A,P,R,30,gam);

CS4300_print_matrix(u,3,4)
