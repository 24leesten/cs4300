function updated = CS4300_Intersect_thm(sentences,thm)
% CS4300_Intersect_thm
% On input:
%     sentences (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
%     thm (CNF datastructure): a conjunct of disjunctive clauses to be tested
% On output:
%     updated (CNF data structure): results of intersecting sentences and thm
% Call:  (example from Russell & Norvig, p. 252)
%     DP(1).clauses = [-1,2,3,4];
%     DP(2).clauses = [-2];
%     DP(3).clauses = [-3];
%     DP(4).clauses = [1];
%     thm = [2,3];
%     Sr = CS4300_Intersect_thm(DP,thm);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

disp 'THE FUNCTION CS4300_INTERSECT_THM IS NOW DEPRECATED.  SO... DONT USE IT';

for s = 1:length(sentences)
    result = [];
    clause = sentences(s).clauses;
    for elem = 1:length(clause)
        if ismember(clause(elem), thm)
            result = [result clause(elem)];
        end
    end
    updated(s).clauses = result;
end