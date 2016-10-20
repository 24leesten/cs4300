function action = CS4300_HWA(percepts)
% CS4300_HWA - the hybrid wumpus agent ai algorithm
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
% action = CS4300_HWA([1 0 0 1 0]);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

% some constant declarations
STENCH = 1;
BREEZE = 2;
GLITTER = 3;
BUMP = 4;
SCREAM = 5;
WUMPUS = 6;
PIT = 7;
GOLD = 8;
GOLD_GRABBED = 3000;
ARROW_FIRED = 4000;
WUMPUS_KILLED = 5000;

FORWARD = 1;
RIGHT = 2;
LEFT = 3;
GRAB = 4;
SHOOT = 5;
CLIMB = 6;

persistent state;
persistent kb;
persistent safe;
persistent t;
persistent plan;

loc = [];
x = 0;
y = 0;
already_visited = 0;

% initialize the persistent variables on the first call.
if length(t) == 0
    t = 1;
else
    t = t + 1;
end

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
    if safe(4-y+1,x) == 0
        already_visited = 1;
    end
end

if length(safe) == 0
    safe = ones(4,4);
    safe(4,1) = 0;
else
    % add this location to the safe list
    safe(4-y+1,x) = 0;
end

if length(kb) == 0
    kb = CS4300_INIT_KB();
end

if ~already_visited
    % tell the kb about the current percepts.
    kb = CS4300_TELL(kb, CS4300_MPS(percepts, x, y));

    % we can guarantee the current location does not have a pit or wumpus
    thisvisit = [];
    thisvisit(1).clauses = CS4300_pos_consts(x,y,-WUMPUS);
    thisvisit(2).clauses = CS4300_pos_consts(x,y,-PIT);
    kb = CS4300_cnf_union(kb, thisvisit);
end
theorem = [];

% grab the gold and run!
theorem(1).clauses = [CS4300_pos_consts(x,y,GLITTER)];
if isempty(plan) && CS4300_ASK(kb, theorem)
    % the plan is Grab, then Get to safety
    plan = CS4300_back_out(x,y,d,safe);
    plan = [GRAB; plan];
end

% things to change:
% 1. We're already keeping track of visited, that's good.
% 2. We need to discover what might be safe
%   a. iterate over all unvisited board areas.
%   b. if we can prove no wumpus and no pit, it's safe.  make methods for
%   that
%   c. if not, we mark it as uncertain.
%   d. it's possible to have 2 uncertains.  safeish (no nearby
%   breeze/stench) and not safeish(nearby breeze/stench).
% 3. then we plan a trip with trip planner to one of those locations.
if isempty(plan)
    % build our danger board
    danger = CS4300_make_danger_board(safe, kb);
    % plan to go to a location that is both unvisited and not deadly
    plan = CS4300_prob_safe_path(x,y,d,danger,safe);
end
    
% just need a better way to do this, I think
theorem(1).clauses = [ARROW_FIRED];
if isempty(plan) && ~CS4300_ASK(kb, theorem);
    % ASK if there might be a wumpus nearby
    % if so, plan to shoot it!
    plan = CS4300_can_shoot_wumpus(x,y,d,safe,kb);
    
    % if we have a plan, we're going to shoot the arrow.
    if ~isempty(plan)
        fired = [];
        fired(1).clauses = ARROW_FIRED;
        kb = CS4300_cnf_union(kb, fired);
    end
end


% things to change:
% 1. back in touch with our revised current board
% 2. head to one of the unvisited, not safeish areas.
if isempty(plan)
    % go for a tile that isn't totally unsafe
    plan = CS4300_hail_mary(x,y,d,danger,safe);
end

% things to change:
% this is now a guarantee that we have no other possible options.
if isempty(plan)
    % back up one room and try again
    plan = CS4300_back_out(x,y,d,safe);
end

action = plan(1);
plan = plan(2:end);


% update the state based on the action
state = [state; CS4300_update_state(loc, action)];


