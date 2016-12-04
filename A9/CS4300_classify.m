function cls_images = CS4300_classify(g_weights, p_weights, w_weights, images)
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

GOLD   = 1;
PIT    = 2;
WUMPUS = 3;

[imx,imy] = size(images(1).im);
imSize = imx*imy;

cls_images = [];

%predict gold
for img = images
    x = reshape(img.im,imSize,1);
    
    prediction = threshold(dot(g_weights,x));
    if (prediction == 1)
        img.cls = GOLD;
        cls_images = [cls_images img];
    end
end

%predict gold
for img = images
    x = reshape(img.im,imSize,1);
    
    prediction = threshold(dot(g_weights,x));
    if prediction == 1
        img.cls = GOLD;
    end
end

%predict pit
for img = images
    x = reshape(img.im,imSize,1);
    
    prediction = threshold(dot(p_weights,x));
    if prediction == 1 && img.cls == -1
        img.cls = PIT;
        cls_images = [cls_images img];
    end
end

%predict wumpus
for img = images
    x = reshape(img.im,imSize,1);
    
    prediction = threshold(dot(w_weights,x));
    if prediction == 1 && img.cls == -1
        img.cls = WUMPUS;
        cls_images = [cls_images img];
    end
end

function val = threshold(number)
    val = number >= 0;