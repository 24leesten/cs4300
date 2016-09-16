function D = CS4300_rand_D_matrix(prob, l)
% CS4300_rand_D_matrix - produces a square matrix of random 1's and 0's
% On input:
%   prob (float): [0-1] probability of each coordinate producing a '1'
%   l (int): the dimension of the lenxlen matrix to return
% On output:
%     D (lxl matrix): a matrix of randomly populated 1's and 0's 
% Call:
%     D = CS4300_rand_D_matrix('CS4300_AC1');
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

% invariant: prob must be within [0..1]
if prob < 0 || prob > 1
    D = [];
    return;
end

% create a random board
randos = rand(l);

% create a board of zeroes
floored = zeros(l,l);

% add a 1 to the zeros board if the random matches the probability
for y = 1:l
    for x = 1:l
        floored(y,x) = randos(y,x) >= (1 - prob);
    end
end

D = floored;