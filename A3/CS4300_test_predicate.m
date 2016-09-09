function consistent = CS4300_test_predicate(i,a,j,b,D)
% CS4300_test_predicate - a basic predicate testing for equivalence between
%                         the provided values.
% On input:
%    i (int): start node index
%    a (int): start node domain value
%    j (int): end node index
%    b (int): end node domain value
%    D (nxm array): m domain values for each of n nodes
% On output:
%     consistent (Boolean): true if consistent, false otherwise
% Call:
%     is_consistent = CS4300_test_predicate(1,1,2,2,D);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

consistent = true;

if 0
    disp 'a';
    disp (a);
    disp 'i';
    disp (i);
    disp 'b';
    disp (b);
    disp 'j';
    disp (j);
end

if D(a,i) == D(b,j)
   consistent = false;
end
