function Sip = CS4300_RTP_old(sentences,thm,vars)
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

% append the theorem to the sentences
len = length(sentences) + 1;
clauses = sentences;
clauses(len).clauses = -thm;

counter = 1;

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
            solvent = CS4300_RESOLVE(si, sj);

            % if the result is an empty array 
            if length(solvent) == 0
                disp 'YES!';
                sentences(len).clauses = thm;
                Sip = sentences;
                return;
            end
            %if ~cnf_contains(clauses, solvent)
            % union solvent with new array
            if length(new) == 0
                new(1).clauses = solvent;
                counter = counter + 1;
            else
                if ~cnf_contains(new, solvent)
                    new(counter).clauses = solvent;
                    counter = counter + 1;
                end
            end
            %end
        end
    end
    
    % check for new as subset of clauses
    subset = 1;
    for n_c = 1:length(new)
        if ~cnf_contains(clauses, new(n_c).clauses)
            subset = 0;
            break;
        end
    end
    
    % if new is a subset of clauses, return not [];
    if subset
        disp 'NOOOOO';
        Sip = sentences;
        return;
    % else union new and clauses
    else
        clauses = cnf_union(clauses, new);
    end
end