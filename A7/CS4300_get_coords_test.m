function CS4300_get_coords_test
% CS4300_get_coords_test - runs a test scenario on CS4300_get_coords.
% Given a board with 5 rows and 10 columns, it should accurately find each
% x,y coordinate (based on wumpus world x,y) for states 1..50
% Call:
%     CS4300_get_coords_test;
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall

test_board = zeros;
for state = 1:50
    [r,c] = CS4300_get_coords(state,5,10);
    test_board((6-r),c)=state;
end
if(test_board(6-1,1) == 1)
    disp('TEST 1: PASSED')
end
if(test_board(6-5,1) == 41)
    disp('TEST 2: PASSED')
end
if(test_board(6-1,10) == 10)
    disp('TEST 3: PASSED')
end
if(test_board(6-5,10) == 50)
    disp('TEST 4: PASSED')
end