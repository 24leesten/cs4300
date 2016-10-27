function plan = CS4300_plan_shot(agent,Wumpus,visited,safe,board)
% CS4300_MC_HWA - the hybrid wumpus agent ai algorithm
% On input:
%     agent (struct): agent struct defined by professor
%       agent.x (int): x position of agent on wumpus board
%       agent.y (int): y position of agent on wumpus board
%       agent.dir (int): facing position of agent on wumpus board
%     Wumpus (4x4 int): board of wumpus locations
%     visited (4x4 int): board of visited locations
%       -1: unvisited
%       1: visited
%     safe (4x4 int): board of safe locations
%       -1: unknown
%       1: safe
%     board (4x4 int): Not entirely sure, but the professor calls it.
% On output:
%     plan (1xn int vector): the next plan of actions to take
% Call:
%     agent = [];
%     agent.x = 1;
%     agent.y = 1;
%     agent.dir = 0;
%     Wumpus = zeros(4);
%     Wumpus(3,1) = 1;
%     visited = -ones(4);
%     visited(4,1) = 0;
%     safe = -ones(4);
%     safe(4,1) = 0;
%     board = -ones(4);
%     action = CS4300_plan_shot(agent, Wumpus, visited, safe, board));
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

% facing directions
NORTH = 1;
SOUTH = 3;
EAST = 0;
WEST = 2;

%ACTIONS
FORWARD = 1;
RIGHT = 2;
LEFT = 3;
GRAB = 4;
SHOOT = 5;
CLIMB = 6;

% find the position of the wumpus
[max_y target_x] = find(Wumpus == max(max(Wumpus)));

% might have more than one maximum.  Pick at random.
if length(target_x) > 1
    which = randi(length(target_x));
    target_x = target_x(which);
    max_y = max_y(which);
end

target_y = fix_y(max_y);

plan = [];

goal_found = 0;

% find a location to shoot from
for c = 1:4
    for r = 1:4
        if visited(fix_y(r),c) == 1
            if (target_x == c) || (target_y == r)
                goal = [c r 0];
                goal_found = 1;
                break;
            end
        end
    end
    if goal_found
        break;
    end
end

% if we cannot shoot at our goal position, make no plan
if ~goal_found
    return
end

% find the a_star solution
[so no] = CS4300_Wumpus_A_star(visited, [agent.x agent.y agent.dir], goal, 'CS4300_A_star_Man');
[m n] = size(so);

% start with our current facing direction.
dir = agent.dir;

% build out the plan from here to the goal.
for s = 1:m
    % skip the initial 0 action
    if s == 1
        continue;
    end

    % get the direction we are facing as we add to the plan.
    if s == m
        dir = so(s,3);
    end
    action = so(s,4);
    plan = [plan; action];
end

% arriving at the goal
% face ourselves towards the wumpus
if target_x == goal(1)
    %north
    if (target_y - goal(2)) > 0
        if dir == SOUTH
            plan = [plan; LEFT; LEFT];
        elseif dir == EAST
            plan = [plan; LEFT];
        elseif dir == WEST
            plan = [plan; RIGHT];
        end

    %south
    else
        if dir == NORTH
            plan = [plan; LEFT; LEFT];
        elseif dir == EAST
            plan = [plan; RIGHT];
        elseif dir == WEST
            plan = [plan; LEFT];
        end

    end
elseif target_y == goal(2)
    %west
    if (target_x - goal(1) < 0)
        if dir == EAST
           plan = [plan; LEFT; LEFT];
        elseif dir == NORTH
           plan = [plan; LEFT];
        elseif dir == SOUTH
           plan = [plan; RIGHT];
        end
    %east
    else
        if dir == WEST
           plan = [plan; LEFT; LEFT];
        elseif dir == NORTH
           plan = [plan; RIGHT];
        elseif dir == SOUTH
           plan = [plan; LEFT];
        end
    end
end

plan = [plan; SHOOT];
