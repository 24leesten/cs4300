function num_nodes = CS4300_a2_q3_harness(option)
% CS4300_WW2 - Wumpus World 2 simulator
% On input:
%     option (int): 1 0r 2 to indicate order of queue insertion on a tie
% On output:
%     num_nodes (16x3 int array): trace of state
%       (i,1): x location
%       (i,2): y location
%       (i,3): num  of nodes in tree
% Call:
%     t = CS4300_S_Star_Q3_Harness(1);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
num_nodes = [];
for x = 1:4
    for y = 1:4
        board = zeros(4,4); % Board does not really matter
        board(x,y) = 2;
        [so, no] = CS4300_Wumpus_A_star1(board,[1,1,0],[x,y,1],'CS4300_Manhatten_Distance',option);
        height = size(no);
        num_nodes = [num_nodes; x y height(2)];
    end
end