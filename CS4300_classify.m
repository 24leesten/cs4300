function classification = CS4300_classify(images,w,state)
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
%     CS4300_classify;
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

[imx,imy] = size(images(1).im);
imSize = imx*imy;

for img = images
    x = reshape(img.im,imSize,1);
    y = img.lbl;
    
    prediction = threshold(dot(w,x));
    if prediction == y
        img.lbl = state;
    end
    
end

classification = images;


function val = threshold(number)
    val = number >= 0;