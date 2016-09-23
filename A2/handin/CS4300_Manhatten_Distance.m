function distance = CS4300_Manhatten_Distance(goal_state, node_state)
% CS3400_Manhatten_Distance - find the manhatten distance from node's
%     coordinates to the goals coordinates.
% On input:
%     goal_state (int vector): the state of the in which we will find the gold
%     node_state (int_vector): the state of the current node
% On output:
%     distance (int): The Manhatten Distance
% Authors:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

gold_x = goal_state(1);
gold_y = goal_state(2);
node_x = node_state(1);
node_y = node_state(2);

x_dist = abs(node_x-gold_x);
y_dist = abs(node_y-gold_y);

distance = y_dist + x_dist;