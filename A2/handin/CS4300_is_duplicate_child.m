function is_duplicate  = CS4300_is_duplicate_child(state,nodes)
% CS4300_is_duplicate_child - returns true if nodes contains the child
% On input:
%     state (1x3 vector): x,y,dir state
%     no = 1x9 struct array with fields:
%       parent
%       level
%       state
%       action
%       cost
%       g
%       h
%       children
% On output:
%     is_duplicate (boolean): true if nodes contains the provided state
% Call:
%   dup = CS4300_is_duplicate_child([1,1,1], [node]);
%
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

is_duplicate = false;

for node = nodes
    if node.state == state
        is_duplicate = true;
        break;
    end
end
