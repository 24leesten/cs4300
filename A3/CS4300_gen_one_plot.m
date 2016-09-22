function CS4300_gen_one_plot(stats)
% CS4300_gen_one_plot - generate plots for ones
% On input:
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
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

% we want to loop through this row by row
for row = 1:7
  % get the max amount of ones
  max_ones = (3+row)*(3+row);
  % get a 1xN where N is the max amount of ones and fill with 1 through N
  ind = transpose(linspace(1,max_ones,max_ones));
  % add a column of zeroes to the end of the matrix for counting
  ones = [ind zeros(max_ones,1)];
  reduc_ones = [ind zeros(max_ones,1)];
  %disp(ones);
  for col = 1:6
    for matrix = 1:200
      num_ones = stats.onesbef(row,col,matrix);
      left_ones = stats.onesdif(row,col,matrix);
      if num_ones~=0   
        % count the total number of ones for each starting number of ones
        ones(num_ones,2) = ones(num_ones,2) + (1 * num_ones);
        % count the reduction in ones
        reduc_ones(num_ones,2) = reduc_ones(num_ones,2) + left_ones;
      end
    end
  end
  %disp(ones);
  %disp(reduc_ones);
  percentage_lost_ones = [ind zeros(max_ones,1)];
  average_lost_ones = [ind zeros(max_ones,1)];
  for ind=1:(3+row)*(3+row)
    % calculate the percentage of ones lost
    percentage_lost_ones(ind,2) = (reduc_ones(ind,2)/ones(ind,2));
    % calculate the average amount of ones lost
    average_lost_ones(ind,2) = ind * percentage_lost_ones(ind,2);
  end
  %disp(percentage_lost_ones);
  %disp(average_lost_ones);
  
  % PLOTS %
  f = figure();
  % Plot against percentage %
  subplot(1,2,1);
  plot(percentage_lost_ones(:,1), percentage_lost_ones(:,2))
  title(['Percentage Ones Lost for N=' num2str(row+3)]);
  xlabel('Starting Number of Ones');
  ylabel('Percentage Lost Ones');
  % Plot against average %
  subplot(1,2,2);
  scatter(average_lost_ones(:,1), average_lost_ones(:,2))
  title(['Average Ones Lost for N' num2str(row+3)]);
  xlabel('Starting Number of Ones');
  ylabel('Average Lost Ones');
  pos = get(f,'position');
  set(f,'position',[pos(1:2)/4 pos(3:4)*2]);
end