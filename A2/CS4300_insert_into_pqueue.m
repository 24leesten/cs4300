function new_pq  = CS4300_insert_into_pqueue(pqueue,node,option)
% CS4300_insert_into_pqueue - inserts a node into a priority queue
% On input:
%     pqueue (node list): list of nodes sorted by their priority cost\
%     node = 1x9 struct array with fields:
%       parent
%       level
%       state
%       action
%       cost
%       g
%       h
%       children
%     option (int): picks insertion strategy for equal cost states
%        1: insert state before equal or greater than states
%        2: insert after equal or less than states
% On output:
%     new_pq (node list): the input list plus the input node
%     inserted at the correct position
% Call:
%   pq = CS4300_insert_into_pqueue(queue, node, 1|2);
%
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

LESS = 2;
GREATER = 1;

new_pq = [];

siz = size(pqueue);

% if its a new queue, just add the node
if siz(2) == 0
    new_pq = [node];
    return;
end

if 0
disp '*** PRIORITY QUEUE ***';
for n = pqueue
    disp (n.cost);
end
disp (node.cost);
end

switch (option)
    % insert BEFORE equivalent or lesser cost
    case LESS
        for i = 1:siz(2)
            % end of the array
            if i == siz(2) && pqueue(i).cost <= node.cost
                new_pq = [pqueue node];
                return;
            elseif pqueue(i).cost > node.cost
                % beginning of the array
                if i == 1
                    new_pq = [node pqueue];
                    return;
                % middle insertion
                else
                    new_pq = [pqueue(1:i-1) node pqueue(i:end)];
                    return;
                end
            end
        end
        
    % insert before equivalent or greater cost
    case GREATER
        for i = 1:siz(2)
            % end of the array
            if i == siz(2) && pqueue(i).cost < node.cost
                new_pq = [pqueue node];
                return;
            elseif pqueue(i).cost >= node.cost
                % beginning of the array
                if i == 1
                    new_pq = [node pqueue];
                    return;
                % middle insertion
                else
                    new_pq = [pqueue(1:i-1) node pqueue(i:end)];
                    return;
                end
            end
        end
end