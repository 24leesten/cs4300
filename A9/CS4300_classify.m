function cls_images = CS4300_classify(g_weights, p_weights, w_weights, images)
% CS4300_classify - make predictions based on the wieghts calculated for
%     each image type
% On input:
%     g_weights (float vector): gold weights
%     p_weights (float vector): pit eights
%     w_weights (float vector): wumpus weights
%     images (struct vector): array of images
%       images(n).im = mxm matrix: the nth image
%       images(n).lbl = the lable of the nth image
%       images(n).cls = -1 if unclassified else 1, 2, or 3
%       images(n).val = the actual val of the image 1, 2, 0r 3
% On output:
%     cls_images (struct vector): array of images which were predicted to
% Call:
%     CS4300_classify(g_weights, p_weights, w_weights, images);
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