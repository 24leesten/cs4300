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

% set the label property for the images
for i=1:length(G)
    G(i).lbl = LABEL_G;
    P(i).lbl = LABEL_P;
    W(i).lbl = LABEL_W;
end

% concatenate, shuffle, and break the images into folds
all_imgs = [G P W];
shuffled = CS4300_fisher_yates(all_imgs);
k = 5;
all_folds = CS4300_get_k_folds(shuffled,k);

% run the k-fold validation
all_weights = [];
all_predictions = [];
for idx = 1:length(all_folds)
    % set aside the testing fold
    tester = all_folds(idx).fold;
    
    % concatenate the rest of the folds into a training set
    training = [];
    for jdx = 1:length(all_folds)
        if jdx == idx
            continue;
        end
        training = [training all_folds(jdx).fold];
    end
    
    % run the k fold on perceptron and test it
    weight = CS4300_perceptron(training, 0.1);
    prediction = CS4300_perceptron_prediction(tester,weight);

    all_weights(idx).w = weight;
    all_predictions(idx).p = prediction;
end

max = 0;
best_weight = [];
for i = 1:length(all_weights)
    if mean(all_predictions(i).p) > max 
        max = mean(all_predictions(i).p);
        best_weight = all_weights(i).w;
    end
end

disp 'RESULTS OF THE BEST WEIGHT VECTOR:';
disp(mean(CS4300_perceptron_prediction(shuffled, best_weight)));
