function CS4300_a8_driver()
% CS4300_a8_driver - Runs assignment 8: MDP policy iteration
% Call:
%     CS4300_a8_driver;
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

WUMPUS = true;

% board setup
if  WUMPUS
    S = [1:16];
    ROWS = 4;
else
    S = [1:12]; % states
    ROWS = 3;
end
A = [1:4]; % actions
P = CS4300_get_P_matrix(S,A, WUMPUS);
COLS = 4;

% hyper parameters
eta = 0.05;
max_iter = 1000;
gam = 0.999999;

disp(sprintf('\n\n\n\n'));

for reward = [0.001, 0.075, 0.25, 0.5, 1]
    R = CS4300_get_rewards(-reward,WUMPUS);
    disp(sprintf('reward %f ========================',-reward));
    [pol,u,utrace] = CS6380_MDP_policy_iteration(S,A,P,R,max_iter,gam);
    %utility(ridx).utility = u;
    %utility(ridx).trace = utrace;
    CS4300_print_matrix(u,ROWS,COLS);
    CS4300_print_matrix(pol,ROWS,COLS);
    disp('========================');
end  
%{
[xc,yc] = size(utrace)
for ut = 1:xc
    CS4300_print_matrix(utrace(ut,:),ROWS,COLS);
end
%}