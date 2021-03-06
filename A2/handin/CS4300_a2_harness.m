function stats = CS4300_a2_harness(num_trials)
% CS4300_a2_harness - a harness for running CS4300_Wumpus_A_star1
% On input:
%     num_trials (int): number of repetitions
% On output:
%     stats (3x4 matrix): the resultant statistics for the trials
%       row 1: mean, var, conf_low, conf_high for trials on option 1
%       row 2: mean, var, conf_low, conf_high for trials on option 2
%       row 3: mean, var, conf_low, conf_high for option 1 compared to
%               option 2 (1 < 2 ? 1 : 0)
% Call:
%[so,no] = CS4300_a2_harness(1);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
 
r1 = zeros(num_trials, 1);
r2 = zeros(num_trials, 1);
initial_state = [1 1 0];


for opt = 1:2
%     option (int): picks insertion strategy for equal cost states
%        1: insert state before equal or greater than states
%        2: insert after equal or less than states
    for t = 1:num_trials
        % generate a board
        board = CS4300_gen_board(.2);

        % find the position of the gold
        if find(board == 2)
            [y x] = find(board == 2);
        else
            [y x] = find(board == 4);
        end
        gold_state = [x 4-y+1 0];
    
        % run the test
        [so,no] = CS4300_Wumpus_A_star1(board, initial_state, gold_state, '', opt);
        % add the result to the results
        sz_no = size(no);
        
        if opt == 1
            r1(t) = sz_no(2);
        else
            r2(t) = sz_no(2);
        end
    end
end

mn1 = mean(r1);
vr1 = var(r1);
cl1 = mn1 - 1.96*sqrt(vr1/num_trials);
ch1 = mn1 + 1.96*sqrt(vr1/num_trials);  

mn2 = mean(r2);
vr2 = var(r2);
cl2 = mn2 - 1.96*sqrt(vr2/num_trials);
ch2 = mn2 + 1.96*sqrt(vr2/num_trials);

compare = zeros(num_trials,1);
for ro = 1:num_trials
    if r1(ro) < r2(ro)
        compare(ro) = 1;
    end
end

mn3 = mean(compare);
vr3 = var(compare);
cl3 = mn3 - 1.96*sqrt(vr3/num_trials);
ch3 = mn3 + 1.96*sqrt(vr3/num_trials);

stats = [[mn1, vr1, cl1, ch1, min(r1), max(r1)];[mn2, vr2, cl2, ch2, min(r2), max(r2)];[mn3, vr3, cl3, ch3, 0, 0]];