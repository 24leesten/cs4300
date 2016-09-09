function new_state  = CS4300_update_state(current_state, action)
% CS4300_update_state - updates the state according to the action
% On input:
%     current_state (1x3 vector): x,y,dir state
%     action (int):
%       1 - FORWARD
%       2 - TURN RIGHT
%       3 - TURN LEFT
% On output:
%     new_state (1x3 vector): x,y,dir state
% Call:
%state = CS4300_new_state()
% new_state = [1 1 0]
%
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     FAll 2016
%

FORWARD = 1;
RIGHT = 2;
LEFT = 3;
EAST = 0;
NORTH = 1;
WEST = 2;
SOUTH = 3;

x = current_state(1);
y = current_state(2);
d = current_state(3);

switch (action)
    case FORWARD
        switch (d)
            case EAST
                if x < 4
                    x = x + 1;
                end
            case NORTH
                if y < 4
                    y = y + 1;
                end
            case WEST
                if x > 1
                    x = x - 1;
                end
            case SOUTH
                if y > 1
                    y = y - 1;
                end
        end
    case RIGHT
        d = mod(d - 1, 4);
    case LEFT
        d = mod(d + 1, 4);
end

new_state = [x y d];