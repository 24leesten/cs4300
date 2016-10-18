function kb = CS4300_INIT_KB()
% CS3400_INIT_KB - creates the initial knowledge base for any board
% On input:
%     nothing
% On output:
%     sentence (CNF data structure): array of conjuctive clauses
%       (i).clauses
%           each clause is a list of integers (- for negated literal)
%     clause (CNF datastructure): a conjunct of disjunctive clauses to be tested
% Call: 
%     kb = CS3400_INIT_KB();
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

kb = [];

% init breeze and stench
for y = 1:3
    for x = 1:3
        for p = 1:2
            sentences = CS4300_kb_init(x,y,p);
            kb = CS4300_cnf_union(kb, sentences);
        end
    end
end

% init wumpi
wumps = zeros(1,16);
counter = 1;
for y = 1:4
    for x = 1:4
        wumps(counter) = CS4300_pos_consts(x,y,6);
        counter = counter + 1;
    end
end

% commenting this out for now, pending further input from the professor
%{
counter = length(kb) + 1;
kb(counter).clauses = wumps;
counter = counter + 1;

for q = 1:4
    for p = 1:4
        for y = q:4
            for x = p:4
                if p == x && q == y
                    continue;
                end
                left = CS4300_pos_consts(p,q,-6);
                right = CS4300_pos_consts(x,y,-6);
                kb(counter).clauses = [left right];
                counter = counter + 1;
            end
        end
    end
end
%}