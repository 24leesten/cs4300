function kb = CS4300_GET_CNF(x, y, p)
% CS3400_GET_CNF - gets all sentences associated with the inputs
% On input:
%     x (int): x position on the wumpus board
%     y (int): y position on the wumpus board
%     p (int): percept const for that location
%         0: Nothing
%         1: Stench
%         2: Breeze
%         3: Glitter
%         4: Bump
%         5: Scream
%         6: Wumpus
%         7: Pit
%         8: Gold
% On output:
%     kb (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
%     clause (CNF datastructure): a conjunct of disjunctive clauses to be tested
% Call: 
%     kb = CS3400_GET_CNF();
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

kb = [];
counter = 1;

here = CS4300_GET_CONST(x,y,p);

% stench or breeze
if p < 3
    north = 0;
    south = 0;
    east = 0;
    west = 0;

    p_ind = p + 5;

    % retrieve const values for locations 
    if x < 4
        north = CS4300_GET_CONST(x,(y+1),p_ind);
    end
    if x > 1
        south = CS4300_GET_CONST(x,(y-1),p_ind);
    end
    if y < 4
        east = CS4300_GET_CONST((x+1),y,p_ind);
    end
    if y > 1
        west = CS4300_GET_CONST((x-1),y,p_ind);
    end

    % create the clauses
    if east
        kb(counter).clauses = [here -east];
        counter = counter + 1;
    end
    if north
        kb(counter).clauses = [here -north];
        counter = counter + 1;
    end
    if west
        kb(counter).clauses = [here -west];
        counter = counter + 1;
    end
    if south
        kb(counter).clauses = [here -south];
        counter = counter + 1;
    end

    sent = [-here];
    if east
        sent = [sent east];
    end
    if north
        sent = [sent north];
    end
    if west
        sent = [sent west];
    end
    if south
        sent = [sent south];
    end

    kb(counter).clauses = sent;
end
    
% if glitter