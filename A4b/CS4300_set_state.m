function CS4300_set_state(val)
% CS4300_set_state - add a value to the state
% On input:
%     percept (1x3 Boolean array): percept values
%       (1): row 
%       (2): col 
%       (3): direction variable 
% Call:
%     val = CS4300_set_state([1 1 1]);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
global state
state = val;