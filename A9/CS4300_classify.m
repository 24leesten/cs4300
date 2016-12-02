function cls_images = CS4300_classify(images,w,classification)
% CS4300_classify - algorithm for applying the weight vector
% On input:
%     images (struct vector): array of images
%       images(n).im = mxm matrix: the nth image
%       images(n).lbl = the lable of the nth image
%     w (float vector): weight vector for predicting the image
% On output:
%     success (int vector): prediction results
%       1 = successful prediction
%       0 = unsuccessful prediction
% Call:
%     CS4300_classify(images,w,WUMPUS);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%


for img = images
    img
    x = reshape(img.im,imSize,1);
    y = img.lbl;
    prediction = threshold(dot(w,x));
    if prediction == y
        img.cls = classification
    end
end