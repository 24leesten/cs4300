function stats = CS4300_a3_harness(alg)
% CS4300_a3_harness - harness for running the a3 algorithms across tests
% On input:
%   alg (string): function name for either the AC1 or AC3 algorithm
% On output:
%     Stats: (nxm matrix) relevant stats for the trials
% Call:
%     results = CS4300_a3_harness('CS4300_AC1');
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

G = [0,0,0,0,0;0,0,0,0,0;1,1,0,1,1;0,0,0,0,0;0,0,0,1,0];
test1 = [1,1,1;
         1,1,1;
         1,1,1];
test2 = [1,0,0,1,0,1,0;
         0,0,0,0,1,1,1;
         1,1,0,0,0,0,1;
         1,0,1,0,1,0,1;
         0,1,0,1,0,1,0;
         0,0,0,0,0,0,0;
         1,1,1,1,1,1,1;];
D = [1,1,1;1,1,0;1,1,0;0,1,1;0,0,1;1,0,1;0,1,0];

current_graph = test2;

CS4300_show_graph(current_graph);
disp(D);

stats = feval(alg,current_graph,D,'CS4300_test_predicate');