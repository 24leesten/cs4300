function sentence = CS4300_MPS(percepts, t)
% CS3400_MPS - the make-percept-sentence function
% On input:
%     percept (1x5 Boolean array): percept values
%       (1): Stench variable (neighbors wumpus)
%       (2): Breeze variable (neighbors pit)
%       (3): Glitter variable (cell contains gold)
%       (4): Bump variable (hit wall trying to move)
%       (5): Scream variable (arrow killed wumpus)
%     time (int): current time
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
state = CS4300_get_state();
count = 1;

for inx = 1:length(p)
    sentence(count).clauses = CS4300_pos_consts(state(1), state(2), p(inx));
    count = count + 1;
    surroundings = CS4300_get_surrounding(state(1), state(2), p(inx));
    surroundings = surroundings(~surroundings == 0);
    switch(abs(p(inx)))
        case 1 % stench
            s = CS4300_NEG_THM(-surroundings);      
        case 2 % breeze
            s = CS4300_NEG_THM(-surroundings); 
        case 3 % glitter
            if(p(inx) > 0)
                sentence(count).clauses = CS4300_pos_consts(state(1), state(2), 8);
            else 
                sentence(count).clauses = CS4300_pos_consts(state(1), state(2), -8);
            end
        case 4
        case 5
    end
            
end

        


