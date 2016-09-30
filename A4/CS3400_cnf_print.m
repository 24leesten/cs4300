function CS3400_cnf_print(cnf)
% CS4300_cnf_print - print a cnf form structure
% On input:
%     cnf (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
% Call: 
%     DP(1).clauses = [-1,2,3,4];
%     DP(2).clauses = [-2];
%     DP(3).clauses = [-3];
%     DP(4).clauses = [1];
%     CS4300_cnf_print(DP);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

for inx = 1:length(cnf)
    disp(cnf(inx).clauses)
end

