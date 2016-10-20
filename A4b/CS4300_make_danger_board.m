function board = CS4300_make_danger_board(visited,kb)
% CS3400_get_surrounding - returns the adjacent locations which are visitab
% le, unvisited, and not deadly
% On input:
%     visted (4x4 int matrix): visited locations on the board
%         0: visited
%         1: unvisited
%     kb (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
% On output:
%     board (4x4 int array): board detailing nearby danger
% Call:
%     board = ones(4,4);
%     KB = [];
%     KB(1).clauses = [1];
%     plan = CS4300_get_surrounding(board,KB);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
STENCH = 1;
BREEZE = 2;
GLITTER = 3;
BUMP = 4;
SCREAM = 5;
WUMPUS = 6;
PIT = 7;
WUMPUS_DIED = 5000;

board = ones(4,4);

wumpDead = [];
wumpDead(1).clauses = WUMPUS_DIED;
wump_is_dead = CS4300_ASK(kb, wumpDead);

% proposal for decision making
% dangerboard:
% if no plan
% for each location with a 0 on the safe board
%	danger = 0 on the danger board
%	add 10 danger to all nearby non-0's for a breeze
%	add 10 danger to all nearby non-0's for a stench
for col = 1:4
    for y = 1:4
        thm = [];
        danger = 0;
        row = 4 - y + 1;
        
        % If we are on a visited location
        if visited(row, col) == 0
            board(row,col) = 0;     
            
            % Check if there is a breeze
            thm(1).clauses = CS4300_pos_consts(col, y, BREEZE);
            if CS4300_ASK(kb, thm)
               danger = danger + 10; 
            end
            % check if there is a stench if the wumpus is alive
            if ~wump_is_dead
                thm(1).clauses = CS4300_pos_consts(col, y, STENCH);
                if CS4300_ASK(kb, thm)
                   danger = danger + 10;
                end
            end
            
            % only add danger if there is any
            if (danger > 0)
                NORTH = row - 1;
                WEST = col - 1;
                SOUTH = row + 1;
                EAST = col + 1;

                if(NORTH > 0 && board(NORTH,col) > 0)
                    board(NORTH, col) = board(NORTH, col) + danger;
                end
                if(WEST > 0 && board(row,WEST) > 0)
                    board(row, WEST) = board(row, WEST) + danger;
                end
                if(SOUTH < 5 && board(SOUTH,col) > 0)
                    board(SOUTH, col) = board(SOUTH, col) + danger;
                end
                if(EAST < 5 && board(row,EAST) > 0)
                    board(row, EAST) = board(row, EAST) + danger;
                end 
            end
        end        
    end
end

for col = 1:4
    for y = 1:4
        row = 4 - y + 1;
        
        % for each location with a 1 on the safe board
        if visited(row, col) > 0
        
            %	add 100 danger if it contains a pit or a wumpus.
            thm = [];
            thm2 = [];
            thm(1).clauses = CS4300_pos_consts(col, y, PIT);
            thm2(1).clauses = CS4300_pos_consts(col, y, WUMPUS);
            if CS4300_ASK(kb, thm) || (~wump_is_dead && CS4300_ASK(kb, thm2))
                board(row, col) = 100;
            end

            % return to 1 if we can prove both no wumpus and no pit.
            thm(1).clauses = CS4300_pos_consts(col, y, -PIT);
            thm2(1).clauses = CS4300_pos_consts(col, y, -WUMPUS);
            if CS4300_ASK(kb, thm) && (wump_is_dead || CS4300_ASK(kb, thm2))
                board(row, col) = 1;
            end
        end
    end
end