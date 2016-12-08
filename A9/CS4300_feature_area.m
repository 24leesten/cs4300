function [x,y] = CS4300_feature_area(G,P,W,which)
% CS4300_feature_area: creates a new feature out of a set of datasets
% On input:
%     X (MxN vector): training data
% On output:
%     feature (Mx1 vector):  
% Call:
%     f = [[1 0 1];[1 1 0]];
%     f = CS4300_format_data();
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
%{
feature = [];
[row col] = size(X); 
for i =1:row
   x = X(i,:);
   f = sum(sum(x == 1));
   feature = [feature; f];
end
%}

[imx,imy] = size(G(1).im);
imSize = imx*imy;

x = [];
y = [];

for g = G
    img = g.im;
    total = sum(sum(img));
    avg = total / imSize;
    bimg = img > 150;
    area = sum(sum(bimg == 1));
    eimg = (img ~= 255 & img ~= 0);
    mid = sum(sum(eimg == 1));
    x = [x; avg area mid];
    if which == 1
        y = [y; 1];
    else
        y = [y; 0];
    end
end

for p = P
    img = p.im;
    total = sum(sum(img));
    avg = total / imSize;
    bimg = img > 150;
    area = sum(sum(bimg == 1));
    eimg = (img ~= 255 & img ~= 0);
    mid = sum(sum(eimg == 1));
    x = [x; avg area mid];
    if which == 2
        y = [y; 1];
    else
        y = [y; 0];
    end
end

for w = W
    img = w.im;
    total = sum(sum(img));
    avg = total / imSize;
    bimg = img > 150;
    area = sum(sum(bimg == 1));
    eimg = (img ~= 255 & img ~= 0);
    mid = sum(sum(eimg == 1));
    x = [x; avg area mid];
    if which == 3
        y = [y; 1];
    else
        y = [y; 0];
    end
end

function val=count_arr(arr,find)
val = arr == find;
val = sum(sum(val))