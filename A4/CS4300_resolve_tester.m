function CS4300_resolve_tester()
% resovle_tester - harnes for testing CS4300_RESOLVE
% On input:
%   N/A
% On output:
%   0
% Call:  
%     CS4300_resolve_tester();
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

failcount = 0;

a = [1 2 3 4]
b = -4
answer = [1 2 3];

result = CS4300_RESOLVE(a,b);

if all(result(1).clauses == answer)
    disp 'test 1 passes';
else
    disp 'test 1 fails';
    failcount = failcount + 1;
end


a = [1 2 3 4]
b = [-4 -2]
answer = [];
answer(1).clauses = [1 3 4 -4];
answer(2).clauses = [1 2 3 -2];

result = CS4300_RESOLVE(a,b);

if ((answer(1).clauses == result(1).clauses) & (answer(2).clauses == result(2).clauses))
    disp 'test 2 passes';
else
    disp 'test 2 fails';
    failcount = failcount + 1;
end


a = [1 2 3 4]
b = [-1 -2 -3 -4]
answer = [];
answer(1).clauses = [2 3 4 -2 -3 -4];

result = CS4300_RESOLVE(a,b);

if all(answer(1).clauses == result(1).clauses)
    disp 'test 3 passes';
else
    disp 'test 3 fails';
    failcount = failcount + 1;
end



a = [1]
b = [-1 -2 -3 -4]
answer = [];
answer(1).clauses = [-2 -3 -4];

result = CS4300_RESOLVE(a,b);

if all(answer(1).clauses == result(1).clauses)
    disp 'test 4 passes';
else
    disp 'test 4 fails';
    failcount = failcount + 1;
end


a = [5]
b = [-1 -2 -3 -4]
answer = [];

result = CS4300_RESOLVE(a,b);

if all(answer == result)
    disp 'test 5 passes';
else
    disp 'test 5 fails';
    failcount = failcount + 1;
end


a = []
b = []
answer = [];

result = CS4300_RESOLVE(a,b);

if all(answer == result)
    disp 'test 6 passes';
else
    disp 'test 6 fails';
    failcount = failcount + 1;
end



a = [-1]
b = [1]
answer = [];
answer(1).clauses = zeros(1,0);

result = CS4300_RESOLVE(a,b);

if all(answer(1).clauses == result(1).clauses)
    disp 'test 7 passes';
else
    disp 'test 7 fails';
    failcount = failcount + 1;
end



a = [1]
b = [1]
answer = [];

result = CS4300_RESOLVE(a,b);

if all(answer == result)
    disp 'test 8 passes';
else
    disp 'test 8 fails';
    failcount = failcount + 1;
end



disp 'total failures: ';
disp (failcount);






