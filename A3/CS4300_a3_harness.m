function stats = CS4300_a3_harness()
% CS4300_a3_harness - harness for running the a3 algorithms across tests
% On input:
%   N/A
% On output:
%     stats: (struct) relevant stats for the trials
%       stats.times1 (7x6x200 matrix) all timings for AC1
%       stats.times3 (7x6x200 matrix) all timings for AC3
%       stats.mean1  (7x6 matrix) mean timing for AC1
%       stats.mean3  (7x6 matrix) mean timing for AC3 
%       stats.diff   (7x6 matrix) diff of AC1 mean time - AC3 mean time
%       stats.better (7x6 matrix) value = 1 if AC3 mean faster than AC3
%       stats.onesbef(7x6x200 matrix) starting 1's for each trial
%       stats.onesaft(7x6x200 matrix) ending 1's for each trial
%       stats.onesdif(7x6x200 matrix) diff in 1's for each trial
%       stats.mean1s (7x6 matrix) mean reduction of 1's 
%       
% Call:
%     results = CS4300_a3_harness('CS4300_AC1');
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

trials = 200;

timings_1 = zeros(7, 6, trials);
timings_3 = zeros(7, 6, trials);
ones_bef = zeros(7,6,trials);
ones_aft = zeros(7,6,trials);
ones_diff = zeros(7, 6, trials);

for n = 3:10			% board size
    G = ~eye(n,n); 		% adjacency matrix
    size_i = n-3;       % index of this board size for stat housing
    
    for prob_of_a_one = 0 : 0.2 : 1 	% start at 0, add 0.2 each iteration, end after 1
        prob_i = floor(prob_of_a_one*5) + 1; % index of this probability
        
        % repeat trials on each probability for each board size
        for t = 1:trials
            ac1_seconds = 0;
            ac3_seconds = 0;
            
            % create a random board
    		D = CS4300_rand_D_matrix(prob_of_a_one, n);
            ones = sum(sum(D));
            
            % time the run time on parsing that board            
    		tic;
            d_rev = CS4300_AC1(G,D,'CS4300_n_queens_predicate');
    		ac1_seconds = toc;
            ones_rev = sum(sum(d_rev));
    		tic;
    		d_rev = CS4300_AC3(G,D,'CS4300_n_queens_predicate');
    		ac3_seconds = toc;
            
            % burn out a round of 3x3 boards to prime the timer system and
            % prevent timing cost of unassociated startup
            if n > 3
                timings_1(size_i, prob_i, t) = ac1_seconds;
                timings_3(size_i, prob_i, t) = ac3_seconds;
                ones_diff(size_i, prob_i, t) = ones - ones_rev;
                ones_bef(size_i, prob_i, t) = ones;
                ones_aft(size_i, prob_i, t) = ones_rev;
            end
        end
    end
end

stats.times1 = timings_1;
stats.times3 = timings_3;
stats.onesbef = ones_bef;
stats.onesaft = ones_aft;
stats.onesdif = ones_diff;
mean_1 = zeros(7,6);
mean_3 = zeros(7,6);
mean_o = zeros(7,6);
for x = 1:7
    for y = 1:6
        mean_1(x,y) = mean(timings_1(x,y,:));
        mean_3(x,y) = mean(timings_3(x,y,:));
        mean_o(x,y) = mean(ones_diff(x,y,:));
    end
end
stats.mean1 = mean_1;
stats.mean3 = mean_3;
stats.mean1s = mean_o;
ac3_better = zeros(7,6);
ac_diff = zeros(7,6);
for x = 1:7
    for y = 1:6
        ac_diff(x,y) = mean_1(x,y) - mean_3(x,y);
        if ac_diff(x,y) > 0
            ac3_better(x,y) = 1;
        end
    end
end
stats.diff = ac_diff;
stats.better = ac3_better;