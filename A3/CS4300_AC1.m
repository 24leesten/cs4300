function D_revised = CS4300_AC1(G,D,P)
% CS4300_AC1 - AC1 function from Mackworth paper 1977
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
%     G = [0,0,0,0,0;0,0,0,0,0;1,1,0,1,1;0,0,0,0,0;0,0,0,1,0];
%     D = [1,1,1;1,1,1;1,1,0;1,1,0;1,1,0];
%     Dr = CS4300_AC1(G,D,’CS4300_P_Fig1’);
% Author:
%     <Your name>
%     UU
%     Fall 2016
%