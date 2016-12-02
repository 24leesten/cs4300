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

LABEL_G = 0;
LABEL_P = 0;
LABEL_W = 1;

[G, P, W] = CS4300_load_images;

for i=1:length(G)
    G(i).lbl = LABEL_G;
    P(i).lbl = LABEL_P;
    W(i).lbl = LABEL_W;
end

all_imgs = [G P W];

shuffled = CS4300_fisher_yates(all_imgs);

weight = CS4300_perceptron(shuffled, 0.1);

disp(weight);

success = CS4300_perceptron_prediction(all_imgs,weight);

disp(mean(success));