function CS4300_get_state_probs_test
% CS4300_get_state_probs_test - runs a test scenario on CS4300_get_state_probs_test
%   test a variety of states and actions to assert that the returned
%   probability vector is valid
% Call:
%     CS4300_get_state_probs_test;
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall

COLS = 3;
ROWS = 3;
S = [1:9];

NORTH = 1;
WEST  = 2;
SOUTH = 3;
EAST  = 4;

total_failures = 0;

% ///////////////////////////////////////////////////////////////////////////
% problem 1: base case: 1,1 NORTH
state = 1;
action = NORTH;

probs = CS4300_get_state_probs(state, action, S, ROWS, COLS);
expected_result = [0.1 0.1 0 0.8 0 0 0 0 0];

if ~all(probs==expected_result)
    disp 'TEST 1 FAILED';
    disp 'Expected';
    disp (expected_result);
    disp 'Actual';
    disp (probs);
    total_failures = total_failures + 1;
end

% ///////////////////////////////////////////////////////////////////////////
% problem 2: middle of board case
state = 5;
action = NORTH;

probs = CS4300_get_state_probs(state, action, S, ROWS, COLS);
expected_result = [0 0 0 .1 0 .1 0 .8 0];

if ~all(probs==expected_result)
    disp 'TEST 2 FAILED';
    disp 'Expected';
    disp (expected_result);
    disp 'Actual';
    disp (probs);
    total_failures = total_failures + 1;
end

action = WEST;

probs = CS4300_get_state_probs(state, action, S, ROWS, COLS);
expected_result = [0 .1 0 .8 0 0 0 .1 0];

if ~all(probs==expected_result)
    disp 'TEST 3 FAILED';
    disp 'Expected';
    disp (expected_result);
    disp 'Actual';
    disp (probs);
    total_failures = total_failures + 1;
end

action = SOUTH;

probs = CS4300_get_state_probs(state, action, S, ROWS, COLS);
expected_result = [0 .8 0 .1 0 .1 0 0 0];

if ~all(probs==expected_result)
    disp 'TEST 4 FAILED';
    disp 'Expected';
    disp (expected_result);
    disp 'Actual';
    disp (probs);
    total_failures = total_failures + 1;
end

action = EAST;

probs = CS4300_get_state_probs(state, action, S, ROWS, COLS);
expected_result = [0 .1 0 0 0 .8 0 .1 0];

if ~all(probs==expected_result)
    disp 'TEST 5 FAILED';
    disp 'Expected';
    disp (expected_result);
    disp 'Actual';
    disp (probs);
    total_failures = total_failures + 1;
end

% ///////////////////////////////////////////////////////////////////////////
% problem 3: hitting walls
state = 8;
action = NORTH;

probs = CS4300_get_state_probs(state, action, S, ROWS, COLS);
expected_result = [0 0 0 0 0 0 .1 .8 .1];

if ~all(probs==expected_result)
    disp 'TEST 6 FAILED';
    disp 'Expected';
    disp (expected_result);
    disp 'Actual';
    disp (probs);
    total_failures = total_failures + 1;
end

state = 4;
action = WEST;

probs = CS4300_get_state_probs(state, action, S, ROWS, COLS);
expected_result = [.1 0 0 .8 0 0 .1 0 0];

if ~all(probs==expected_result)
    disp 'TEST 7 FAILED';
    disp 'Expected';
    disp (expected_result);
    disp 'Actual';
    disp (probs);
    total_failures = total_failures + 1;
end

state = 2;
action = SOUTH;

probs = CS4300_get_state_probs(state, action, S, ROWS, COLS);
expected_result = [.1 .8 .1 0 0 0 0 0 0];

if ~all(probs==expected_result)
    disp 'TEST 8 FAILED';
    disp 'Expected';
    disp (expected_result);
    disp 'Actual';
    disp (probs);
    total_failures = total_failures + 1;
end

state = 6;
action = EAST;

probs = CS4300_get_state_probs(state, action, S, ROWS, COLS);
expected_result = [0 0 .1 0 0 .8 0 0 .1];

if ~all(probs==expected_result)
    disp 'TEST 9 FAILED';
    disp 'Expected';
    disp (expected_result);
    disp 'Actual';
    disp (probs);
    total_failures = total_failures + 1;
end

% ///////////////////////////////////////////////////////////////////////////
% end:
if ~total_failures
    disp 'All Tests Passed Successfully!';
end

