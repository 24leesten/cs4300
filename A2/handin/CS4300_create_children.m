function children = CS4300_create_children(board, nodes, current_state, goal_state, parent_index)
% CS3400_Manhatten_Distance - find the manhatten distance from node's
%     coordinates to the golds coordinates.
% On input:
%     board (4x4 Array): the wumpus world board
%     nodes (List[node]): the node list
%     current_state (1x3 array): the current state of the parent node
%     goal_state (1x3 array): the final state used to compute the Manhatten Distance
%     parent_index (int): the index of the parent node
% On output:
%     children (1xn array): An array of the children
% Authors:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
children = [];

for action = 1:3
    % get the new state and make sure that it is not the current_state
    new_state = CS4300_update_state(current_state, action);
    if (all(eq(new_state,current_state)) == 1)
        continue;
    end
    
    % get the cell_contents of the new_state and make sure they are not a
    %    pit(1) or a Wumpus(3)
    cell_contents = board(4-new_state(2)+1,new_state(1));
    if (cell_contents == 1 || cell_contents == 3 || cell_contents == 4)
        continue;
    end
    
    % check if the new state is already listed in the nodes
    duplicate = CS4300_is_duplicate_child(new_state, nodes);
    if (duplicate)
        continue;
    end
    
    % We have met all the required conditions, we now want to create the child
    
    node.parent = parent_index;
    node.level = nodes(parent_index).level + 1;
    node.state = new_state;
    node.action = action;
    node.g = nodes(parent_index).g+1;
    node.h = CS4300_Manhatten_Distance(goal_state,new_state);
    node.cost = node.g + node.h;
    node.children = [];
    
    % add the child node to the array
    children = [children node]; 
end