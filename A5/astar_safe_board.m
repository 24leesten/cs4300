function astar_safe = astar_safe_board(safe,x,y)
% astar_safe_board - converts a safe board to an a-star standard safe board
% position.  x,y on the astar safe board will be set to 0 (pathable)
% On input:
%   safe (4x4 wumpus board)
%     -1: unknown
%      1: safe
%   x (int): wumpus board x-position destination
%   y (int): wumpus board y-position destination
% On output:
%   astar_safe (4x4 wumpus board)
%      1: not pathable
%      0: pathable
% Call:
%     safe = [[-1 -1 -1 -1];[-1 1 -1 -1];[-1 1 -1 -1];[1 1 1 1]];
%     x = 3;
%     y = 3;
%     astar_safe = astar_safe_board(safe,x,y);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

% convert to the board values to the correct key
astar_safe = (safe-1)/-2;

% ensure the destination is labeled 0.
astar_safe(fix_y(y),x) = 0;