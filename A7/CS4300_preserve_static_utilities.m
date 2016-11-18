function UPrime = CS4300_preserve_static_utilities(U)
% CS4300_preserve_static_utilities- Sets certain values in U to hard-coded
% constants.
% On input:
%     U (Vector): utilities (1 x n) 
% On output:
%     UPrime (Vector): utilities (1 x n) 
% Call:
%     U = [0.705 0.655 0 0 0.762 0 0 0 0 0 0 0];
%     Up = CS4300_preserve_static_utilities(state_probs,U);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

UPrime = U;

UPrime(12) = 1;
UPrime(8) = -1;
UPrime(6) = 0;