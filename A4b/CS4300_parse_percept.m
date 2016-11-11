function v = CS4300_parse_percept(p)
% CS3400_PERCEPT_CONST - returns an int vector representing the percepts
% On input:
%     percept (1x5 Boolean array): percept values
%       (1): Stench variable (neighbors wumpus)
%       (2): Breeze variable (neighbors pit)
%       (3): Glitter variable (cell contains gold)
%       (4): Bump variable (hit wall trying to move)
%       (5): Scream variable (arrow killed wumpus)
% On output:
%     v (1x5 num vector): int values of the present percepts
% Call:
%     val = CS4300_parse_percept([0 1 0 1 1]);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
v = [];
if p(1)
    v = [v 1];
else
    v = [v (-1*1)];
end
if p(2)
    v = [v 2];
else
    v = [v (-1*2)];
end
if p(3)
    v = [v 3];
else
    v = [v (-1*3)];
end
if p(4)
    v = [v 4];
else
    v = [v (-1*4)];
end
if p(5)
    v = [v 5];
else
    v = [v (-1*5)];
end