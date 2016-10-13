function c = CS4300_pos_consts(x, y, p)
% CS3400_GET_CONST - returns the constant value for the given location and
% percept.  Ex: (1,1,stench) = 17.  (1,1,breeze) = 33.
% On input:
%     x (int): x position of the wumpus board
%     y (int): y position of the wumpus board
%     p (int): percept value
%         0: Nothing
%         1: Stench
%         2: Breeze
%         3: Glitter
%         4: Bump
%         5: Scream
%         6: Wumpus
%         7: Pit
%         8: Gold
% On output:
%     c (int): int value of the percept at that location
% Call:
%     val = CS4300_pos_consts(1 1 1);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

% get board position value
b = x + (4 * (y - 1));

% get percpet scalar
sign = 1;
if p >= 0
    s = 16 * p;
else
    s = 16 * p * -1;
    sign = -1;
end

% return sum
c = (b + s) * sign;