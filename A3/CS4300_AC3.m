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