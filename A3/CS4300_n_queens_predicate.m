function support = CS4300_n_queens_predicate(i,a,j,b)
% CS4300_n_queens_predicate - a predicate to help find determine the
%       solvabiliy of a board in the n-quens proble.
% On input:
%     i (int): start node index
%     a (int): start node domain value
%     j (int): end node index
%     b (int): end node domain value
% On output:
%     support (boolean): a supports b
% Call:
%     deleted = CS4300_n_queens_predicate(1,2,1,2);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

support = true;
if(i == j)
    support = false;
end
if(abs(a-b)/abs(i-j) == 1)
    support = false;
end

