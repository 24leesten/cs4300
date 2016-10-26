function plan = CS4300_plan_path(curr_state, goal_state, astar_pathable)
% CS4300_plan_path - returns the path to the safest unvisited
% location.
% On input:
%     curr_state (1x3 int vector): [x y d] of current agent
%     goal_state (1x3 int vector): [x y d] of goal state
%     astar_pathable (4x4 int matrix): list of pathable locations
%         0: pathable
%         1: not-pathable
% On output:
%     plan (1xn int array): best plan from this location
% Call:
%     astar_pathable = [[1 1 1 0];[1 1 1 0];[0 1 0 0];[0 0 0 1]];
%     agent_loc = [1 1 0];
%     goal_loc = [3 1 0];
%     plan = CS4300_plan_path(agent_loc,goal_loc,astar_pathable);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

plan = [];

% find te astar results
[so no] = CS4300_Wumpus_A_star(astar_pathable, curr_state, goal_state, 'CS4300_A_star_Man');
        
disp (sprintf('solution from %d %d to %d %d', curr_state(1), curr_state(2), goal_state(1), goal_state(2)));
disp(so);

% add them iteratively to the plan
[m n] = size(so);
for idx = 1:m
    % skip the initial 0 action
    if idx == 1
        continue;
    end
    
    action = so(idx,4);
    plan = [plan; action];
end