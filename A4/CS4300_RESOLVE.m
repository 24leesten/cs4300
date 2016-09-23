function resolved = CS4300_RESOLVE(Ci,Cj)
% CS4300_RESOLVE - resolution theorem prover
% On input:
%     Ci (1xn vector): a clause
%     Cj (1xn vector): a clause
% On output:
%     resolved (1xn vector): a clause
% Call:  (example from Russell & Norvig, p. 252)
%     Ci = [-1,2,3,4];
%     Cj = [-2];
%     Sr = CS4300_RESOLVE(Ci, Cj);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

resolved = [];

% resolve ci, cj
for k = 1:length(Ci)
    conflict = 0;
    for l = 1:length(Cj)
        if Ci(k) + Cj(l) == 0
            conflict = 1;
            break;
        end
    end
    
    if ~conflict
        resolved = [resolved Ci(k)];
    end
end

for l = 1:length(Cj)
    conflict = 0;
    for k = 1:length(Ci)
        if Ci(k) + Cj(l) == 0
            conflict = 1;
            break;
        end
    end
    
    if ~conflict && ~ismember(Cj(l),resolved)
        resolved = [resolved Cj(l)];
    end
end
