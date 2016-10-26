function row = fix_y(y)
% fix_y - converter from wumpus board y position to matlab matrix row
% position
% On input:
%     y (integer): wumpus world board y position
% On output:
%     row (integer): matlab matrix y position
% Call:
%     y = 1;
%     row = fix_y(y);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

row = 4-y+1;