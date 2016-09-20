function D_revised = CS4300_AC3MOD2(G,D,P)
% CS4300_AC3MOD2 - AC3 function from Mackworth paper 1977
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
for row = 1:size(G)
    for col = 1:size(G)
        if G(row, col) == 1
            que(index, 1) = row;
            que(index, 2) = col;
            index = index + 1;
        end
    end
end

% while the queue is not empty
q_index = 1;
while q_index <= que_size
    % peek and pop
    q = que(q_index,:);
    a = q(1);
    b = q(2);
    que(q_index,1) = 0;
    que(q_index,2) = 0;
    q_index = q_index + 1;

    % check for revisions to the board
    revised = CS4300_REVISE(a, b, D, P);

    % revise (a, b, D, P)
    % if revised
    %   add back to the queue from G:
    %       any (i, a) where i != a and i != b

    % if the resultant matrix contains a change, repopulate the queue
    if ~all(all(revised == D))
        D = revised;

        % repopulate the queue
        for n = 1:size(G)
            % invariant for repopulated arcs
            if n == a || n == b
                continue;
            end
            % if an arc exists and isn't already on the que
            if G(n,a) == 1
                if ~ismember([n a], que, 'rows')
                    q_index = q_index - 1;
                    que(q_index,:) = [n a];
                end
            end
        end
    end
end

D_revised = D;