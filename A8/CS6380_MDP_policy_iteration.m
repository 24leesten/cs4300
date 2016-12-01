function [policy,U,Ut] = CS6380_MDP_policy_iteration(S,A,P,R,k,gamma)
% CS4300_MDP_policy_iteration - policy iteration
%  Chapter 17 Russell and Norvig (Table p. 657)
% On input:
%     S (vector): states (1 to n)
%     A (vector): actions (1 to k)
%     P (nxk array): transition model
%     R (vector): state rewards
%     gamma (float): discount factor
%     k (int): number of iterations
% On output:
%     p (nx1 vector): policy
% Call:
%
%    Layout:               1
%                          ˆ
%     9 10 11 12           |
%     5  6  7  8       2 <- ->  4
%     1  2  3  4           |
%                          V
%                          3
%     [S,A,R,P,U,Ut] = CS4300_run_value_iteration(0.999999,1000);
%     p = CS4300_MDP_policy_iteration(S,A,P,R,10,0.999)
%     p’
%
% ans =
%
%     1          corrresponds to:
%     2
%     2                 ->   ->  ->   X
%     2                 ˆ    X    ˆ   X
%     1                 ˆ    <-  <-  <-
%     1
%     1
%     1
%     4
%     4
%     4
%     1
%
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

DEBUG = false;
RANDOMPOL = true;
MAX_UNCHANGED = 7;

U = zeros(1,length(S));
U = CS4300_preserve_static_utilities(U);
Ut = U;
unchanged = true;

if RANDOMPOL
    policy = randi(4,1,length(S));
else
    policy = zeros(1,length(S));
end

iter = 0;
if DEBUG
    disp(sprintf('ITER %d ========================',iter));
    CS4300_print_matrix(U,3,4);
    CS4300_print_matrix(policy,3,4);
    iter = iter + 1;
end

unchangedcount = 0;

while true
        
    % update the utilties
    U = CS4300_iter_policy_eval(U,S,policy,P,R,gamma);
    U = CS4300_preserve_static_utilities(U);
    unchanged = true;
    
    for s = 1:length(S)
        max = -Inf;
        max_action = 0;
        for a = 1:length(A)
            % find the action with the maximum utility
            action_sum = CS4300_summation(P(s,a).probabilities, U);
            if action_sum > max
                max = action_sum;
                max_action = a;
            end
        end
        if any(policy==0)
            % On the first iteration, set all policies
            policy_sum = -Inf;
        else
            % otherwise check for new maximum policies
            policy_sum = CS4300_summation(P(s,policy(s)).probabilities, U);
        end
        % set the new policy
        if max > policy_sum
            policy(s) = max_action;
            unchanged = false;
        end
        
    end
    
    if DEBUG
        disp(sprintf('ITER %d ========================',iter));
        CS4300_print_matrix(U,3,4);
        CS4300_print_matrix(policy,3,4);
        iter = iter + 1;
    end
    
    % u trace
    Ut = [Ut;U];
        
    % it's optimal when unchanged
    if unchanged
        unchangedcount = unchangedcount + 1;
        if unchangedcount == MAX_UNCHANGED
            break;
        end
    end
end


