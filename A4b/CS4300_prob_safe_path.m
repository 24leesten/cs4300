function plan = CS4300_prob_safe_path(x,y,d,danger,visited)
% CS4300_prob_safe_path - returns the path to the safest unvisited
% location.
% On input:
%     x (int): x position of the wumpus board
%     y (int): y position of the wumpus board
%     d (int): d facing direction of the agent
%     danger (4x4 int matrix): danger predictions for the board
%         0: visited
%         1+: potentially dangerous
%     visited (4x4 in matrix): list of visited spaces
%         0: visited
%         1: not visited
% On output:
%     plan (1xn int array): best plan from this location
% Call:
%     safe = [[1 1 1 0];[1 1 1 0];[0 1 0 0];[0 0 0 1]];
%     danger = [[1 1 1 0];[21 1 31 0];[0 51 0 0];[0 0 0 21]];
%     plan = CS4300_prob_safe_path(1,1,0,danger,safe);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

plan = [];
visitable = [];

for r = 1:4
    for col =1:4
        row = 4-r+1;
        % we know we have visited this location
        if(danger(row, col) == 0)
            continue;
        end
        
        adjacent = 0;
        
        % only go to locations which are reachable
        if(danger(row, col) == 1)
            % if we've visited NORTH 
            if (row - 1 > 0) && (danger(row - 1,col) == 0)
                adjacent = 1;
                visitable = [visitable; [col r]];
            end
            % if we've visited WEST 
            if ~adjacent && (col - 1 > 0) && (danger(row,col-1) == 0)
                adjacent = 1;
                visitable = [visitable; [col r]];
            end
            % if we've visited SOUTH
            if ~adjacent && (row + 1 < 5) && (danger(row + 1,col) == 0)
                adjacent = 1;
                visitable = [visitable; [col r]];
            end
            % if we've visited EAST
            if ~adjacent && (col + 1 < 5) && (danger(row,col + 1) == 0)
                visitable = [visitable; [col r]];
            end            
        end
    end
end

% if no safe spots are found, return an empty plan
if isempty(visitable)
    return; 
end

% pop the first visitable probably safe locaion
goal = visitable(1,:);
% tell the visited board we can go there.
visited(5-goal(2), goal(1)) = 0;

% find the plan
[so no] = CS4300_Wumpus_A_star(visited, [x y d], [goal d-1], 'CS4300_A_star_Man');
[m n] = size(so);
for s = 1:m
    % skip the initial 0 action
    if s == 1
        continue;
    end
    
    action = so(s,4);
    plan = [plan; action];
end