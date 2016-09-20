function stats = CS4300_a3_harness()
% CS4300_a3_harness - harness for running the a3 algorithms across tests
% On input:
%   N/A
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

trials = 200;

timings_1 = zeros(7, 6, trials);
timings_3 = zeros(7, 6, trials);

for n = 3:10			% board size
    G = ~eye(n,n); 		% adjacency matrix
    size_i = n-3;       % index of this board size for stat housing
    
    for prob_of_a_one = 0 : 0.2 : 1 	% start at 0, add 0.2 each iteration, end after 1
        prob_i = floor(prob_of_a_one*10)/2 + 1; % index of this probability
        ac1_seconds = 0;
        ac3_seconds = 0;
        
        % repeat trials on each probability for each board size
        for t = 1:trials
            
            % create a random board
    		D = CS4300_rand_D_matrix(prob_of_a_one, n);
            
            % time the run time on parsing that board            
    		tic;
            CS4300_AC1MOD(G,D,'CS4300_n_queens_predicate');
    		ac1_seconds = ac1_seconds + toc;
    		tic;
    		CS4300_AC3MOD2(G,D,'CS4300_n_queens_predicate');
    		ac3_seconds = ac3_seconds + toc;
            
            % burn out a round of 3x3 boards to prime the timer system and
            % prevent timing unassociated startup costs
            if n > 3
                timings_1(size_i, prob_i, t) = ac1_seconds;
                timings_3(size_i, prob_i, t) = ac3_seconds;
            end
        end
    end
end

stats = zeros(7, 6, 3);
for x = 1:7
    for y = 1:6
        stats(x,y,1) = mean(timings_1(x,y,:));
        stats(x,y,2) = mean(timings_3(x,y,:));
    end
end
for x = 1:7
    for y = 1:6
        if (stats(x,y,1) - stats(x,y,2)) >= 0
            stats(x,y,3) = 1;
        end
    end
end