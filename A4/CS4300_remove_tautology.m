function new_knowledge = CS4300_remove_tautology(k)
% CS4300_remove_tautology - remove any tautology
% On input:
%     k (CNF data structure): set of CNF clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
% On output:
%     new_knowledge (CNF data structure): results of removing tautology
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
% Call:  
%     k(1).clauses = [-1,1]
%     C = CS4300_remove_tautology(C);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
new_knowledge = [];
remove = false;
counter = 1;

% for each clause in the original knowledge base
for i = 1:length(k)
    clause = k(i).clauses;
    
    % identify any clause containing a tautology
    for j = 1:length(clause)
        val = -(clause(j));
        if ismember(val, clause)
            remove = true;
            break;
        end
    end
    
    % only return clauses without tautologies
    if remove == false
        new_knowledge(counter).clauses = clause;
        counter = counter + 1;
    else
        remove = false;
    end
end

    