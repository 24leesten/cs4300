function plan = CS4300_can_shoot_wumpus(x,y,d,visited,kb)
% CS3400_can_shoot_wumpus - returns the plan to shoot a wumpus if we are
% certain we can kill it
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
%     plan (1xn int array): plan to shoot wumpus from this location
% Call:
%     board = ones(4,4);
%     KB = [];
%     KB(1).clauses = [1];
%     plan = CS4300_can_shoot_wumpus(1,1,0,board,KB);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
STENCH = 1;
LEFT = 3;
SHOOT = 5;

possible_wump_board = zeros(4,4);
thm = [];
stenches = [];

% mark all locations of stench.
for y = 1:4
    for x = 1:4
        thm(1).clauses = CS4300_pos_consts(x,y,STENCH);
        if CS4300_ASK(kb, thm)
            possible_wump_board(4-y+1,x) = 1;
            stenches = [stenches; [x y]];
        end
    end
end

% not enough information
if length(stenches) <= 2
    plan = [];
    return;
end

wumpx = -1;
wumpy = -1;

% we know exactly where the wumpus is
if length(stenches) > 2
    for a = 1:length(stenches)
        
        if wumpx > 0
            break;
        end
        
        xa = stenches(a,1);
        ya = stenches(a,2);
        
        for b = a:length(stenches)
            
            if wumpx > 0
                break;
            end
            
            xb = stenches(b,1);
            yb = stenches(b,2);
            if xa == xb
                wumpx = xa;
                wumpy = (ya + yb) / 2;
                
            end
            if ya == yb
                wumpy = ya;
                wumpx = (xa + xb) / 2;
            end

        end
    end
end

% get facing position if we're aligned with the wumpus.
if wumpx == x
    plan = [SHOOT];
    
    if (y - wumpy) > 0
        % face north and fire
        while ~(d == 1)
            next = CS4300_update_state([x y d], LEFT);
            d = next(3);
            plan = [LEFT; plan];
        end
        return;
        
    else
        % face south and fire
        while ~(d == 3)
            next = CS4300_update_state([x y d], LEFT);
            d = next(3);
            plan = [LEFT; plan];
        end
        return;
    end
end

if wump == y
    plan = [SHOOT];
    
    if (x - wumpx) < 0
        % face east and fire
        while ~(d == 2)
            next = CS4300_update_state([x y d], LEFT);
            d = next(3);
            plan = [LEFT; plan];
        end
        return;
        
    else
        % face west and fire
        while ~(d == 0)
            next = CS4300_update_state([x y d], LEFT);
            d = next(3);
            plan = [LEFT; plan];
        end
        return;
    end
end