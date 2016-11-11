function nthm = CS4300_NEG_THM(thm)
% CS4300_NEG_THM - resolution theorem prover
% On input:
%     thm (1xn vector): a clause
% On output:
%     nthm (CNF data structure): results of negating the theorem
% Call:  
%     thm = [-1,2,3,4];
%     nthm = CS4300_NEG_THM(thm);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

nthm = [];
neg = -thm;
for i = 1:length(neg)
    nthm(i).clauses = neg(i);
end