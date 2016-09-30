function contained = cnf_contains(cnf, clause)
% cnf_contains - does the cnf contain the clause
% On input:
%     cnf (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
%     clause (CNF datastructure): a conjunct of disjunctive clauses to be tested
% On output:
%     contained (boolean): does the cnf contain the clause
% Call: 
%     DP(1).clauses = [-1,2,3,4];
%     DP(2).clauses = [-2];
%     DP(3).clauses = [-3];
%     DP(4).clauses = [1];
%     clause = [4];
%     Sr = cnf_contains(DP,clause);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

len = length(cnf);
contained = 0;
for inx=1:len
    if(length(cnf(inx).clauses) == length(clause) && all(clause == cnf(inx).clauses))
        contained = 1;
        return;
    end
end