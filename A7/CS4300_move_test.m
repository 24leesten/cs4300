function CS4300_move_test
% CS4300_move_test - test harness for CS4300_move.  Runs 100,000 trials on
% CS4300_move.  Expects roughly 80% forward movement.  10% left movement.
% 10% right movement.
% Call:
%     CS4300_move_test;
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

Dir = 1;
X = 2;
Y = 2;

up = 0;
left = 0;
right = 0;
down = 0;

trials = 100000;

for trial = 1:trials
    [xp,yp] = CS4300_move(Dir,X,Y);
    if yp == 3
        up = up + 1;
    elseif xp == 1
        left = left + 1;
    elseif xp == 3
        right = right + 1;
    else
        down = down + 1;
    end
end

up = round((up/trials)*10)*10;
left = round((left/trials)*10)*10;
right = round((right/trials)*10)*10;
down = round((down/trials)*10)*10;

disp(sprintf('Up: %d\nLeft: %d\nRight: %d\nDown: %d', up, left, right, down));