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
% S = [1:12];
% A = [1:4];
% P = CS4300_get_P_matrix(S,A);
% R = [-0.04 -0.04 -0.04 -0.04 -0.04 -0.04 -0.04 -1 -0.04 -0.04 -0.04 1];
% g = 0.9999;
% e = 0.1;
% m = 100000000;
% [U,Ut] = CS4300_MDP_value_iteration(S,A,P,R,g,e,m);
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

U = zeros(1,length(S));
U = CS4300_preserve_static_utilities(U);
U_trace = U;
U_prime = U;

% do until delta < some stuff (see below)
while true
    U = U_prime;
    delta = 0;
    for state = 1:length(S)
        max_a = 0;
        
        for a = 1:length(A)
            % summation performs: SUM[ P(s_prime | s,a) * U(s_prime) ]
            sum = CS4300_summation(P(state,a).probabilities, U);
            if sum > max_a
                max_a = sum;
            end
        end
        
        % update u-prime for the given state
        U_prime(state) = R(state) + gamma * max_a;
        
        % preserve the non-changing locations of u_prime
        U_prime = CS4300_preserve_static_utilities(U_prime);
        
        % delta = |uprime(s) - u(s)| or delta, whichever is larger
        delta = max( abs(U_prime(state) - U(state)), delta);
        
    end
    U_trace = [U_trace; U_prime];
    
    if delta < (eta * ((1 - gamma)/gamma))
        break;
    end
end