function [pits,Wumpus] = CS4300_WP_estimates(breezes,stench,num_trials)
% CS4300_WP_estimates - SPLIT VERSION estimates pit and Wumpus likelihoods
% On input:
%   breezes (4x4 Boolean array): presence of breeze percept at cell
%       -1: no knowledge
%       0: no breeze detected
%       1: breeze detected
%   stench (4x4 Boolean array): presence of stench in cell
%       -1: no knowledge
%       0: no stench detected
%       1: stench detected
%   num_trials (int): number of trials to run (subset will be OK)
% On output:
%   pits (4x4 [0,1] array): likelihood of pit in cell
%   Wumpus (4x4 [0 to 1] array): likelihood of Wumpus in cell
% Call:
%   breezes = -ones(4,4);
%   breezes(4,1) = 1;
%   stench = -ones(4,4);
%   stench(4,1) = 0;
%   [pts,Wumpus] = CS4300_WP_estimates(breezes,stench,10000)
%   pts =
%   0.2021 0.1967 0.1956 0.1953
%   0.1972 0.1999 0.2016 0.1980
%   0.5527 0.1969 0.1989 0.2119
%   0      0.5552 0.1948 0.1839
%
%   Wumpus =
%   0.0806 0.0800 0.0827 0.0720
%   0.0780 0.0738 0.0723 0.0717
%   0      0.0845 0.0685 0.0803
%   0      0      0.0741 0.0812
% Author:
%   Ryan Keepers
%   Leland Stenquist
%   UU
%   Fall 2016
%

DEBUG = false;

% CONSTANTS
STENCH = 1;
BREEZE = 2;
GLITTER = 3;
BUMP = 4;
SCREAM = 5;

PIT = 1;
GOLD = 2;
WUMPUS = 3;
BOTH = 4;

pits_boards = zeros(4,4,num_trials);
Wumpus_boards = zeros(4,4,num_trials);

% initialize these arrays to (4x4 array) of zeroes
pits = zeros(4,4);
Wumpus = zeros(4,4);

total_stenches = sum(sum(stench==0));

% we need to generate num_trials amount of boards
% breezes only
for i = 1:num_trials
    add_board = false;
    % while we are getting bad boards keep looping
    while ~add_board
        add_board = true;
        % generate random board
        board = CS4300_gen_board(0.20);
        
        % check each location on our breezes and the generated board
        for r = 1:4
            row = fix_y(r);          
            for col = 1:4
                % only check the board if the locations known
                if breezes(row,col) ~= -1
                    % get the percepts based on the board generated for that
                    %     postition
                    agent.x = col;
                    agent.y = r; 
                    percepts = CS4300_get_percept(board, agent, false, false);
                    % if the breezes do not match for the board generated then we do not add it
                    if breezes(row,col) ~= -1 && breezes(row,col) ~=  percepts(BREEZE)
                        debug(DEBUG, breezes, board);
                        add_board = false;
                    end
                end
            end       
        end
        if add_board
            pits_boards(:,:,i) = (board == PIT);
        end
    end
end

% stenches only
if total_stenches < 16
    for i = 1:num_trials
        add_board = false;
        while ~add_board
            add_board = true;
            % generate random board
            board = CS4300_gen_board(0.2);

            % check each location on our stenches and the generated board
            for r = 1:4
                row = fix_y(r);
                for col = 1:4
                    if stench(row,col) ~= -1
                        % get the percepts based on the board generated for that
                        %     postition
                        agent.x = col;
                        agent.y = r; 
                        percepts = CS4300_get_percept(board, agent, false, false);

                        % then the stench locations need to match our board.
                        if stench(row,col) ~= -1 && stench(row,col) ~=  percepts(STENCH)
                            debug(DEBUG, breezes, board);
                            add_board = false;
                        end
                    end
                end
            end
            if add_board
                Wumpus_boards(:,:,i) = (board == WUMPUS);
            end
        end
    end
end

pits = mean(pits_boards, 3);
if total_stenches == 16
    Wumpus = zeros(4);
else
    Wumpus = mean(Wumpus_boards, 3);
end

function debug(bool, breezes, board)
if bool
    breezes
    board
end
    