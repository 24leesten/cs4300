function new_clause = CS4300_remove_unique(clause)
% CS4300_remove_unique - remove any duplicate elements
% On input:
%     clause (1xn vector): a clause
% On output:
%     new_clause (1xn vector): a clause
% Call:  
%     Ci = [1,3,4,1]
%     C = CS4300_remove_unique(C);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
new_clause = clause;
% remove duplicates
[~,index] = unique(new_clause,'first');
new_clause = new_clause(sort(index));
    