function sentence = CS4300_MPS(percepts, x, y)
% CS3400_MPS - the make-percept-sentence function
% On input:
%     percept (1x5 Boolean array): percept values
%       (1): Stench variable (neighbors wumpus)
%       (2): Breeze variable (neighbors pit)
%       (3): Glitter variable (cell contains gold)
%       (4): Bump variable (hit wall trying to move)
%       (5): Scream variable (arrow killed wumpus)
%     x (int): agent's x position
%     y (int): agent's y position
% On output:
%     sentence (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
%     clause (CNF datastructure): a conjunct of disjunctive clauses to be tested
% Call: 
%     percept = [0,0,1,0,1];
%     sentence = CS3400_MPS(percept, 1);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

p = CS4300_parse_percept(percepts);
sentence = [];
counter = 1;


for inx = 1:length(p)
    switch(abs(p(inx)))
        % stench
        case 1
            sentence(counter).clauses = CS4300_pos_consts(x,y,p(inx));
        
        % breeze
        case 2 
            sentence(counter).clauses = CS4300_pos_consts(x,y,p(inx));
           
        % glitter
        case 3 
            sentence(counter).clauses = CS4300_pos_consts(x,y,p(inx));
            
        % bump
        case 4 
            continue;
        
        % screamed
        case 5
            % 5000 means the wumpus is dead
            if p(inx) > 0
                sentence(counter).clauses = 5000;
            end
    end
    counter = counter + 1;
end

        


