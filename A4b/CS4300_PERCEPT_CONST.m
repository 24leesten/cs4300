function v = CS4300_PERCEPT_CONST(p)
% CS3400_PERCEPT_CONST - returns the int constant for the given percept
% On input:
%     p (string): percept value
% On output:
%     v (int): int value of the percept
% Call:
%     val = CS3400_PERCEPT_CONST('BREEZE');
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

switch (p)
    case 'BREEZE'
        v = 1;
    case 'PIT'
        v = 2;
    case 'STENCH'
        v = 3;
    case 'WUMPUS'
        v = 4;
    case 'GLITTER'
        v = 5;
    case 'GOLD'
        v = 6;
    otherwise
        v = -1;
end
