function [score,success,time] = CS4300_WWNOMC(max_steps,f_name)
% CS4300_WWNOMC - Wumpus World Monte Carlo agent simulator
% On input:
%     max_steps (int): maximum number of simulation steps
%     f_name (string): name of agent function
% On output:
%     scores (1x250 int vector): agent score on all 250 boards
%     successes (1x250 int vector): agent successes on all 250 boards
%     times (1x250 dbl vector): time on all 250 boards
% Call:
%     [s,c,t] = CS4300_WWNOMC(50,'CS4300_MC_HWA');
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Summer 2015
%
n = 1000;
score = zeros(1,n);
success = zeros(1,n);
time = zeros(1,n);
for i = 1:n
    scores = zeros(1,250);
    successes = zeros(1,250);

    agent.x = 1;
    agent.y = 1;
    agent.alive = 1;  
    agent.gold = 0;  % grabbed gold in same room
    agent.dir = 0;  % facing right
    agent.succeed = 0;  % has gold and climbed out
    agent.climbed = 0; % climbed out


    all_boards = load('A5_boards.mat');
    % run 250 different trials
    for b = 1:250    
        clear(f_name);
        %disp(sprintf('board num %d', b));
        % load the current board
        curr_board = all_boards.boards(b).board;
        %disp(curr_board);
        tic;
        [score,trace] = CS4300_WW1(max_steps,f_name,curr_board);
        times(b) = toc;

        % record the answer
        scores(b) = score;
        successes(b) = trace(length(trace)).agent.succeed;
    end
    score(i)=mean(scores);
    success(i)=mean(successes);
    time(i)=mean(times);
end

score = mean(score);
success = mean(success);
time = mean(time);