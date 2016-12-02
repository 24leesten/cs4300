function folds = CS4300_get_k_folds(arr, k)
% CS4300_get_k_folds - returns the array as a set of k folds
% On input:
%     arr (vector): array
%     k (int): total number of folds
% On output:
%     folds (struct vector): array containing a fold array
%       folds.fold (vector): a partition of the original array
% Call:
%     CS4300_get_k_folds;
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

count = length(arr);
kcount = floor(count/k);

% first shuffle the data
shuffled = arr; %CS4300_fisher_yates(arr);

folds = [];

% then split the data into k folds
for i = 1:kcount
    breakEarly = false;
    this_fold = [];
    index = 0;
    
    % create the fold
    for j = 1:k
        index = ((i-1)*k) + j;
        this_fold = [this_fold shuffled(index)];
    end
    
    % if not enough elements exist on the tail to make a full fold
    % append them to the current fold
    if (count-index) < k
        this_fold = [this_fold shuffled(index+1:end)];
        breakEarly = true;
    end
    
    % append this fold to the folds index
    folds(i).fold = this_fold;
    
    % might need to break the loop early
    if breakEarly
        break;
    end
end

