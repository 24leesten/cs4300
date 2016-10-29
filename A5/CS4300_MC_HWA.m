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
%     action = CS4300_MC_HWA([1 0 0 1 0]);
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
%      1: visited
% frontier
%     -1: unvisited
%      1: frontier
%      0: visited
% safe
%     -1: unknown
%      1: safe
persistent breezes;
persistent stench;
persistent visited;
persistent frontier;
persistent safe;
persistent state;
persistent plan;
persistent t;
persistent have_arrow;
persistent gold_grabbed;
persistent pits;
persistent wumps;

DEBUG = false;
DEBUG_FUNCTIONS = false;

TRIAL_COUNT = 50;

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
d = 0;
already_visited = 0;

if isempty(have_arrow)
    have_arrow = 1;
    gold_grabbed = 0;
end

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
    if visited(fix_y(y),x) == 1
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

% we sometimess need to update our boards
if ~already_visited || is_scream
    if is_scream
        %   - clear the stench board, the wumpus is dead.
        stench = zeros(4,4);
    end
    
    %update breezes
    breezes(fix_y(y),x) = is_breeze;
    %update stench
    stench(fix_y(y),x) = is_stench;
    %update visited
    visited(fix_y(y),x) = 1;
    %update frontier
    frontier = CS4300_update_frontier(visited);
    %update safe
    safe = CS4300_update_safe(visited, stench, breezes);
	
	% update the pit and wumpus probs
	if ~is_glitter
		[pits, wumps] = CS4300_WP_estimates(breezes, stench, TRIAL_COUNT);
	end
end

if (DEBUG)
    disp('BREEZE');
    disp(breezes);
    disp('STENCH');
    disp(stench);
    disp('VISITED');
    disp(visited);
    disp('FRONTIER');
    disp(frontier);
    pause;
end

if DEBUG_FUNCTIONS
    disp(loc);
    disp(frontier);
    disp(wumps + pits);
end
% Check for a Glitter
%   If we get a glitter grab the gold and plan a route out
if is_glitter && ~gold_grabbed
    % the plan is Grab, then Get to safety
    plan = CS4300_back_out(x,y,d, astar_safe_board(visited,1,1));
    plan = [GRAB; plan];
    gold_grabbed = true;
    if DEBUG_FUNCTIONS && ~isempty(plan)
        disp('found glitter. goin home!');
    end
end

% If we hear a scream:
if is_scream
    if DEBUG_FUNCTIONS
        disp('heard scream');
    end
    %   - check if the cell we are on has a stench
    %   - check if the plan is empty
    if stench(fix_y(y), x) == 1 && isempty(plan)
        % move foreward
        plan = [FORWARD];
    end
end
 
% If the plan is empty, check the frontier for an unvisited safe cell
%   If we find one then plan to go there
if isempty(plan)
    
    [sfy sfx] = find((safe+frontier)==2);
    spots = length(sfx);
    if spots > 0
        sfy = fix_y(sfy);
        if spots == 1
            % plan to go to sfx(1) sfy(1)
            go_x = sfx(1);
            go_y = sfy(1);
        else
            % plan to go to sfx(randi) sfy(randi)
            which = randi(spots);
            go_x = sfx(which);
            go_y = sfy(which);
        end
        plan_board = astar_safe_board(visited, go_x, go_y);
        plan = CS4300_plan_path([x y d], [go_x go_y 0], plan_board);
    end
    
    if DEBUG_FUNCTIONS && ~isempty(plan)
        disp('planned safe route');
    end
end

% If the plan is empty, do we still have an arrow
if have_arrow && isempty(plan)
    %   Search for the wumpus and shoot it if possible.
    plan = CS4300_plan_shot(CS4300_create_agent(loc), wumps, visited, safe, []);
    if DEBUG_FUNCTIONS && ~isempty(plan)
        disp('hunting a wumpus');
    end
end

% If the plan is empty take the move with the least risk
if isempty(plan)
    danger = pits + wumps;
    
    % if a board has 0 danger, we need to handle it
    if sum(danger(danger>0)) == 0
        disp('STILL HITTING THAT CORNER CASE, BOSS');
        disp('visited');
        disp(visited);
        disp('frontier');
        disp(frontier);
        disp('danger');
        disp(danger);
    end
    
    only_frontier = frontier == 1;
    for r = 1:4
        for c = 1:4
            danger(r,c) = danger(r,c) * only_frontier(r,c);
        end
    end
    
    % find the minimum danger location
    [min_y min_x] = find(danger == min(min(danger(danger>0))));
    
    % there might be more than one minimum.  Pick randomly.
    if length(min_x) > 1
        which = randi(length(min_x));
        min_x = min_x(which);
        min_y = min_y(which);
    end
    
    min_y = fix_y(min_y);
    % get a board which will provide a safe path to that location
    plan_board = astar_safe_board(visited, min_x, min_y);
    nextplan = CS4300_plan_path([x y d], [min_x min_y 0], plan_board);
    plan = nextplan;
    
    if DEBUG_FUNCTIONS && ~isempty(plan)
        disp('taking a risk');
    end
end

% return the action
if isempty(plan)
    disp ('OH MAN WE SHOULD HAVE A PLAN BY NOW!');
end

action = plan(1);
plan = plan(2:end);

% update the state based on the action
state = [state; CS4300_update_state(loc, action)];

if action==SHOOT
    if DEBUG_FUNCTIONS
        disp(sprintf('shot an arrow at %d %d %d', loc(1), loc(2), loc(3)));
    end
    have_arrow = 0;
end

if DEBUG_FUNCTIONS
    disp(sprintf('action: %d', action));
end

%{
    HELPER FUNCTIONS
%}

