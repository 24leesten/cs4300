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

policy = zeros(1,length(S));

% for every state
for s=1:length(S)
    best_action = 0;
    best_val = -Inf;
    
    % for each action
    for a=1:length(A)
        
        % find the sum of all s', utilities for that action
        sum = CS4300_summation(P(s,a).probabilities, U);
        
        % update the best action when found 
        if sum > best_val
            best_val = sum;
            best_action = a;
        end
    end
    
    % set the policy for that state to the best action
    policy(s) = best_action;
end