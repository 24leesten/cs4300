function D_revised = CS4300_AC1OLD(G,D,P)
% CS4300_AC1OLD - AC1 function from Mackworth paper 1977
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

keep_going = true;

while keep_going
    CHANGE = false;
    for row = 1:size(G,1)
        for col = 1:size(G,2)
            % skip non-arced pairs
            if G(row,col) == 0
                continue;
            end
            % skip self-referential domains
            if row == col
                continue;
            end
            
            D_r = CS4300_REVISE(row,col,D,P);
            
            CHANGE = (~isequal(D,D_r) | CHANGE);
            D = D_r;
        end
    end
    keep_going = CHANGE;
end

D_revised = D;