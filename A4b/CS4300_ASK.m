function answer = CS4300_ASK(kb, thm)
% CS3400_ASK - use RTP to test the theorem against our knowledge base
% On input:
%     answer (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)     
%     thm (CNF data structure): 1 disjunctive clause to be tested
% On output:
%     answer (boolean): true if the theorem was proven
% Call: 
%     ask = [];
%     ask(1).clauses = [1 2 3 4];
%     ask(2).clauses = [1 4];
%     ask(3).clauses = [-1];
%     ask(4).clauses = [-2];
%     ask(5).clauses = [-3];
%     thm = [];
%     thm(1).clauses = [4];
%     answer = CS4300_ASK(kb, thm);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
vars = CS4300_get_vars(kb, thm);
result = CS4300_RTP(kb, thm, vars);

if isempty(result)
    answer = true;
else
    answer = false;
end
