function [U,U_trace] = CS4300_MDP_value_iteration(S,A,P,R,gamma,...
eta,max_iter)
% CS4300_MDP_value_iteration - compute policy using value iteration
% On input:
%     S (vector): states (1 to n)
%     A (vector): actions (1 to k)
%     P (nxk array): transition model
%     R (vector): state rewards
%     gamma (float): discount factor
%     eta (float): termination threshold
%     max_iter (int): max number of iterations
% On output:
%     U (vector): state utilities
%     U_trace (iterxn): trace of utility values during iteration
% Call:
% Chapter 17 Russell and Norvig (Table p. 651)
% [S,A,R,P,U,Ut] = CS4300_run_value_iteration(0.999999,1000)
%
% U’ =  0.7053 0.6553 0.6114 0.3879 0.7616 0 0.6600 -1.0000
%       0.8116 0.8678 0.9178 1.0000
%
%    Layout:               1
%                          ˆ
%     9 10 11 12           |
%     5  6  7  8       2 <- ->  4
%     1  2  3  4           |
%                          V
%                          3
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

% States
% the board is laid out 1..12
% treat these as states
% state utilities is similar to the board on page 651

% no input exists for board dimensions
% so we're stating them here as constants
ROWS = 3;
COLS = 4;

delta = 0;
U = zeros(length(S));
U_trace = U;
U_prime = U;

while delta < (eta * ((1 - gamma)/gamma))
    U = U_prime;
    delta = 0;
    for state = 1:length(S)
        max_a = 0;
        for a = 1:length(A)
            % Sum each state that can be reached
            probs = CS4300_get_state_probs(s,a,ROWS,COLS);
            % P(s_prime | s,a) * U(s_prime)
        end
        U_prime(state) = R(state) + gamma * max_a;
        
        delta = max(abs(U_prime(state) - U(state)),delta);
    end
    U_trace = [U_trace; U_prime];    
end