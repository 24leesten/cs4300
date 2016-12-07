function [w, per_cor] = CS4300_perceptron_learning(X, y, alpha, max_iter, rate)
% CS4300_perceptron_learning - find linear separating hyperplane
% On input:
%     X (nxm array): n independent variable samples each of length m
%     y (nx1 vector): dependent variable samples
%     alpha (float): learning rate
%     max_iter (int): max number of iterations
%     rate (Boolean): if 1 then alpha = 1000/(1000+iter), else
%       constant
% On output:
%     w (m+1x1 vector): weights for linear function
%     per_cor (kxm+1 array): trace of percentage correct with weight
% Call:
%     [w,pc] = CS4300_perceptron_learning(X,y,0.1,10000,0);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
bias = 0;

[row, col] = size(X);
w = zeros(1,col);

% Add in bias
w = [bias w];
per_cor = [];

correct = 0;
iters = 0;

while correct ~= 1.0
    if rate == 1
        alpha = 1000/(1000+iters);
    end
    
    iters = iters + 1;
    
    % get a random row from the sample
    index = randi(row);

    % set our example and label
    xi = X(index,:);
    yi = y(index);
    xi = [bias xi];
    
    % test the example prediction
    y_prime = threshold(dot(w,xi));
    if yi ~= y_prime
      w = w + alpha*(yi-y_prime)*xi;
    end

    % test the wieght vector against the whole set
    success = CS4300_perceptron_test(w,X,y);
    
    % record our current success rate
    correct = mean(success);
    insert = [correct, w];
    
    per_cor = [per_cor; insert];
    
    % check for maximum iterations
    if iters == max_iter
        break;
    end
end



function val = threshold(number)
    val = number >= 0;