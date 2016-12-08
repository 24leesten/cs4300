function CS4300_a9_driver_1
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

[G, P, W] = CS4300_load_images;

[x,y] = CS4300_format_data(G,P,W,LABEL_G);
[w,hist] = CS4300_perceptron_learning(x,y,alpha,max_iter,rate);

[h,w] = size(hist);
for idx = 1:h
    disp(hist(idx,1));
end

%{
[x,y] = CS4300_format_data(G,P,W,LABEL_P);
[w,hist] = CS4300_perceptron_learning(x,y,alpha,max_iter,rate);


[x,y] = CS4300_format_data(G,P,W,LABEL_W);
[w,hist] = CS4300_perceptron_learning(x,y,alpha,max_iter,rate);
%}
