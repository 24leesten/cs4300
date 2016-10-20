function plan = CS4300_can_shoot_wumpus(x,y,d,visited,kb)
% CS3400_can_shoot_wumpus - returns the plan to shoot a wumpus if we are
% certain we can kill it
% On input:
%     x (int): x position of the wumpus board
%     y (int): y position of the wumpus board
%     d (int): d facing direction of the agent
%     visted (4x4 int matrix): visited locations on the board
%         0: visited
%         1: unvisited
%     KB (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
% On output:
%     plan (1xn int array): plan to shoot wumpus from this location
% Call:
%     board = ones(4,4);
%     KB = [];
%     KB(1).clauses = [1];
%     plan = CS4300_can_shoot_wumpus(1,1,0,board,KB);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
STENCH = 1;
RIGHT = 2;
LEFT = 3;
SHOOT = 5;
WUMPUS = 6;
EAST = 0;
NORTH = 1;
WEST = 2;
SOUTH = 3;

plan = [];

wump_board = zeros(4,4);
thm = [];

for c = 1:4
    for r = 1:4
        % places we've visited obviously have no wumpus
        if visited(4-r+1,c) == 0
            continue;
        end
        
        thm(1).clauses = CS4300_pos_consts(c,r,-WUMPUS);
        result = ~CS4300_ASK(kb, thm);
        wump_board(4-r+1,c) = result;
    end
end

% can't do anything if we have no possible wumpus locations.
if sum(sum(wump_board)) == 0
    disp('no possible locations');
    return;
end

not_guaranteed = [];
guaranteed = [];

for c = 1:4
    for r = 1:4
        if wump_board(5-r,c) == 1
            thm(1).clauses = CS4300_pos_consts(c,r,WUMPUS);
            % find which spaces are guaranteeed to have a wumpus or not
            if CS4300_ASK(kb, thm)
                guaranteed = [c r];
            else
                not_guaranteed = [not_guaranteed; [c r]];
            end
        end
        
        % if we found a guaranteed spot for a wumpus
        if ~isempty(guaranteed)
            break;
        end
    end
    % if we found a guaranteed spot for a wumpus
    if ~isempty(guaranteed)
        break;
    end
end

while ~isempty(not_guaranteed)
    if ~isempty(guaranteed)
        target = guaranteed;
    else   
        [m n] = size(not_guaranteed);
        choice = randi(m);
        target = not_guaranteed(choice,:);
    end
    
    targetx = target(1);
    targety = target(2);

    goal_found = 0;

    % find a location to shoot from
    for c = 1:4
        for r = 1:4
            if visited(5-r,c) == 0
                if targetx == c || targety == r
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
    
    % if we didn't find a viable goal this time, pop and try again
    if ~goal_found
        not_guaranteed(choice,:) = [];
    else
        break;
    end
end

if ~goal_found
    disp('no goal found');
    return;
end

% find the plan
[so no] = CS4300_Wumpus_A_star(visited, [x y d], [goal d-1], 'CS4300_A_star_Man');
[m n] = size(so);
% we want the full plan except for the last step that takes us into the
% wumpus
dir = d;
for s = 1:m
    % skip the initial 0 action
    if s == 1
        continue;
    end
    
    % get the direction we are facing
    if s == m
        dir = so(s,3);
    end
    action = so(s,4);
    plan = [plan; action];
end

% face ourselves towards the wumpus
if targetx == goal(1)
    %north
    if (targety - goal(2)) > 0
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
elseif targety == goal(2)
    %west
    if (targetx - goal(1) < 0)
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

    