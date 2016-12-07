function CS4300_a9_driver_asside
% CS4300_a9_driver - drives a9 asside
% On input:
%     not_used (int): I don't actually use this
% On output:
%     no_output (int): Doesn't actually put out
% Call:
%     CS4300_a9_driver_asside;
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
folds = 5;

[G, P, W] = CS4300_load_images;

%%%%%%%%%%%%%%
% Classify G %
%%%%%%%%%%%%%%
LABEL_G = 1;
LABEL_P = 0;
LABEL_W = 0;

[gold_weights, predictions] = CS4300_run_k_folds(G,P,W,LABEL_G,LABEL_P,LABEL_W,folds);

gold_weight = get_best_weight(gold_weights, predictions);


%%%%%%%%%%%%%%
% Classify P %
%%%%%%%%%%%%%%
LABEL_G = 0;
LABEL_P = 1;
LABEL_W = 0;

[pit_weights, predictions] = CS4300_run_k_folds(G,P,W,LABEL_G,LABEL_P,LABEL_W,folds);

pit_weight = get_best_weight(pit_weights, predictions);


%%%%%%%%%%%%%%
% Classify W %
%%%%%%%%%%%%%%
LABEL_G = 0;
LABEL_P = 0;
LABEL_W = 1;

[wumpus_weights, predictions] = CS4300_run_k_folds(G,P,W,LABEL_G,LABEL_P,LABEL_W,folds);

wumpus_weight = get_best_weight(wumpus_weights, predictions);

% Use wieghts for classification

% wumpus
cls_imgs = CS4300_classify(gold_weight, pit_weight, wumpus_weight, [G P W]);

disp('All images classified together.')
disp(mean(CS4300_classification_succes(cls_imgs)));





function best_weight = get_best_weight(weights, predictions)

max = 0;
best_weight = [];
for i = 1:length(weights)
    if mean(predictions(i).p) > max 
        max = mean(predictions(i).p);
        best_weight = weights(i).w;
    end
end
