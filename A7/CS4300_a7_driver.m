function utility = CS4300_a7_driver(test_r)
% CS4300_a7_driver - Runs a7 through all assignment specifications.
% Call:
%     CS4300_a7_driver;
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

TEST_R = test_r;
if TEST_R
    utility = [];
else
    utility = [];
end

WUMPUS=true;
% board setup
if WUMPUS
    S = [1:16];
else
    S = [1:12]; % states
end
A = [1:4]; % actions
P = CS4300_get_P_matrix(S,A, WUMPUS);
if WUMPUS
    ROWS = 4;
else
    ROWS = 3;
end
COLS = 4;

R_base = (S * 0);
all_R = [-0.011, -0.04, -0.2, -2];
R = R_base * all_R(2);
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
    for ridx = 0.4:0.1:1
        reward = -ridx;
        R = R_base + reward;
        if WUMPUS
            R(16) = 1;  % gold
            R(7) = -1;  % pit
            R(11) = -1; % wumpus
            R(12) = -1; % pit
        else
            R(12) = 1;
            R(8) = -1;
            R(6) = 0;
        end
        [u,utrace] = CS4300_MDP_value_iteration(S,A,P,R,gam,eta,max_iter);
        % utility(ridx).utility = u;
        % utility(ridx).trace = utrace;
        
        disp '========================================';
        disp(sprintf('R = %f',reward));
        CS4300_print_matrix(u,ROWS,COLS);
        CS4300_print_matrix(CS4300_MDP_policy(S,A,P,u),ROWS,COLS)
        disp '========================================';
        
    end
    
    
else
    for gidx = 1:length(gamma)
        gam = gamma(gidx);
        [u,utrace] = CS4300_MDP_value_iteration(S,A,P,R,gam,eta,max_iter);
        % utility(gidx).utility = u;
        % utility(gidx).trace = utrace;

        disp '========================================';
        disp(sprintf('Gamma = %f',gam));
        CS4300_print_matrix(u,ROWS,COLS);
        disp '========================================';
    end
end