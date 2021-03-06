function Sip = CS4300_RTP(sentences,thm,vars)
% CS4300_RTP - resolution theorem prover
% On input:
%     sentences (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
%     thm (CNF datastructure): a disjunctive clause to be tested
%     vars (1xn vector): list of variables (positive integers)
% On output:
%     Sip (CNF data structure): results of resolution
%        []: proved sentence |- thm
%        not []: thm does not follow from sentences
% Call:  (example from Russell & Norvig, p. 252)
%     DP(1).clauses = [-1,2,3,4];
%     DP(2).clauses = [-2];
%     DP(3).clauses = [-3];
%     DP(4).clauses = [1];
%     thm(1).clauses = [4];
%     vars = [1,2,3,4];
%     Sr = CS4300_RTP(DP,thm,vars);
% Author:
%     <Your name>
%     UU
%     Fall 2016
%
debug = false;

% append the theorem to the sentences
len = length(sentences) + 1;
clauses = sentences;
nthm = CS4300_NEG_THM(thm);
clauses = CS4300_cnf_union(clauses, nthm);

getstats = false;
loops = 0;
resolves = 0;

if debug
    disp('Knowledge Base');
    CS4300_cnf_print(clauses);
end

do = 1;
new = [];
while do
    loops = loops + 1;
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
            solvents = CS4300_remove_tautology(solvents);
            resolves = resolves + 1;
            
            % if the result is an empty array
            for inx = 1:length(solvents)
                if isempty(solvents(inx).clauses)
                    if getstats
                        disp 'final'
                        disp (loops);
                        disp (resolves);
                        disp (length(clauses));
                    end
                    Sip = [];
                    return;
                end
            end
            %if ~cnf_contains(clauses, solvent)
            % union solvent with new array
            if isempty(new)
                new = solvents;
            % add the solvents to new
            else
                new = CS4300_cnf_union(new, solvents);
            end
        end
    end
    
    % check for new as subset of clauses
    old_clauses_size = length(clauses);
    clauses = CS4300_cnf_union(clauses, new);

    if(old_clauses_size == length(clauses))
        if getstats
            disp 'final';
            disp (loops);
            disp (resolves);
            disp (length(clauses));
        end
        Sip = sentences;
        return;
    end
    
    if getstats
        disp 'loops and resolves';
        disp (loops);
        disp (resolves);
        disp (length(clauses));
    end
end
