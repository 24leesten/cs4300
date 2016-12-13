function success = CS4300_perceptron_test(w,X,y)
% CS4300_perceptron_test - algorithm for applying the weight vector
% On input:
%     w (float vector): weight vector for predicting the image
%     X (nxm array): n independent variable samples each of length m
%     y (nx1 vector): dependent variable samples
% On output:
%     success (int vector): prediction results
%       1 = successful prediction
%       0 = unsuccessful prediction
% Call:
%     w = [0,0,0];
%     X = [[1,0,1];[0,1,0]];
%     y = [0,1];
%     successes = CS4300_perceptron_test(w,X,y);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

DEBUG = false;

success = [];

for i = 1:length(y)
    yi = y(i);
    xi = X(i,:);
    xi = [1 xi];
    
    prediction = threshold(dot(w,xi));
    
    if DEBUG
        disp(sprintf('yi: %d prediction: %d', yi, prediction));
    end
    success = [success; (prediction == yi)];
end


function val = threshold(number)
    val = number >= 0;