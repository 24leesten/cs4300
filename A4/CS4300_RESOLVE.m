function resolvents = CS4300_RESOLVE(Ci,Cj)
% CS4300_RESOLVE - resolution theorem prover
% On input:
%     Ci (1xn vector): a clause
%     Cj (1xn vector): a clause
% On output:
%     Sip (CNF data structure): results of resolution
%        []: proved sentence |= thm
%        not []: thm does not follow from sentences
% Call:  (example from Russell & Norvig, p. 252)
%     Ci = [-1,2,3,4];
%     Cj = [-2];
%     Sr = CS4300_RESOLVE(Ci, Cj);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

% We want to returns all resolvents. A resolvent is two clauses that are
% ORed together after we have found a two leterals that contradict. There
% may be multiple resolvents.


resolvents = [];
count = 0;
% resolve ci, cj
for k = 1:length(Ci)
    %resolvents(k).clauses = Ci;    
    for l = 1:length(Cj)
        if Ci(k) + Cj(l) == 0
            count = count + 1;
            Ci_t = Ci;
            Cj_t = Cj;
            Ci_t(k) = [];
            Cj_t(l) = [];
            clause = CS4300_remove_totalogy([Ci_t Cj_t]);
            resolvents(count).clauses = clause; 
            % union the clauses without the conflict
        end
    end
end

