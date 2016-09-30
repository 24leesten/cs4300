function CS4300_rtp_tester()
% rtp_tester - harnes for testing CS4300_RTP
% On input:
%   N/A
% On output:
%   0
% Call:  
%     CS4300_rtp_tester();
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

failcount = 0;
vars = [];

KB = [];
KB(1).clauses = 1;
thm = 1;
answer = [];

result = CS4300_RTP(KB,thm,vars);

if all(result == answer)
    disp 'test 1 passes';
else
    disp 'test 1 fails';
    failcount = failcount + 1;
end

KB = [];
KB(1).clauses = 1;
thm = -1;
answer = 1;

result = CS4300_RTP(KB,thm,vars);

if ~isempty(result)
    disp 'test 2 passes';
else
    disp 'test 2 fails';
    failcount = failcount + 1;
end

KB = [];
KB(1).clauses = [-1 2 3 4];
KB(2).clauses = [-2];
KB(3).clauses = [-3];
KB(4).clauses = [1];
thm = 4;
answer = [];

result = CS4300_RTP(KB,thm,vars);

if all(result == answer)
    disp 'test 3 passes';
else
    disp 'test 3 fails';
    failcount = failcount + 1;
end

KB = [];
KB(1).clauses = [-1 2 3 4];
KB(2).clauses = [-2];
KB(3).clauses = [-3];
KB(4).clauses = [1];
thm = -4;
answer = [];

result = CS4300_RTP(KB,thm,vars);

if ~isempty(result)
    disp 'test 4 passes';
else
    disp 'test 4 fails';
    failcount = failcount + 1;
end

KB = [];
KB(1).clauses = [-1 2 3 4];
KB(2).clauses = [-2];
KB(3).clauses = [-3];
KB(4).clauses = [1];
thm = [2 -4];
answer = [];

result = CS4300_RTP(KB,thm,vars);

if ~isempty(result)
    disp 'test 5 passes';
else
    disp 'test 5 fails';
    failcount = failcount + 1;
end

KB = [];
KB(1).clauses = [-1 2 3 4];
KB(2).clauses = [-2];
KB(3).clauses = [-3];
KB(4).clauses = [1];
thm = [-2 4];
answer = [];

result = CS4300_RTP(KB,thm,vars);

if all(result == answer)
    disp 'test 6 passes';
else
    disp 'test 6 fails';
    failcount = failcount + 1;
end

KB = [];
KB(1).clauses = [-1 2 3 4];
KB(2).clauses = [-2];
KB(3).clauses = [-3];
KB(4).clauses = [1];
thm = [4 5];
answer = [];

result = CS4300_RTP(KB,thm,vars);

if all(result == answer)
    disp 'test 7 passes';
else
    disp 'test 7 fails';
    failcount = failcount + 1;
end

KB = [];
KB(1).clauses = [1];
KB(2).clauses = [2];
KB(3).clauses = [3];
KB(4).clauses = [4];
KB(5).clauses = [5];
KB(6).clauses = [6];
KB(7).clauses = [7];
KB(8).clauses = [8];
KB(9).clauses = [9];
KB(10).clauses = [10];
KB(11).clauses = [11];
KB(12).clauses = [12];
thm = [13];
answer = [];

result = CS4300_RTP(KB,thm,vars);

if ~isempty(result)
    disp 'test 8 passes';
else
    disp 'test 8 fails';
    failcount = failcount + 1;
end

KB = [];
KB(1).clauses = [1 2 3 4 5 6];
thm = [1 2 3 4 5 6];
answer = [];

result = CS4300_RTP(KB,thm,vars);

if all(answer == result)
    disp 'test 9 passes';
else
    disp 'test 9 fails';
    failcount = failcount + 1;
end


KB = [];
KB(1).clauses = [-1 -2 -3 -4 -5 6];
KB(2).clauses = [1];
KB(3).clauses = [2];
KB(4).clauses = [3];
KB(5).clauses = [4];
KB(6).clauses = [5];
thm = [6];
answer = [];

result = CS4300_RTP(KB,thm,vars);

if all(answer == result)
    disp 'test 10 passes';
else
    disp 'test 10 fails';
    failcount = failcount + 1;
end

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp 'total failures: ';
disp (failcount);
