function Sip = CS4300_RTP(sentences,thm,vars)
% CS4300_RTP - resolution theorem prover
% On input:
%     sentences (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
%     thm (CNF datastructure): a conjunct of disjunctive clauses to be tested
%     vars (1xn vector): list of variables (positive integers)
% On output:
%     Sip (CNF data structure): results of resolution
%        []: proved sentence |= thm
%        not []: thm does not follow from sentences
% Call:  (example from Russell & Norvig, p. 252)
%     DP(1).clauses = [-1,2,3,4];
%     DP(2).clauses = [-2];
%     DP(3).clauses = [-3];
%     DP(4).clauses = [1];
%     thm = [4];
%     vars = [1,2,3,4];
%     Sr = CS4300_RTP(DP,thm,vars);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

debug = false;

% append the theorem to the sentences
len = length(sentences) + 1;
clauses = sentences;
clauses(len).clauses = -thm;

if debug
    disp('Knowledge Base');
    CS4300_cnf_print(clauses);
end

do = 1;
new = [];
while do
    for i = 1:length(clauses)
        ci = clauses(i);
        si = ci.clauses;
        
        for j = 1:length(clauses)
            if i == j
                continue;
            end
            cj = clauses(j);
            sj = cj.clauses;

            % compare all clauses Ci Cj in sentences
            solvents = CS4300_RESOLVE(si, sj);
            
            % if the result is an empty array
            for inx = 1:length(solvents)
                if length(solvents(inx).clauses)==0
                    disp 'YES!';
                    sentences(len).clauses = thm;
                    Sip = sentences;
                    return;
                end
            end
            %if ~cnf_contains(clauses, solvent)
            % union solvent with new array
            if length(new) == 0
                new = solvents;
            % add the solvents to new
            else
                new = CS3400_cnf_union(new, solvents);
            end
        end
    end
    
    % check for new as subset of clauses
    old_clauses_size = length(clauses);
    clauses = CS3400_cnf_union(clauses, new);

    if(old_clauses_size == length(clauses)) 
        disp 'NOOOOO';
        Sip = sentences;
        return;
    end
end