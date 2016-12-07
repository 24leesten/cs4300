function success = CS4300_classification_succes(images)
% CS4300_perceptron_prediction - algorithm for checking the succes of the
%     predictions
% On input:
%     images (struct vector): array of images
%       images(n).im = mxm matrix: the nth image
%       images(n).lbl = the lable of the nth image
%       images(n).cls = -1 if unclassified else 1, 2, or 3
%       images(n).val = the actual val of the image 1, 2, 0r 3
% On output:
%     success (float): 0..1 indicating success
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
    success = [success; (img.cls == img.val)];
end
