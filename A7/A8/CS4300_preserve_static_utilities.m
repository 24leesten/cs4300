function UPrime = CS4300_preserve_static_utilities(U)
% CS4300_preserve_static_utilities- Sets certain values in U to hard-coded
% constants.
% On input:
%     U (Vector): utilities (1 x n) 
% On output:
%     UPrime (Vector): utilities (1 x n) 
% Call:
%     U = [0.705 0.655 0 0 0.762 0 0 0 0 0 0 0];
%     Up = CS4300_preserve_static_utilities(U);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

UPrime = U;

WUMPUS = false;

if WUMPUS
    UPrime(16) = 1;  % gold
    UPrime(7) = -1;  % pit
    UPrime(11) = -1; % wumpus
    UPrime(12) = -1; % pit
else
    UPrime(6) = 0;
    UPrime(8) = -1;
    UPrime(12) = 1;
end
