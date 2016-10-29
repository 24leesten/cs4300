function index  = CS4300_find_node_pos(nodes,node)
% CS4300_find_node_pos - returns the index of the given node
% On input:
%     nodes (node list): list of all nodes
%     node = 1x9 struct array with fields:
%       parent
%       level
%       state
%       action
%       cost
%       g
%       h
%       children
% On output:
%     index (int): index of the node, or 0 if it doesn't exist;
% Call:
%   pq = CS4300_find_node_pos(nodes, node);
%
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
index = 1;

for n = nodes
    if all(eq(n.state, node.state))
        return;
    end
    index = index + 1;
end

index = 0;