function [solution,nodes]  = CS4300_Wumpus_A_star1(board,initial_state,...
goal_state,h_name,option)
% CS4300_Wumpus_A_star1 - A * algorithm for Wumpus world
% On input:
%     board (4x4 int array): Wumpus board layout
%       0: means empty cell
%       1: means a pit in cell
%       2: means gold (only) in cell
%       3: means Wumpus (only) in cell
%       4: means gold and Wumpus in cell
%     initial_state (1x3 vector): x,y,dir state
%     goal_state (1x3 vector): x,y,dir state
%     h_name (string): name of heuristic function
%     option (int): picks insertion strategy for equal cost states
%        1: insert state before equal or greater than states
%        2: insert after equal or less than states
% On output:
%     solution (nx4 array): solution sequence of state and the action
%     nodes (search tree data structure): search tree
%       (i).parent (int): index of node’s parent
%       (i).level (int): level of node in search tree
%       (i).state (1x3 vector): [x,y,dir] state represented by node
%       (i).action (int): action along edge from parent to node
%       (i).g (int): path length from root to node
%       (i).h (float): heuristic value (estimate from node to goal)
%       (i).cost (float): g + h   (called f value in text)
%       (i).children (1xk vector): list of node’s children
% Call:
%[so,no] = CS4300_Wumpus_A_star1([0,0,0,0;0,0,0,1;0,2,1,3;0,0,0,0],...
%          [1,1,0],[2,2,1],’CS4300_A_star_Man’,1)
% so =
%     1     1     0     0
%     2     1     0     1
%     2     1     1     3
%     2     2     1     1
%
% no = 1x9 struct array with fields:
%    parent
%    level
%    state
%    action
%    cost
%    g
%    h
%    children
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

nodes = []; % list of nodes
solution = []; % list of solution states
current_node_index = 1; % index of current node in nodes
pq = []; % priority queue

%create root node
node.parent = 0;
node.level = 0;
node.state = initial_state;
node.action = 0;
node.g = 0;
node.h = CS4300_Manhatten_Distance(goal_state, node.state);
node.cost = node.g + node.h;
node.children = [];
nodes = [node];

while true
    % check if agent has successfully reached the goal
    if node.state(1) == goal_state(1) && node.state(2) == goal_state(2);
        solution = CS4300_find_solutions(nodes, current_node_index);
        return;
    end
    
    % create children and add them to the list of nodes
    children = CS4300_create_children(board, nodes, node.state, goal_state, current_node_index);
    num_children = 1;
    size_nodes = size(nodes);
    for child = children
        % add children to parent node.children
        next_index = size_nodes(2) + num_children;
        node.children = [node.children next_index];
        num_children = num_children + 1;
        % add children to the priority queue
        pq = CS4300_insert_into_pqueue(pq, child, option);
    end
        
    % if we're at the root node, add it to the list of nodes
    if node.parent == 0
        nodes = [node];
    else % replace the node to preserve the child indices
        nodes = [nodes(1:current_node_index-1) node nodes(current_node_index+1:end)];
    end
    
    % add the children to the node list
    chldrn_size = size(children);
    if chldrn_size(2) > 0
        nodes = [nodes children];
    end
    
    % if the priority queue is empty, we have nothing left to explore
    pq_size = size(pq);
    if pq_size(2) == 0
        return;
    end
    
    % set the node to the next on the priority queue
    node = pq(1);
    pq = [pq(2:end)];
    current_node_index = CS4300_find_node_pos(nodes, node);
end