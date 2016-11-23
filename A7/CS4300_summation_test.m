function CS4300_summation_test()
% CS4300_get_coords_test - runs 4 test scenarios on CS4300_summation based 
%     on the problems that were demonstrated in class.
% Call:
%     CS4300_get_coords_test;
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall

% Test 1
state_probs = [0.1 0.1 0 0 0.8 0 0 0 0 0 0 0];
U = [0.705 0.655 0 0 0.762 0 0 0 0 0 0 0];
m = CS4300_summation(state_probs,U);

if (m == 0.7456)
    display('TEST 1: PASSED')
else
    display('TEST 1: FAILED')
end


% Test 2
state_probs = [0.9 0 0 0 0.1 0 0 0 0 0 0 0];
U = [0.705 0.655 0 0 0.762 0 0 0 0 0 0 0];
m = CS4300_summation(state_probs,U);

if (m == 0.7107)
    display('TEST 2: PASSED')
else
    display('TEST 2: FAILED')
end

% Test 3
state_probs = [0.9 0.1 0 0 0 0 0 0 0 0 0 0];
U = [0.705 0.655 0 0 0.762 0 0 0 0 0 0 0];
m = CS4300_summation(state_probs,U);

if (m == 0.7)
    display('TEST 3: PASSED')
else
    display('TEST 3: FAILED')
end

% Test 4
state_probs = [0.1 0.8 0 0 0.1 0 0 0 0 0 0 0];
U = [0.705 0.655 0 0 0.762 0 0 0 0 0 0 0];
m = CS4300_summation(state_probs,U);

if (round(m,4) == 0.670700)
    display('TEST 4: PASSED')
else
    display('TEST 4: FAILED')
end

