function CS4300_a9_driver_asside
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

GOLD   = 1;
PIT    = 2;
WUMPUS = 3;

[G, P, W] = CS4300_load_images;

%%%%%%%%%%%%%%
% Classify G %
%%%%%%%%%%%%%%
LABEL_G = 1;
LABEL_P = 0;
LABEL_W = 0;

for i=1:length(G)
    G(i).lbl = LABEL_G;
    P(i).lbl = LABEL_P;
    W(i).lbl = LABEL_W;
end

all_imgs = [G P W];

shuffled = CS4300_fisher_yates(all_imgs);

gold_weight = CS4300_perceptron(shuffled, 0.1);

%disp(gold_weight);



%%%%%%%%%%%%%%
% Classify P %
%%%%%%%%%%%%%%
LABEL_G = 0;
LABEL_P = 1;
LABEL_W = 0;

for i=1:length(G)
    G(i).lbl = LABEL_G;
    P(i).lbl = LABEL_P;
    W(i).lbl = LABEL_W;
end

all_imgs = [G P W];

shuffled = CS4300_fisher_yates(all_imgs);

pit_weight = CS4300_perceptron(shuffled, 0.1);

%disp(pit_weight);

%%%%%%%%%%%%%%
% Classify W %
%%%%%%%%%%%%%%
LABEL_G = 0;
LABEL_P = 0;
LABEL_W = 1;

for i=1:length(G)
    G(i).lbl = LABEL_G;
    P(i).lbl = LABEL_P;
    W(i).lbl = LABEL_W;
end

all_imgs = [G P W];

shuffled = CS4300_fisher_yates(all_imgs);

wumpus_weight = CS4300_perceptron(shuffled, 0.1);

%disp(wumpus_weight);

all_imgs = [G P W];
shuffled = CS4300_fisher_yates(all_imgs);

all_imgs = CS4300_classify(shuffled,gold_weight, GOLD);
all_imgs = CS4300_classify(shuffled,weight, PIT);
all_imgs = CS4300_classify(shuffled,weight, WUMPUS);

success = CS4300_perceptron_prediction(all_imgs);
