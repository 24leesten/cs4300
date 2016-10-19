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

persistent state;
persistent kb;

if ~state
    state = [1 1 0];
end

kb = CS4300_INIT_KB();
t = 0;
plan = [];

% tell the kb about the current percepts.
kb = TELL(kb, CS4300_MPS(percepts, t));
% something about the temporal physics?

% add this x,y to the safe list

% if ASK(glitter) is true
    % the plan is Grab, then Get to safety

% if we don't have a plan yet
    % plan to go to a (all?) location that is both unvisited and safe
   
% if we still don't have a plan, 
% but we have an arrow...
    % ASK if there might be a wumpus nearby
    % if so, plan to shoot it!

% if we still have no plan, nothing to do but go forward
    % ASK for a tile that isn't totally unsafe
    % plan to go there

% if we still have no plan
    % plan to leave.  We just have to exit empty-handed.

    
% ACTION = pop plan

% TELL kb MAKE ACTION SENTENCE (why?  I think we're going to skip this)
% t = t++
% return action

