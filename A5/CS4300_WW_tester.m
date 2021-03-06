function CS4300_WW_tester(f_name)
% CS4300_WW_tester - Wumpus World test set
% On input:
%     f_name (string): name of agent function
% Call:
%     CS4300_WW_tester('CS4300_agent');
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Summer 2015
%

agent.x = 1;
agent.y = 1;
agent.alive = 1;  
agent.gold = 0;  % grabbed gold in same room
agent.dir = 0;  % facing right
agent.succeed = 0;  % has gold and climbed out
agent.climbed = 0; % climbed out

PASSES = 0;
max_steps = 10000;

disp 'Test Board 1';
clear(f_name);
board1 = [0,0,0,0;...
    0,0,2,0;...
    0,0,0,0;...
    0,0,0,0]
[score,trace] = CS4300_WW1(max_steps,f_name,board1);
if ~trace(length(trace)).agent.succeed
    disp 'Test 1 fails';
else
    PASSES = PASSES + 1;
end

disp 'Test Board 2';
clear(f_name);
board2 = [0,0,1,0;...
    0,1,4,1;...
    0,0,1,0;...
    0,0,0,0]
[score,trace] = CS4300_WW1(max_steps,f_name,board2);
if trace(length(trace)).agent.alive
    disp 'Test 2 fails';
else
    PASSES = PASSES + 1;
end

disp 'Test Board 3';
clear(f_name);
board3 = [0,0,0,0;...
    0,0,4,0;...
    0,0,0,0;...
    0,0,0,0]
[score,trace] = CS4300_WW1(max_steps,f_name,board3);
if ~trace(length(trace)).agent.succeed
    disp 'Test 3 fails';
else
    PASSES = PASSES + 1;
end

disp 'Test Board 4';
% 4 may or may not pass because of the probability in MC
% but at least 1 in 100 should pass.
board4 = [0,0,0,0;...
    3,0,2,0;...
    0,1,0,0;...
    0,0,1,0]
for testing = 1:100
    clear(f_name);
    [score,trace] = CS4300_WW1(max_steps,f_name,board4);
    if trace(length(trace)).agent.succeed
        continue;
    end
end;
if ~trace(length(trace)).agent.succeed
    disp 'Test 4 fails';
else
    PASSES = PASSES + 1;
end


disp(sprintf('Tests passed: %d out of 4', PASSES));
