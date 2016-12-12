function success = CS4300_test_succes(g_weights, p_weights, w_weights, G, P, W, feature)
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

success = [];

[x,y] = getFeatures(GOLD, feature, G, P, W);

%predict gold
for i=1:length(y)
    xi = x(i,:);
    xi = [1 xi];
    yi = y(i);
    length(xi);
    length(g_weights);
    
    prediction = threshold(dot(g_weights,xi));
    if yi == 1
        if prediction == 1
            success = [success 1];
        else
            success = [success 0];
        end
    end
end

[x,y] = getFeatures(PIT, feature, G, P, W);

%predict pit
for i=1:length(y)
    xi = x(i,:);
    xi = [1 xi];
    yi = y(i);
    length(xi);
    length(p_weights);
    
    prediction = threshold(dot(p_weights,xi));
    if yi == 1
        if prediction == 1
            success = [success 1];
        else
            success = [success 0];
        end
    end
end

[x,y] = getFeatures(WUMPUS, feature, G, P, W);

%predict wumpus
for i=1:length(y)
    xi = x(i,:);
    xi = [1 xi];
    yi = y(i);
    length(xi);
    length(w_weights);
    
    prediction = threshold(dot(w_weights,xi));
    if yi == 1
        if prediction == 1
            success = [success 1];
        else
            success = [success 0];
        end
    end
end

function val = threshold(number)
    val = number >= 0;
    
function [x,y] = getFeatures(label, feature, G, P, W)
IMG = 1;
EUL = 2;
if feature == IMG
    [x,y] = CS4300_format_data(G,P,W,label);
elseif feature == EUL
    [x,y] = CS4300_euler_format(G,P,W,label);
else
    [x,y] = CS4300_format_sections(G,P,W,label);
end