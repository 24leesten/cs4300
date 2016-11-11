function vertices = CS4300_show_graph(G)
% CS4300_show_graph - Takes a graph provided to CS4300_AC1 and displays ...
%                   the edges between domains in a readable format.
% On input:
%     G (nxn array): neighborhood graph for n nodes
% On output:
%     vertices (n-vector of strings): readable format of the graph
% Call:
%     G = [0,0,0,0,0;0,0,0,0,0;1,1,0,1,1;0,0,0,0,0;0,0,0,1,0];
%     Dr = CS4300_show_graph(G);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

a = char('a');
len = size(G);

for y = 1:len
    node = char(a+y-1);
    edges = '';
    for x = 1:len
        if G(y,x)
            edges = strcat(edges, char(a+x-1));
        end
    end
    msg = sprintf('%s: %s', node, edges);
    disp(msg);
end
vertices = [];