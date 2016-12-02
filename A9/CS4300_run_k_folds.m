function [weights,predictions] = CS4300_run_k_folds(G,P,W,glab,plab,wlab,k)
% CS4300_run_k_folds - runs the arrays across k fold validation
% On input:
%     G (struct vector): array of images
%       G(n).im = mxm matrix: the nth image
%     P (struct vector): array of images
%       P(n).im = mxm matrix: the nth image
%     W (struct vector): array of images
%       W(n).im = mxm matrix: the nth image
%     glab (int): {0,1} label for G images
%     plab (int): {0,1} label for P images
%     wlab (int): {0,1} label for W images
%     k (int): number of folds
% On output:
%     weights (struct vector): array containing weight arays
%       folds.fold (vector): a partition of the original array
% Call:
%     [G, P, W] = CS4300_load_images;
%     [w,p] = CS4300_run_k_folds(G,P,W,1,0,0,5);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

% set the label property for the images
for i=1:length(G)
    G(i).lbl = glab;
    P(i).lbl = plab;
    W(i).lbl = wlab;
end

% concatenate, shuffle, and break the images into folds
all_imgs = [G P W];
shuffled = CS4300_fisher_yates(all_imgs);
k = 5;
all_folds = CS4300_get_k_folds(shuffled,k);

% run the k-fold validation
weights = [];
predictions = [];
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

    weights(idx).w = weight;
    predictions(idx).p = prediction;
end

max = 0;
best_weight = [];
for i = 1:length(weights)
    if mean(predictions(i).p) > max 
        max = mean(predictions(i).p);
        best_weight = weights(i).w;
    end
end

disp 'RESULTS OF THE BEST WEIGHT VECTOR:';
disp(mean(CS4300_perceptron_prediction(shuffled, best_weight)));