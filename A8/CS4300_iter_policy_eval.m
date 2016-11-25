function Up = CS4300_iter_policy_eval(U,S,Pol,P,R,gamma)
% CS4300_iter_policy_eval - quick policy evaluation as stated in:
%  Chapter 17 Russell and Norvig (Table p. 657)
% On input:
%     U (vector): utilites (1 to n)
%     S (vector): states (1 to n)
%     Pol (vector): policies (1 to n)
%     P (nxk array): transition model
%     R (vector): state rewards
%     gamma (float): discount factor
% On output:
%     p (nx1 vector): policy
% Call:
%     [S,A,R,P,U,Ut] = CS4300_run_value_iteration(0.999999,1000);
%     p = CS4300_iter_policy_eval(U,S,A,P,R,0.999)

% linagl version

% create A
A = zeros(12);
for s = 1:length(S)
    if Pol(s) ~= 0
        A(s,:) = P(s, Pol(s)).probabilities;
    end
end

Up = (A*U')*gamma + R';

Up = Up';

% classic version

%{
for s = 1:length(S)
    
    if sum(Pol) == 0
        % on the first run of MDP_policy_iteration, we expect policy to
        % contain all 0's.
        summation = 0;
    
    else
        % find the sum given the current policies
        state_probs = P(s,Pol(s)).probabilities;
        summation = CS4300_summation(state_probs, U);
    end
    
    % update U
    Up(s) = R(s) + (gamma * summation);
end
%}