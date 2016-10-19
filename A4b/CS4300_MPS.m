function sentences = CS4300_MPS(percepts, t)
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
[x y d] = CS4300_get_state_at(t);
sentences = [];

for inx = 1:length(p)
    % add the current statement and get surrounding literals
    surroundings = CS4300_get_surrounding(x, y, p(inx));
    surroundings = surroundings(~surroundings == 0);
    
    % add the appropriate clauses
    s = [];
    switch(abs(p(inx)))
        % stench
        case 1     
            sentences(length(sentences)+1).clauses = CS4300_pos_consts(x, y, p(inx));
            if p(inx) > 0
                s(1).clauses = surroundings;
            else
                s = CS4300_NEG_THM(-surroundings);
            end
        
        % breeze
        case 2 
            sentences(length(sentences)+1).clauses = CS4300_pos_consts(x, y, p(inx));
            if p(inx) > 0
                s(1).clauses = surroundings;
            else
                s = CS4300_NEG_THM(-surroundings);
            end
           
        % glitter
        case 3 
            sentences(length(sentences)+1).clauses = CS4300_pos_consts(x, y, p(inx));
            if(p(inx) > 0)
                s(1).clauses = CS4300_pos_consts(x, y, 8);
            else 
                s(1).clauses = CS4300_pos_consts(x, y, -8);
            end
            
        % bump
        case 4 
            continue;
        
        % screamed
        case 5
            if p(inx) > 0 
                % set all wumpi to false
                wumps = zeros(1,16);
                wc = 1;
                for y = 1:4
                    for x = 1:4
                        wumps(wc) = CS4300_pos_consts(x,y,-6);
                        wc = wc + 1;
                    end
                end
                s = CS4300_NEG_THM(-wumps);
            end
        
    end
    
    sentences = CS4300_cnf_union(s, sentences);
end

        


