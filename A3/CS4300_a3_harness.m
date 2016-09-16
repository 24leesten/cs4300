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

trials = 20;

timings = zeros(7, 6, 2);

for n = 3:10			% board size
    G = ~eye(n,n); 		% adjacency matrix
    size_i = n-3;       % index of this board size for stat housing
    
    for prob_of_a_one = 0 : 0.2 : 1 	% start at 0, add 0.2 each iteration, end after 1
        prob_i = floor(prob_of_a_one*10)/2 + 1; % index of this probability
        ac1_seconds = 0;
        ac3_seconds = 0;
        
        % 200 trials on each probability for each board size
        for trials = 1:trials
            
            % create a random board
    		D = CS4300_rand_D_matrix(prob_of_a_one, n);
            
            % time the run time on parsing that board            
    		tic;
            CS4300_AC1(G,D,'CS4300_n_queens_predicate');
    		ac1_seconds = ac1_seconds + toc;
    		tic;
    		CS4300_AC3(G,D,'CS4300_n_queens_predicate');
    		ac3_seconds = ac3_seconds + toc;
        end

        % burn out a round of 3x3 boards to prime the timer system and
        % prevent timing unassociated startup costs
        if n > 3
            timings(size_i, prob_i, 1) = ac1_seconds/trials;
            timings(size_i, prob_i, 2) = ac3_seconds/trials;
        end

    end
end

stats = timings;
disp 'IGNORE ME!';
disp (stats(1, 1:end, 1:end));