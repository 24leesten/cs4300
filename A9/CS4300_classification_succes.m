function success = CS4300_classification_succes(images)
% CS4300_perceptron_prediction - algorithm for applying the weight vector
% On input:
%     images (struct vector): array of images
%       images(n).im = mxm matrix: the nth image
%       images(n).lbl = the lable of the nth image
%     w (float vector): weight vector for predicting the image
%     state: the state we are predicting
% On output:
%     success (int vector): prediction results
%       1 = successful prediction
%       0 = unsuccessful prediction
% Call:
%     CS4300_perceptron_prediction;
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

success = [];

for img = images
    if img.cls == img.val
        success = [success; (prediction == y)];
    end
end
