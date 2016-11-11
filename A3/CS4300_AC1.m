function D_revised = CS4300_AC1(G,D,P)
% CS4300_AC1 - AC1 function from Mackworth paper 1977
% On input:
%     G (nxn array): neighborhood graph for n nodes
%     D (nxm array): m domain values for each of n nodes
%     P (string): predicate function name; P(i,a,j,b) takes as
%     arguments:
%        i (int): start node index
%        a (int): start node domain value
%        j (int): end node index
%        b (int): end node domain value
% On output:
%     D_revised (nxm array): revised domain labels
% Call:
%     G = [0,0,0,0,0;0,0,0,0,0;1,1,0,1,1;0,0,0,0,0;0,0,0,1,0];
%     D = [1,1,1;1,1,1;1,1,0;1,1,0;1,1,0];
%     Dr = CS4300_AC1(G,D,’CS4300_P_Fig1’);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

updates_to_do = 1;

% populate the queue
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

while updates_to_do > 0
    updates_to_do = 0;
    % iterate over the queue of arcs
    for i = 1:size(que,1)
        q = que(i, 1:end);
        
        % check for revisions to the board
        revised = CS4300_REVISE(q(1), q(2), D, P);

        % if the resultant matrix contains a change,
        if ~all(all(revised == D))
            updates_to_do = updates_to_do + 1;
            D = revised;
        end
    end
end

D_revised = D;
