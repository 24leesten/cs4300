function [x, y] = CS4300_euler_format(G,P,W,which)
% CS4300_format_data: turns images into data, label datasets with bweuler
% On input:
%     g_imgs (struct vector): contains n images
%       g_imgs(n).im = the nth image
%     p_imgs (struct vector): contains n images
%       p_imgs(n).im = the nth image
%     w_imgs (struct vector): contains n images
%       w_imgs(n).im = the nth image
%     which (int): {1,2,3} which image set should be labeled 1
% On output:
%     x (kxm vector): image data vectors
%     y (1xm vector): image data labels
% Call:
%     [G,P,W] = CS4300_load_images;
%     which = 1;
%     [X,y] = CS4300_euler_format(G,P,W,which);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

[imx,imy] = size(G(1).im);
imSize = imx*imy;

x = [];
y = [];

for g = G
    img = g.im;
    eul = bweuler(img,4);
    x = [x; eul];
    if which == 1
        y = [y; 1];
    else
        y = [y; 0];
    end
end

for p = P
    img = p.im;
    eul = bweuler(img,4);
    x = [x; eul];
    if which == 2
        y = [y; 1];
    else
        y = [y; 0];
    end
end

for w = W
    img = w.im;
    eul = bweuler(img,4);
    x = [x; eul];
    if which == 3
        y = [y; 1];
    else
        y = [y; 0];
    end
end