function [scores,successes,times] = CS4300_WWMC(max_steps,f_name)
% CS4300_WWMC - Wumpus World Monte Carlo agent simulator
% On input:
%     max_steps (int): maximum number of simulation steps
%     f_name (string): name of agent function
% On output:
%     scores (1x250 int vector): agent score on all 250 boards
%     successes (1x250 int vector): agent successes on all 250 boards
%     times (1x250 dbl vector): time on all 250 boards
% Call:
%     [s,c,t] = CS4300_WWMC(50,'CS4300_hybrid_agent');
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Summer 2015
%

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
    disp(sprintf('board num %d', b));
    % load the current board
    curr_board = all_boards.boards(b).board;
    disp(curr_board);
    tic;
    [score,trace] = CS4300_WW1(max_steps,f_name,curr_board);
    times(b) = toc;
    
    % record the answer
    scores(b) = score;
    successes(b) = trace(length(trace)).agent.succeed;
end

%{
disp 'ONE';
clear(f_name);

board1 = [0,0,0,3;...
    0,0,0,0;...
    2,1,0,0;...
    0,0,0,0];
[score,trace] = CS4300_WW1(max_steps,f_name,board1);
scores(1).board = board1;
scores(1).score = score;
scores(1).trace = trace;
%}
