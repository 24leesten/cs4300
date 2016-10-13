function val = CS4300_get_state()
% CS4300_get_state - add a value to the state
% On output:
%     percept (nx3 Boolean array): position values
%       (1): row 
%       (2): col 
%       (3): direction variable 
% Call:
%     val = CS4300_get_state();
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
global state
val = state;