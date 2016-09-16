function D_revised = CS4300_AC3(G,D,P)
% CS4300_AC3 - AC3 function from Mackworth paper 1977
% On input:
%     G (nxn array): neighborhood graph for n nodes
%     D (nxm array): m domain values for each of n nodes
%     P (string): predicate function name; P(i,a,j,b) takes as
%     arguments:
%        i (int): start node index
%        a (int): start node domain value
%        i (int): end node index
%        i (int): end node domain value
% On output:
%     D_revised (nxm array): revised domain labels
% Call:
%     G = 1 - eye(3,3);
%     D = [1,1,1;1,1,1;1,1,1];
%     Dr = CS4300_AC3(G,D,’CS6100_P_no_attack’);
% Author:
%     <Your name>
%     UU
%     Fall 2016
%

% populate the queue with all arcs in G.
len = size(G,1);
que_size = (len*len)-len;
que = zeros(que_size, 2);
index = 1;
for row = 1:size(G,1)
    for col = 1:size(G,2)
        if G(row, col) == 1
            que(index, 1) = row;
            que(index, 2) = col;
            index = index + 1;
        end
    end
end

que_used = zeros(que_size,2);
updates_to_do = 1;

while updates_to_do

    % iterate over the queue of arcs
    for i = 1:size(que,1)
        q = que(i, 1:end);
        
        % pop from waiting
        que(i, 1) = 0;
        que(i, 2) = 0;
        
        % push to used
        que_used(i, 1) = q(1);
        que_used(i, 2) = q(2);

        % check for revisions to the board
        revised = CS4300_REVISE(q(1), q(2), D, P);

        % if the resultant matrix contains a change, repopulate the queue
        if ~all(all(revised == D))
            D = revised;
            que = que + que_used;
            que_used = zeros(que_size,2);
            break;
        end
    end
    
    % if all arcs are popped, we're done updating.
    if sum(sum(que)) == 0
        updates_to_do = 0;
    end
end

D_revised = D;