function results = CS4300_random_agent(num_trials)
% CS4300_random-agent - random agent example
% It randomly either changes direction or moves forward
% On input:
% numb_trials int: total attempts
% On output:
% results (1x4 double array): 
% [mean, var, conf_low, conf_high]
% Call:
% a = CS4300_random_agent(5);
% Author:
% Ryan Keepers
% Leland Stenquist
% UU
% Fall 2016

FORWARD = 1;
ROTATE_RIGHT = 2;
ROTATE_LEFT = 3;

trials = zeros(1,num_trials);

board = [0,0,0,0;0,0,1,1;1,0,0,0;0,1,2,0];

for t = 1:num_trials
    % x coordinate of the agent
    curr_x = 1;
    % y coordinate of the agent
    curr_y = 1;
    % facing vector of the agent
    % maps to cardinal directions: NESW = 1234
    curr_v = 2;
    
    alive = 1;
    gold = 0;
    
    while alive == 1 && gold == 0
        next = CS4300_agent1(0);
        
        switch(next)
            case FORWARD
                new_pos = move_agent(curr_x, curr_y, curr_v);
                curr_x = new_pos(1);
                curr_y = new_pos(2);
                if board(curr_x, curr_y) == 1
                    alive = 0;
                elseif board(curr_x, curr_y) == 2
                    gold = 1;
                end
            case ROTATE_RIGHT
                curr_v = turn_agent(1, curr_v);
            case ROTATE_LEFT
                curr_v = turn_agent(0, curr_v);
        end
    end
    
    trials(1,t) = alive;
end

u = mean(trials);
s2 = var(trials);
conf_high = u + 1.645*sqrt(s2/num_trials);
conf_low = u - 1.645*sqrt(s2/num_trials);

results = [u, s2, conf_low, conf_high];


