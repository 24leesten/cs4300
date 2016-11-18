function [row, col] = CS4300_get_state(curr_row, curr_col, cols)
% CS4300_get_state - take in a location on the board and get the row and col
%     position
% On input:
%     curr_row (int): num of rows on the board
%     curr_col (int): number of columns on the board
%     cols (int): number of columns on the board
% On output:
%     state (int): vector state
% Call:
%     curr_row = 4;
%     curr_col = 4;
%     cols = 4;
%     state = CS4300_get_state(state,cols);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

state = ((curr_row-1)*cols) + curr_col;