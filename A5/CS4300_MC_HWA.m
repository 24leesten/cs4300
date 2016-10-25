function action = CS4300_MC_HWA(percepts)
% CS4300_MC_HWA - the hybrid wumpus agent ai algorithm
% On input:
%     percept (1x5 Boolean array): percept values
%       (1): Stench variable (neighbors wumpus)
%       (2): Breeze variable (neighbors pit)
%       (3): Glitter variable (cell contains gold)
%       (4): Bump variable (hit wall trying to move)
%       (5): Scream variable (arrow killed wumpus)
% On output:
%     action (int): the next action to take
% Call:
% action = CS4300_MC_HWA([1 0 0 1 0]);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

% PERSISTENTS
% breezes, stench, visited, frontier (4x4 array) meanings
% breezes & stench
%     -1: unknown
%      1: true
%      0: false
% visited
%     -1: unvisited
%      0: visited
% frontier
%     -1: unvisited
%      1: frontier
%      0: visited
% safe
%     -1: unknown
%      0: safe
persistent breezes;
persistent stench;
persistent visited;
persistent frontier;
persistent safe;
persistent state;
persistent plan;
persistent t;

DEBUG = false;

%ACTIONS
FORWARD = 1;
RIGHT = 2;
LEFT = 3;
GRAB = 4;
SHOOT = 5;
CLIMB = 6;

% PARSE PERCEPTS
is_stench  = percepts(1);
is_breeze  = percepts(2);
is_glitter = percepts(3);
is_scream  = percepts(5);

% LOCALS
loc = [];
x = 0;
y = 0;
already_visited = 0;

% Initialize the persistent variables on the first call.
% t
if length(t) == 0
    t = 1;
else
    t = t + 1;
end

% state
if length(state) == 0
    state = [1 1 0];
    loc = [1 1 0];
    x = 1;
    y = 1;
    d = 0;
else
    % find this location
    loc = state(t,:);
    x = loc(1);
    y = loc(2);
    d = loc(3);
    if safe(fix_y(y),x) == 0
        already_visited = 1;
    end
end

% breezes
if isempty(breezes)
    breezes = -ones(4,4);   
end

% stench
if isempty(stench)
    stench = -ones(4,4);
end

% visited
if isempty(visited)
    visited = -ones(4,4);
end

% frontier
if isempty(frontier)
    frontier = -ones(4,4);
end

% frontier
if isempty(safe)
    safe = -ones(4,4);
end

% we need to update our boards
if ~already_visited
    %update breezes
    breezes(fix_y(y),x) = is_breeze;
    %update stench
    stench(fix_y(y),x) = is_stench;
    %update visited
    visited(fix_y(y),x) = 0;
    %update frontier
    frontier = CS4300_update_frontier(visited);
    %update safe
    safe = CS4300_update_safe(visited, stench, breezes);
end

if (DEBUG)
    disp(breezes);
    disp(stench);
    disp(visited);
    disp(frontier);
end

% Check for a Glitter
%   If we get a glitter grab the gold and plan a route out
if is_glitter
    % the plan is Grab, then Get to safety
    plan = CS4300_back_out(x,y,d,-visited);
    plan = [GRAB; plan];
end

% If we hear a scream:
if is_scream
    %   - check if the cell we are on has a stench
    %   - check if the plan is empty
    if stench(fix_y(y), x) == 1 && isempty(plan)
        % move foreward
        plan = [FOREWARD];
    end
    %   - clear the stench board the wumpus is dead.
    stench = zeroes(4,4);
end
 
% If the plan is empty, check the frontier for an unvisited safe cell
%   If we find one then plan to go there
if  isempty(plan)
    
end

% If the plan is empty, do we still have an arrow
%   Search for the wumpus
%     plan a route to shoot the wumpus.

% If the plan is empty take the move with the least risk

% return the action
action = plan(1);
plan = plan(2:end);

% update the state based on the action
state = [state; CS4300_update_state(loc, action)];

%{
    HELPER FUNCTIONS
%}

% fix the y value to operate with the matrix
function y = fix_y(y)
y = 4-y+1;
