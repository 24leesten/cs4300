function [row, col] = CS4300_get_coords(state, rows, cols)
% CS4300_get_coords - take in a location on the board and get the row and col
%     position
% On input:
%     state (int): the numeric location on the board 
%     rows (int): num of rows on the board
%     cols (int): number of columns on the board
% On output:
%     row (int): row position
%     col (int): col position
% Call:
%     state = 6;
%     rows = 4;
%     cols = 4;
%     [xp,yp] = CS4300_get_coords(state,rows,cols);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

A = 1:(rows*cols);
B = reshape(A,[cols,rows]);
[col row] = find(B == state);