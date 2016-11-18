function policy = CS4300_MDP_policy(S,A,P,U)
% CS4300_MDP_policy - generate a policy from utilities
% See p. 648 Russell & Norvig
% On input:
%     S (vector): states (1 to n)
%     A (vector): actions (1 to k)
%     P (nxk array): transition model
%     U (vector): state utilities
% On output:
%     policy (vector): actions per state
% Call:
%     p = CS4300_MDP_policy(S,A,P,U);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

policy = zeros(1,9);

for s=1:length(S)
    action = 0;
    best_val = -Inf;
    
    for a=1:length(A)
        sum = CS4300_summation(P(s,a).probabilities, U);
        if sum > best_val
            best_val = sum;
            action = a;
        end
    end
    policy(s) = action;
end