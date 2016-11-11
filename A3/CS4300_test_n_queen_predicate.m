function CS4300_test_n_queen_predicate()
% CS4300_test_n_queen_predicate - a function that allows us to visually
%     inspecct the n_queems predicate
% Call
%     CS4300_test_predicate(1,2,D);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
disp('PREDICATE TEST')
for a = 1:4
    for i = 1:4
        for b = 1:4
            for j = 1:4
                if (a ~= b)
                    i_a_j_b = [i a j b]
                    supports = CS4300_n_queens_predicate(i,a,j,b)
                end
            end
        end
    end
end