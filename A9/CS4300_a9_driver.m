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

LABEL_G = 1;
LABEL_P = 0;
LABEL_W = 0;

[G, P, W] = CS4300_load_images;

K = 5;

[weights, predictions] = CS4300_run_k_folds(G,P,W,LABEL_G,LABEL_P,LABEL_W,5);
