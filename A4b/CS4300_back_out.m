function plan = CS4300_back_out(x,y,d,visited,steps)
% CS3400_back_out - sets a plan to reach the (1,1) board location and climb
% out.
% On input:
%     x (int): x position of the wumpus board
%     y (int): y position of the wumpus board
%     d (int): d facing direction of the agent
%     visted (4x4 int matrix): visited locations on the board
%         0: visited
%         1: unvisited
%     steps (int): the number of steps to back out
% On output:
%     plan (1xn int array): exit plan from this location
% Call:
%     board = zeros(4,4);
%     plan = CS4300_get_surrounding(1,1,0,board,1);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

% find the a-star path
[so no] = CS4300_Wumpus_A_star(visited, [x y d], [1 1 2], 'CS4300_A_star_Man');
plan = [];
if steps > 0
    remaining = steps;
else
    remaining = 1;
end

if so(4) == 0 && length(so) == 4
    plan = [6];
    return;
end

for s = 1:length(so)
    % skip the initial 0 action
    if s == 1
        continue;
    end
    
    action = so(s,4);
    
    if remaining == 0
        break;
    end
    if steps > 0 && action == 1
        remaining = remaining - 1;
    end
    plan = [plan; action];
end

if remaining > 0
    plan = [plan; 6];
end

disp(plan);