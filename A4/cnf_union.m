function union = cnf_union(left, right)
% cnf_union - does the cnf contain the clause
% On input:
%     left (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
%     right (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
% On output:
%     union (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
% Call: 
%     DP(1).clauses = [-1,2,3,4];
%     DP(2).clauses = [-2];
%     PD1(1).clauses = [-3];
%     PD1(2).clauses = [1];
%     Sr = cnf_union(DP,PD1);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

len = length(right);
union = left;

if isempty(left)
    union = right;
    return;
end

for inx = 1:len
    if(~cnf_contains(left, right(inx).clauses))
        l = length(left) + 1;
        union(l).clauses = right(inx).clauses;
    end
end