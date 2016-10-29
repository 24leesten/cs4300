function solutions = CS4300_find_solutions(nodes, last_index)
% CS3400_find_solutions - finds the solution nodes from root to goal leaf
%                    returns the solution as a (nx4) matrix of states
% On input:
%     nodes (node vector): the total list of expanded nodes
%     last_index (int): index of the goal node
% On output:
%     solutions (nx4 matrix): the states from root to goal.
% Authors:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

soln_list  = [last_index];
curr_node = nodes(last_index);
curr_index = last_index;

while curr_index > 1
    curr_index = curr_node.parent;
    curr_node = nodes(curr_index);
    soln_list = [curr_index soln_list];
end

solutions = [];

soln_size = size(soln_list);
soln_size = soln_size(2);

for s = 1:soln_size
    curr_index = soln_list(s);
    curr_node = nodes(curr_index);
    soln = [curr_node.state curr_node.action];
    solutions = [solutions; soln];
end