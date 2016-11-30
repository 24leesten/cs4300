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


if TEST_R
    for ridx = 1:length(all_R)
        [u,utrace] = CS4300_MDP_value_iteration(S,A,P,R,gam,eta,max_iter);
        utility(ridx).utility = u;
        utility(ridx).trace = utrace;
    end   
else
    for gidx = 1:length(gamma)
        [u,utrace] = CS4300_MDP_value_iteration(S,A,P,R,gam,eta,max_iter);
        utility(gidx).utility = u;
        utility(gidx).trace = utrace;
    end
end




for i = 1:length(utility)
    
    hold on
    x = linspace(0,30,length(utility(i).trace));
    plot(x,utility(i).trace(:,1));
    plot(x,utility(i).trace(:,4));
    plot(x,utility(i).trace(:,3));
    plot(x,utility(i).trace(:,11));
    plot(x,utility(i).trace(:,12));
    legend('(1,1)','(4,1)','(3,1)','(3,3)','(4,3)')
    axis([0 30 -0.3 1.1 ])
    hold off
end

CS4300_print_matrix(utility(1).utility,3,4);
