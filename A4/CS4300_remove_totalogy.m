function new_clause = CS4300_remove_totalogy(clause)
% CS4300_remove_totalogy - remove any totalogies
% On input:
%     clause (1xn vector): a clause
% On output:
%     new_clause (1xn vector): a clause
% Call:  (example from Russell & Norvig, p. 252)
%     Ci = [-1,1,3,4]
%     C = CS4300_remove_totalogy(C);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
new_clause = clause;
for inx = 1:length(clause)
    val = clause(inx);
    if ismember(-val, new_clause)
        new_clause(new_clause == val) = [];
        new_clause(new_clause == -val) = [];
    end
end
    
    
    