function stats = CS4300_WW3_stats(num_trials,f_name)
% CS4300_WW3_stats - Wumpus World 3 (hybrid agent) simulator
% On input:
%     num_trials (int): number of repetitions on the board
%     f_name (string): name of agent function
% On output:
%     score (int): agent score on game
%     trace (nx3 int array): trace of state
%       (i,1): x location
%       (i,2): y location
%       (i,3): action selected at time i
% Call:
%     [s,t] = CS4300_WW3_stats(50,'CS4300_hybrid_agent');
% Author:
%     T. Henderson
%     UU
%     Summer 2015
%
traces = [];

max_steps = 2000;

agent.x = 1;
agent.y = 1;
agent.alive = 1;  
agent.gold = 0;  % grabbed gold in same room
agent.dir = 0;  % facing right
agent.succeed = 0;  % has gold and climbed out
agent.climbed = 0; % climbed out

onelive = zeros(1,num_trials);
onescor = zeros(1,num_trials);
onesucc = zeros(1,num_trials);
onetime = zeros(1,num_trials);
twolive = zeros(1,num_trials);
twoscor = zeros(1,num_trials);
twosucc = zeros(1,num_trials);
twotime = zeros(1,num_trials);
threelive = zeros(1,num_trials);
threescor = zeros(1,num_trials);
threesucc = zeros(1,num_trials);
threetime = zeros(1,num_trials);

for i = 1:num_trials 
    disp(sprintf('I %d', i));
    
    disp 'ONE';
    clear(f_name);

    board1 = [0,0,0,3;...
        0,0,0,0;...
        2,1,0,0;...
        0,0,0,0];
    tic;
    [score,trace] = CS4300_WW1(max_steps,f_name,board1);
    t = toc;
    
    ag = trace(length(trace)).agent;
    onelive(i) = ag.alive;
    onescor(i) = score;
    onesucc(i) = ag.succeed;
    onetime(i) = t;
    %{
    disp 'TWO';
    clear(f_name);

    board2 = [0,0,0,1;...
        1,2,3,0;...
        0,0,0,0;...
        0,0,1,0];
    tic;
    [score,trace] = CS4300_WW1(max_steps,f_name,board2);
    t = toc;
    
    ag = trace(length(trace)).agent;
    twolive(i) = ag.alive;
    twoscor(i) = score;
    twosucc(i) = ag.succeed;
    twotime(i) = t;
    %}
    disp 'THREE';
    clear(f_name);

    board3 = [0,0,0,0;...
        0,0,0,0;...
        3,2,0,0;...
        0,1,0,0];
    tic;
    [score,trace] = CS4300_WW1(max_steps,f_name,board3);
    t = toc;
    
    ag = trace(length(trace)).agent;
    threelive(i) = ag.alive;
    threescor(i) = score;
    threesucc(i) = ag.succeed;
    threetime(i) = t;
    
end

stats.ol = onelive;
stats.oe = onescor;
stats.os = onesucc;
stats.ot = onetime;
stats.tl = twolive;
stats.te = twoscor;
stats.ts = twosucc;
stats.tt = twotime;
stats.hl = threelive;
stats.he = threescor;
stats.hs = threesucc;
stats.ht = threetime;