function sentence = CS4300_MPS(percept)
% CS3400_MPS - the make-percept-sentence function
% On input:
%     percept (1x5 num vector): a vector of boolean percepts
% On output:
%     sentence (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
%     clause (CNF datastructure): a conjunct of disjunctive clauses to be tested
% Call: 
%     percept = [0,0,1,0,1];
%     sentence = CS3400_MPS(percept);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%