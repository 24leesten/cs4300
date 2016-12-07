function randomized_arr = CS4300_fisher_yates(arr)
% CS4300_fisher_yates - O(n) array shuffle
% On input:
%     arr (vector): array
% On output:
%     randomized_arr (vector): shuffled array
% Call:
%     CS4300_fisher_yates(arr);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%


for i = 1:length(arr)
    j = randi(i);
    
    if j ~= i
        temp = arr(i);
        arr(i) = arr(j);
        arr(j) = temp;
    end
end

randomized_arr = arr;