function CS4300_create_plots(r1, r2, m1, m2)
% CS4300_create_plots - create plots for data analysis
% On input:
%     r1: (nx1 matrix): matrix of # of nodes in trees given option 1 
%     r2: (nx1 matrix): matrix of # of nodes in trees given option 2
%     m1: (nx1 matrix): matrix of manhattem distance of root given option 1
%     m2: (nx1 matrix): matrix of manhattem distance of root option 2
% On output 
% Call:
% CS4300_create_plots([1 2 3],[1 3 6],[1 2 3],[1 3 6]);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%


% Sorted Number of nodes on Tree
figure();
plot(sort(r1),'b');
hold on;
plot(sort(r2),'r');
hold off;
title('Sorted Number of Nodes in the Tree');
xlabel('Number of Trials');
ylabel('Number of Nodes');
legend('option 1 trials', 'option 2 trials');

% Unsorted Number of nodes on Tree
figure();
plot(r1,'b');
hold on;
plot(r2,'r');
hold off;
title('Unsorted Number of Nodes in the Tree');
xlabel('Number of Trials');
ylabel('Number of Nodes');
legend('option 1 trials', 'option 2 trials');

% Sorted Histogram of nodes on tree.
figure();
histogram(r1);
hold on;
histogram(r2);
hold off;
title('Histogram of Nodes in the Trees');
xlabel('Number of Nodes');
ylabel('Times Number of Nodes Genreated');
legend('option 1 trials', 'option 2 trials');

% Number of nodes compared to manhatten distance
figure();
scatter(m1,r1,'b');
hold on;
scatter(m2,r2,'r');
hold off;
% assumes your trial size is 2000
title('Number of Nodes Compared to Manhatten Distance (2000 Runs)');
xlabel('Manhatten Distance of Root');
ylabel('Number of Nodes');
legend('option 1 trials', 'option 2 trials','Location','northoutside','Orientation','horizontal');

