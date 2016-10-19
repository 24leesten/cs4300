function m_var = solvable_checks(pits,runs)
% CS4300_gen_board - generate a Wumpus board
% On input:
%     pits (int): number of pits in the room
%     runs (int): number of times to run the function
% On output:
%     array
%     Mean  VAR
%     #.#   #.#
% Call:
%     b = solvable_checks(2,200);
% Author:
%     L. Stenquist
%     UU
%     Fall 2016
%

range = 1:runs;
list = [];

for i = range
    board = CS4300_gen_board_A1(pits);
    solvable = CS4300_Wumpus_solvable(board);
    list(end+1) = solvable;
end

m_var = [];
m_var(end+1) = mean(list);
m_var(end+1) = var(list);
