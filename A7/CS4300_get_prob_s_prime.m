function state_probabilities = CS4300_get_state_probs(state, action, S, rows, cols)
% CS4300_get_state_probs - take in a state and action and return the
% probability of getting to each neighboring state from there.
% On input:
%     state (int): the numeric location on the board 
%     action (int): the action being taken
%     S (1xn int vector): the states on the board
%     rows (int): the number of rows on the board
%     cols (int): the number of columnts on the board
% On output:
%     state_probabilities (
% Call:
%     state = 6;
%     action = 1;
%     S = [1:12];
%     rows = 3;
%     cols = 4;
%     [xp,yp] = CS4300_get_state_probs(state,action, S, rows, cols);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

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

CAN_NORTH = (GO_NORTH) > rows;
CAN_WEST  = (GO_WEST ) < 0;
CAN_SOUTH = (GO_SOUTH) < 0;
CAN_EAST  = (GO_EAST ) > cols;

state_probabilities = zeros(1,rows*cols);

switch (action)
    case NORTH
        if CAN_NORTH
            state_probabilities(CS4300_get_state(GO_NORTH, col, cols)) = CS4300_get_state(GO_NORTH, col, cols) + 0.8;
        else
            state_probabilities(state) = state_probabilities(state) + 0.8;
        end
        if CAN_WEST
            state_probabilities(CS4300_get_state(row, GO_WEST, cols)) = CS4300_get_state(row, GO_WEST, cols) + 0.1;
        else
            state_probabilities(state) = state_probabilities(state) + 0.1;
        end
        % cannot south
        if CAN_EAST
            state_probabilities(CS4300_get_state(row, GO_EAST, cols)) = CS4300_get_state(row, GO_EAST, cols) + 0.1;
        else
            state_probabilities(state) = state_probabilities(state) + 0.1;
        end
        
    % /////////////////////////////////////////////////////////////////////////////////////////////////////
    case WEST
        if CAN_NORTH
            state_probabilities(CS4300_get_state(GO_NORTH, col, cols)) = CS4300_get_state(GO_NORTH, col, cols) + 0.1;
        else
            state_probabilities(state) = state_probabilities(state) + 0.1;
        end
        if CAN_WEST
            state_probabilities(CS4300_get_state(row, GO_WEST, cols)) = CS4300_get_state(row, GO_WEST, cols) + 0.8;
        else
            state_probabilities(state) = state_probabilities(state) + 0.8;
        end
        if CAN_SOUTH
            state_probabilities(CS4300_get_state(GO_SOUTH, col, cols)) = CS4300_get_state(GO_SOUTH, col, cols) + 0.1;
        else
            state_probabilities(state) = state_probabilities(state) + 0.1;
        end
        % cannot east
          
    % /////////////////////////////////////////////////////////////////////////////////////////////////////
    case SOUTH
        % cannot north
        if CAN_WEST
            state_probabilities(CS4300_get_state(row, GO_WEST, cols)) = CS4300_get_state(row, GO_WEST, cols) + 0.1;
        else
            state_probabilities(state) = state_probabilities(state) + 0.1;
        end
        if CAN_SOUTH
            state_probabilities(CS4300_get_state(GO_SOUTH, col, cols)) = CS4300_get_state(GO_SOUTH, col, cols) + 0.8;
        else
            state_probabilities(state) = state_probabilities(state) + 0.8;
        end
        if CAN_EAST
            state_probabilities(CS4300_get_state(row, GO_EAST, cols)) = CS4300_get_state(row, GO_EAST, cols) + 0.1;
        else
            state_probabilities(state) = state_probabilities(state) + 0.1;
        end
          
    % /////////////////////////////////////////////////////////////////////////////////////////////////////
    case EAST
        if CAN_NORTH
            state_probabilities(CS4300_get_state(GO_NORTH, col, cols)) = CS4300_get_state(GO_NORTH, col, cols) + 0.1;
        else
            state_probabilities(state) = state_probabilities(state) + 0.1;
        end
        % cannot west
        if CAN_SOUTH
            state_probabilities(CS4300_get_state(GO_SOUTH, col, cols)) = CS4300_get_state(GO_SOUTH, col, cols) + 0.1;
        else
            state_probabilities(state) = state_probabilities(state) + 0.1;
        end
        if CAN_EAST
            state_probabilities(CS4300_get_state(row, GO_EAST, cols)) = CS4300_get_state(row, GO_EAST, cols) + 0.8;
        else
            state_probabilities(state) = state_probabilities(state) + 0.8;
        end
          
end