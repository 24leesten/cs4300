function get_surrounding_tester
% CS3400_get_surrounding - returns the adjacent locations which are visitab
% le, unvisited, and not deadly
% percept.  Ex: (1,1,stench) = 17.  (1,1,breeze) = 33.
% On input:
% On output:
% Call:
%     get_surrounding_tester
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

board = [[1 1 1 0];[7 1 7 0];[0 6 0 0];[0 0 0 7]];
disp(board);
kb = CS4300_INIT_KB();
% a wumpus (6) is in 2,2.
% a pit (7) is in 1,3; 3,3; 4,1
add = [];
% add stenches
add(1).clauses = CS4300_pos_consts(1,2,1);
add(2).clauses = CS4300_pos_consts(2,1,1);
add(3).clauses = CS4300_pos_consts(3,2,1);
% add breezes
add(4).clauses = CS4300_pos_consts(1,2,2);
add(5).clauses = CS4300_pos_consts(3,2,2);
add(6).clauses = CS4300_pos_consts(3,1,2);
add(7).clauses = CS4300_pos_consts(4,2,2);
add(8).clauses = CS4300_pos_consts(4,3,2);
% add not stenches
add(9).clauses = CS4300_pos_consts(1,1,-1);
add(10).clauses = CS4300_pos_consts(3,1,-1);
add(11).clauses = CS4300_pos_consts(4,2,-1);
add(12).clauses = CS4300_pos_consts(4,3,-1);
add(13).clauses = CS4300_pos_consts(4,4,-1);
% add not breezes
add(14).clauses = CS4300_pos_consts(1,1,-2);
add(15).clauses = CS4300_pos_consts(2,1,-2);
add(16).clauses = CS4300_pos_consts(4,4,-2);

kb = CS4300_cnf_union(kb, add);
plan = [];

% assume agent is in 4,4 facing north
x = 4;
y = 4;
d = 1;
% should get back the plan [LEFT FORWARD]
plan = CS4300_get_surrounding(x,y,d,board,kb);
if ~isempty(plan) && all(plan == [3 1])
    disp('TEST 1 SUCCESS');
else
    disp('TEST 1 FAILURE');
end
