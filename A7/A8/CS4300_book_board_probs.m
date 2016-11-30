function state_probabilities = CS4300_book_board_probs(state, action, rows, cols)
% CS4300_book_board_probs - take in a state and action and return the
% probability of getting to each neighboring state from there.
% On input:
%     state (int): the numeric location on the board 
%     action (int): the action being taken
%     rows (int): the number of rows on the board
%     cols (int): the number of columnts on the board
% On output:
%     state_probabilities (1xn float vector): the probability of reaching
%     states s'
% Call:
%     state = 6;
%     action = 1;
%     rows = 3;
%     cols = 4;
%     [xp,yp] = CS4300_book_board_probs(state,action, S, rows, cols);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

DEBUG = false;

% CONSTANTS
NORTH = 1;
WEST  = 2;
SOUTH = 3;
EAST  = 4;

[row,col] = CS4300_get_coords(state, rows, cols);

GO_NORTH = row+1;
GO_WEST  = col-1;
GO_SOUTH = row-1;
GO_EAST  = col+1;

if DEBUG
    disp (GO_NORTH);
    disp (GO_WEST);
    disp (GO_SOUTH);
    disp (GO_EAST);
end

CAN_NORTH = (GO_NORTH) <= rows && state ~= 2;
CAN_WEST  = (GO_WEST ) > 0 && state ~= 7;
CAN_SOUTH = (GO_SOUTH) > 0 && state ~= 10;
CAN_EAST  = (GO_EAST ) <= cols && state ~= 5;

if DEBUG
    disp (CAN_NORTH);
    disp (CAN_WEST);
    disp (CAN_SOUTH);
    disp (CAN_EAST);
end

state_probabilities = zeros(1,rows*cols);

switch (action)
    case NORTH
        if CAN_NORTH
            state_probabilities(CS4300_get_state(GO_NORTH, col, cols)) = ...
                state_probabilities(CS4300_get_state(GO_NORTH, col, cols)) + 0.8;
        else
            state_probabilities(state) = state_probabilities(state) + 0.8;
        end
        if CAN_WEST
            state_probabilities(CS4300_get_state(row, GO_WEST, cols)) = ...
                state_probabilities(CS4300_get_state(row, GO_WEST, cols)) + 0.1;
        else
            state_probabilities(state) = state_probabilities(state) + 0.1;
        end
        % cannot south
        if CAN_EAST
            state_probabilities(CS4300_get_state(row, GO_EAST, cols)) = ...
                state_probabilities(CS4300_get_state(row, GO_EAST, cols)) + 0.1;
        else
            state_probabilities(state) = state_probabilities(state) + 0.1;
        end
        
    % /////////////////////////////////////////////////////////////////////////////////////////////////////
    case WEST
        if CAN_NORTH
            state_probabilities(CS4300_get_state(GO_NORTH, col, cols)) = ...
                state_probabilities(CS4300_get_state(GO_NORTH, col, cols)) + 0.1;
        else
            state_probabilities(state) = state_probabilities(state) + 0.1;
        end
        if CAN_WEST
            state_probabilities(CS4300_get_state(row, GO_WEST, cols)) = ...
                state_probabilities(CS4300_get_state(row, GO_WEST, cols)) + 0.8;
        else
            state_probabilities(state) = state_probabilities(state) + 0.8;
        end
        if CAN_SOUTH
            state_probabilities(CS4300_get_state(GO_SOUTH, col, cols)) = ...
                state_probabilities(CS4300_get_state(GO_SOUTH, col, cols)) + 0.1;
        else
            state_probabilities(state) = state_probabilities(state) + 0.1;
        end
        % cannot east
          
    % /////////////////////////////////////////////////////////////////////////////////////////////////////
    case SOUTH
        % cannot north
        if CAN_WEST
            state_probabilities(CS4300_get_state(row, GO_WEST, cols)) = ...
                state_probabilities(CS4300_get_state(row, GO_WEST, cols)) + 0.1;
        else
            state_probabilities(state) = state_probabilities(state) + 0.1;
        end
        if CAN_SOUTH
            state_probabilities(CS4300_get_state(GO_SOUTH, col, cols)) = ... 
                state_probabilities(CS4300_get_state(GO_SOUTH, col, cols)) + 0.8;
        else
            state_probabilities(state) = state_probabilities(state) + 0.8;
        end
        if CAN_EAST
            state_probabilities(CS4300_get_state(row, GO_EAST, cols)) = ...
                state_probabilities(CS4300_get_state(row, GO_EAST, cols)) + 0.1;
        else
            state_probabilities(state) = state_probabilities(state) + 0.1;
        end
          
    % /////////////////////////////////////////////////////////////////////////////////////////////////////
    case EAST
        if CAN_NORTH
            state_probabilities(CS4300_get_state(GO_NORTH, col, cols)) = ...
                state_probabilities(CS4300_get_state(GO_NORTH, col, cols)) + 0.1;
        else
            state_probabilities(state) = state_probabilities(state) + 0.1;
        end
        % cannot west
        if CAN_SOUTH
            state_probabilities(CS4300_get_state(GO_SOUTH, col, cols)) = ...
                state_probabilities(CS4300_get_state(GO_SOUTH, col, cols)) + 0.1;
        else
            state_probabilities(state) = state_probabilities(state) + 0.1;
        end
        if CAN_EAST
            state_probabilities(CS4300_get_state(row, GO_EAST, cols)) = ...
                state_probabilities(CS4300_get_state(row, GO_EAST, cols))    + 0.8;
        else
            state_probabilities(state) = state_probabilities(state) + 0.8;
        end
          
end