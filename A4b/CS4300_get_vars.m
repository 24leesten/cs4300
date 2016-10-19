function vars = CS4300_get_vars(kb, thm)
% CS3400_get_vars - turns the KB and thm into a set of abs value variables
% On input:
%     answer (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)%     
%     thm (CNF data structure): 1 disjunctive clause to be tested
% On output:
%     answer (1xn int matrix): set of variables in KB and THM
% Call: 
%     kb = [];
%     thm = [];
%     kb(1).clauses = [1 2 3 4];
%     thm(1).clauses = [-3];
%     vars = CS4300_get_vars(kb, thm);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
vars = [];

for k = 1:length(kb)
    clause = abs(kb(k).clauses);
    vars = union(vars, clause);
end

vars = union(vars, abs(thm(1).clauses));