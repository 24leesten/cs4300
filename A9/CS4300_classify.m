function cls_images = CS4300_classify(G,P,W,glab,plab,wlab,w,classification)
% CS4300_classify - algorithm for applying the weight vector
% On input:
%     G (struct vector): array of images
%       G(n).im = mxm matrix: the nth image
%     P (struct vector): array of images
%       P(n).im = mxm matrix: the nth image
%     W (struct vector): array of images
%       W(n).im = mxm matrix: the nth image
%     glab (int): {0,1} label for G images
%     plab (int): {0,1} label for P images
%     wlab (int): {0,1} label for W images
%     w (float vector): weight vector for predicting the image
%     classification(int): indicates PIT, GOLD, or WUMPUS
% On output:
%     cls_images (struct vector): array of images which were predicted to
%     match the classification input.
%       cls_images(n).im = mxm matrix: the nth image
% Call:
%     CS4300_classify(images,w,WUMPUS);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%


% set the label property for the images
for i=1:length(G)
    G(i).lbl = glab;
    P(i).lbl = plab;
    W(i).lbl = wlab;
end

% concatenate and shuffle images
all_imgs = [G P W];
images = CS4300_fisher_yates(all_imgs);

[imx,imy] = size(images(1).im);
imSize = imx*imy;

cls_images = [];

for img = images
    x = reshape(img.im,imSize,1);
    y = img.lbl;
    
    prediction = threshold(dot(w,x));
    % we want to return any correctly classified images
    % that were classified as positive
    if prediction == y && prediction > 0
        img.csl = classification;
        cls_images = [cls_images img];
    end
end


function val = threshold(number)
    val = number >= 0;
