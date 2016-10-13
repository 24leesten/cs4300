function [x y d] = CS4300_get_state_at(t)
% CS4300_get_state_at - add a value to the state
% On input:
%   t (int): a statement of time
% On output:
%     percept (1x3 Boolean array): position values
%       (1): row 
%       (2): col 
%       (3): direction variable 
% Call:
%     [x y d] = CS4300_get_state_at(1);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
global state
x = state(t,1);
y = state(t,2);
d = state(t,3);