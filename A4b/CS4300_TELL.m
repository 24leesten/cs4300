function knowledge = CS4300_TELL(KB, MPS)
% CS3400_TELL - adds MPS to the KB
% On input:
%     KB (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
%     MPS (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
% On output:
%     knowledge (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
%     clause (CNF datastructure): a conjunct of disjunctive clauses to be tested
% Call: 
%     KB(1).clauses = [1];
%     MPS(1).clauses = [2];
%     sentence = CS3400_TELL(percept);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

knowledge = CS4300_cnf_union(KB, MPS);