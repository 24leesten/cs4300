function [summation] = CS4300_summation(state_probs, U)
% CS4300_move - Create a summation of all the 
% On input:
%     stateprobs (vector): a list of the state probabilities (1 x n)
%     U (Vector): utilities (1 x n) 
% On output:
%     summation (float): the maximum summation
% Call:
%     state_probs = [0.1 0.1 0 0 0.8 0 0 0 0 0 0 0];
%     U = [0.705 0.655 0 0 0.762 0 0 0 0 0 0 0];
%     m = CS4300_summation(state_probs,U);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

summation = 0;

for i=1:length(state_probs)
    state_prob = state_probs(i)*U(i);
    summation = summation + state_prob ;
end