function plan = CS4300_get_surrounding(x,y,d,visited,KB)
% CS3400_get_surrounding - returns the adjacent locations which are visitab
% le, unvisited, and not deadly
% On input:
%     x (int): x position of the wumpus board
%     y (int): y position of the wumpus board
%     d (int): d facing direction of the agent
%     visted (4x4 int matrix): visited locations on the board
%         0: visited
%         1: unvisited
%     KB (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
% On output:
%     plan (1xn int array): best plan from this location
% Call:
%     board = ones(4,4);
%     KB = [];
%     KB(1).clauses = [1];
%     plan = CS4300_get_surrounding(1,1,0,board,KB);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

plan = [];

% constants
FORWARD = 1;
RIGHT = 2;
LEFT = 3;
WUMPUS = 6;
PIT = 7;

% try moving forward
skip = 0;
th1 = [];
th2 = [];

next = CS4300_update_state([x y d], FORWARD);
nx = next(1);
ny = next(2);
if nx == x && ny == y
    % bumped a wall
    skip = 1;
elseif visited(4-ny+1, nx) == 0
    % already been there
    skip = 1; 
end

th1(1).clauses = CS4300_pos_consts(nx,ny,WUMPUS);
th2(1).clauses = CS4300_pos_consts(nx,ny,-WUMPUS);
if ~skip && (CS4300_ASK(KB, th1) || ~CS4300_ASK(KB, th2))
    % it's deadly
    skip = 1;
end

th1(1).clauses = CS4300_pos_consts(nx,ny,PIT);
th2(1).clauses = CS4300_pos_consts(nx,ny,-PIT);
if ~skip && (CS4300_ASK(KB, th1) || ~CS4300_ASK(KB, th2))
    % it's deadly
    skip = 1;
end

if ~skip
    plan = [FORWARD];
    return;
end


% try turning LEFT then moving forward
skip = 0;
th1 = [];
th2 = [];

next = CS4300_update_state([x y d], LEFT);
next = CS4300_update_state(next, FORWARD);
nx = next(1);
ny = next(2);
if nx == x && ny == y
    % bumped a wall
    skip = 1;
elseif visited(4-ny+1, nx) == 0
    % already been there
    skip = 1; 
end

th1(1).clauses = CS4300_pos_consts(nx,ny,WUMPUS);
th2(1).clauses = CS4300_pos_consts(nx,ny,-WUMPUS);
if ~skip && (CS4300_ASK(KB, th1) || ~CS4300_ASK(KB, th2))
    % it's deadly
    skip = 1;
end

th1(1).clauses = CS4300_pos_consts(nx,ny,PIT);
th2(1).clauses = CS4300_pos_consts(nx,ny,-PIT);
if ~skip && (CS4300_ASK(KB, th1) || ~CS4300_ASK(KB, th2))
    % it's deadly
    skip = 1;
end

if ~skip
    plan = [LEFT; FORWARD];
    return;
end


% try turning RIGHT then moving forward
skip = 0;
th1 = [];
th2 = [];

next = CS4300_update_state([x y d], RIGHT);
next = CS4300_update_state(next, FORWARD);
nx = next(1);
ny = next(2);
if nx == x && ny == y
    % bumped a wall
    skip = 1;
elseif visited(4-ny+1, nx) == 0
    % already been there
    skip = 1; 
end

th1(1).clauses = CS4300_pos_consts(nx,ny,WUMPUS);
th2(1).clauses = CS4300_pos_consts(nx,ny,-WUMPUS);
if ~skip && (CS4300_ASK(KB, th1) || ~CS4300_ASK(KB, th2))
    % it's deadly
    skip = 1;
end

th1(1).clauses = CS4300_pos_consts(nx,ny,PIT);
th2(1).clauses = CS4300_pos_consts(nx,ny,-PIT);
if ~skip && (CS4300_ASK(KB, th1) || ~CS4300_ASK(KB, th2))
    % it's deadly
    skip = 1;
end

if ~skip
    plan = [RIGHT; FORWARD];
    return;
end

