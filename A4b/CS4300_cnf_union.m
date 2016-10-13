function union = CS4300_cnf_union(left, right)
% CS3400_cnf_union - does the cnf contain the clause
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
%     Sr = CS3400_cnf_union(DP,PD1);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

debug = false;

len = length(right);
union = left;

if isempty(left)
    union = right;
    return;
end

if debug
    disp ('left');
    CS4300_cnf_print(left);
    disp ('right');
    CS4300_cnf_print(right);
end

for inx = 1:len
    
    if debug 
        disp('union');
        CS4300_cnf_print(union);
        pause
    end
    
    if(~CS4300_cnf_contains(left, right(inx).clauses))
        l = length(union) + 1;
        union(l).clauses = right(inx).clauses;
    end
end