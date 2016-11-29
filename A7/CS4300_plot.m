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
WUMPUS = true;
utility = [];

if WUMPUS
    S = [1:16]; % states
    A = [1:4]; % actions
    P = CS4300_get_P_matrix(S,A, true);
    ROWS = 4;
    COLS = 4;

    R_base = ((S * 0) + 1);
    R = R_base * -0.001;
    R(16) = 1;  % gold
    R(7) = -1;  % pit
    R(11) = -1; % wumpus
    R(12) = -1; % pit
else
    % board setup
    S = [1:12]; % states
    A = [1:4]; % actions
    P = CS4300_get_P_matrix(S,A, false);
    ROWS = 3;
    COLS = 4;

    R_base = ((S * 0) + 1);
    R = R_base * -0.04;
    R(12) = 1;
    R(8) = -1;
    R(6) = 0;
end

% hyper parameters
eta = 0.05;
max_iter = 75;
gammas = [0.9, 0.99, 0.999, 0.9999, 0.99999, 0.999999];



for gamma = 1:length(gammas)
    [u,utrace] = CS4300_MDP_value_iteration(S,A,P,R,gammas(gamma),eta,max_iter);
    utility(gamma).utility = u;
    utility(gamma).trace = utrace;
end



%{
for i = 1:length(utility)
    figure
    hold on
    title(sprintf('Gamma: %f', gammas(i)))
    if WUMPUS
        plot(utility(i).trace(:,1));
        plot(utility(i).trace(:,4));
        plot(utility(i).trace(:,10));
        plot(utility(i).trace(:,13));
        plot(utility(i).trace(:,15));
        plot(utility(i).trace(:,16));
        legend('(1,1)','(4,1)','(2,3)','(1,4)','(3,4)','(4,4)','Location','northwest')
    else
        plot(utility(i).trace(:,1));
        plot(utility(i).trace(:,3));
        plot(utility(i).trace(:,4));
        plot(utility(i).trace(:,11));
        plot(utility(i).trace(:,12));
        legend('(1,1)','(3,1)','(4,1)','(3,3)','(4,3)','Location','northwest')
    end
    xlabel('Number of Iterations') % x-axis label
    ylabel('Utility Estimates') % y-axis label
    hold off
end
%}

p=CS4300_MDP_policy(S,A,P,utility(6).utility);
CS4300_print_matrix(p,ROWS,COLS);

