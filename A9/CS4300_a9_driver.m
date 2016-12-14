function CS4300_a9_driver
% CS4300_a9_driver - drives a9
% On input:
%     not_used (int): I don't actually use this
% On output:
%     no_output (int): Doesn't actually put out
% Call:
%     CS4300_a9_driver;
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

alpha = 0.1;
max_iter = 100000;
rate = 1;

LABEL_G = 1;
LABEL_P = 2;
LABEL_W = 3;

IMG = 1;
EUL = 2;
AVG = 3;

FEATURE_TYPE = IMG;
x = [];
y = [];

[G, P, W] = CS4300_load_images(false);


[x,y] = getFeatures(LABEL_G, FEATURE_TYPE, G, P, W);
[w,hist] = CS4300_perceptron_learning(x,y,alpha,max_iter,rate);
printPretty('G',hist);

[x,y] = getFeatures(LABEL_P, FEATURE_TYPE, G, P, W);
[w,hist] = CS4300_perceptron_learning(x,y,alpha,max_iter,rate);
printPretty('P',hist);

[x,y] = getFeatures(LABEL_W, FEATURE_TYPE, G, P, W);
[w,hist] = CS4300_perceptron_learning(x,y,alpha,max_iter,rate);
printPretty('W',hist);

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

function printPretty (title, hist)
disp(title);
[h,w] = size(hist);
for idx = 1:h
    disp(hist(idx,1));
end

