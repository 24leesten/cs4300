function [x_pr, y_pr] = CS4300_move(Dir, X, Y)
% CS4300_move - moves the agent one unit.  There is an 80% chance of moving
%     in the intended direction. 20% chance of moving lateral to that direction
%     (10% for each side), and a 0% chance of going backward.
% On input:
%     Dir (int): direction of movement
%       1: north
%       2: west
%       3: south
%       4: east
%     X (int): current x location on the board (wumpus rules)
%     Y (int): current y location on the board (wumpus rules)
% On output:
%     x_pr (int): resultant x location of the agent
%     y_pr (int): resultant y location of the agent
% Call:
%     Dir = 1;
%     X = 1;
%     Y = 1;
%     [xp,yp] = CS4300_move(Dir,X,Y);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

error = rand;

% step sideways to the right
if error <= 0.1
    D = mod(Dir-1,4);
    if D == 0
        D = 4;
    end
    [x_pr, y_pr] = step(D,X,Y);
    
% step sideways to the left
elseif error >= 0.9
    D = mod(Dir+1,4);
    if D == 0
        D = 4;
    end
    [x_pr, y_pr] = step(D,X,Y);
    
% move in the intended direction
else
    [x_pr, y_pr] = step(Dir,X,Y);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% actually move in a given direction
function [xp,yp] = step(d,x,y)

switch (d)
    
    case 1 % NORTH
        xp = x;
        yp = y + 1;
    case 2 % WEST
        xp = x - 1;
        yp = y;
    case 3 % SOUTH
        xp = x;
        yp = y - 1;
    case 4 % EAST
        xp = x + 1;
        yp = y;
    otherwise
        disp(sprintf('for some reason you want me to move in the direction: %d', d));
end

