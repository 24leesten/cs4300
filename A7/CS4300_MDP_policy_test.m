function CS4300_MDP_policy_test()
% CS4300_get_coords_test - runs a test scenario on CS4300_MDP_policy based
%     on the books scenarios
% Call:
%     CS4300_get_coords_test;
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall

% MAKE SURE THAT WUMPUS IS SET TO FALSE FOR CS4300_get_P_matrix and
% CS4300_preserve_static_utilitis

S = [1:12];
A = [1:4];
P = CS4300_get_P_matrix(S,A,false);
m = 10000000;
g = 0.99999;
e = 0.01;

% ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
%   test 1  -0.04
% vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
R = ones(1,12);
R = R * -0.04;
R(8) = -1;
R(12) = 1;
R(6) = 0;
[U,Ut] = CS4300_MDP_value_iteration(S,A,P,R,g,e,m);
policy = CS4300_MDP_policy(S,A,P,U);

m1 = [1 2 2 2 1 1 1 1 4 4 4 1];
if policy == m1
  display('==== TEST 1 ====')
  display('PASSED')
else
  display('==== TEST 1 ====')
  display('FAILED')
  CS4300_print_matrix(U, 3, 4);
  disp('wanted');
  CS4300_print_matrix(m1, 3, 4);
  disp('found');
  CS4300_print_matrix(policy, 3, 4);
end


% ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
%   test 2  -0.4278 < R(s) < -0.085
% vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
R = ones(1,12);
R = R * -0.1;
R(8) = -1;
R(12) = 1;
[U,Ut] = CS4300_MDP_value_iteration(S,A,P,R,g,e,m);
policy = CS4300_MDP_policy(S,A,P,U);

m2 = [1 4 1 2 1 1 1 1 4 4 4 1];
if policy == m2
  display('==== TEST 2 ====')
  display('PASSED')
else
  display('==== TEST 2 ====')
  display('FAILED')
  CS4300_print_matrix(U, 3, 4);
  disp('wanted');
  CS4300_print_matrix(m2, 3, 4);
  disp('found');
  CS4300_print_matrix(policy, 3, 4);
end


% ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
%   test 3  -0.0221 < R(s) < 0
% vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
R = ones(1,12);
R = R * -0.02;
R(8) = -1;
R(12) = 1;
R(6) = 0;
[U,Ut] = CS4300_MDP_value_iteration(S,A,P,R,g,e,m);
policy = CS4300_MDP_policy(S,A,P,U);

m3 = [1 2 2 3 1 1 2 2 4 4 4 1];
if policy == m3
  display('==== TEST 3 ====')
  display('PASSED')
else
  display('==== TEST 3 ====')
  display('FAILED')
  CS4300_print_matrix(U, 3, 4);
  disp('wanted');
  CS4300_print_matrix(m3, 3, 4);
  disp('found');
  CS4300_print_matrix(policy, 3, 4);
end

% ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
%   test 4  -1.6284 < R(s)
% vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
R = ones(1,12);
R = R * -7;
R(8) = -1;
R(12) = 1;
R(6) = 0;
[U,Ut] = CS4300_MDP_value_iteration(S,A,P,R,g,e,m);
policy = CS4300_MDP_policy(S,A,P,U);

m4 = [4 4 4 1 1 4 4 1 4 4 4 4];
if policy == m4
  display('==== TEST 4 ====')
  display('PASSED')
else
  display('==== TEST 4 ====')
  display('FAILED')
  CS4300_print_matrix(U, 3, 4);
  disp('wanted');
  CS4300_print_matrix(m4, 3, 4);
  disp('found');
  CS4300_print_matrix(policy, 3, 4);
end

