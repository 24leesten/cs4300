function CS4300_a9_stats_driver
% CS4300_a9_stats_driver - drives a9 stats
% On input:
%     not_used (int): I don't actually use this
% On output:
%     no_output (int): Doesn't actually put out
% Call:
%     CS4300_a9_stats_driver;
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

IMG = 1;
EUL = 2;
AVG = 3;

FEATURE_TYPE = IMG;

trials = [1 2 4 8 16 32];
means = [];
std_d = [];
conf_i = [];
y_neg = [];
y_pos = [];
for trial=trials
    accuracy = CS4300_get_stats(FEATURE_TYPE, trial);
    means = [means mean(accuracy)];
    std_d = [std_d std(accuracy)];
    
    SEM = std(accuracy)/sqrt(length(accuracy));        % Standard Error
    ts = tinv([0.025  0.975],length(accuracy)-1);      % T-Score
    CI = mean(accuracy) + ts*SEM;                      % Confidence Intervals
    conf_i = [conf_i CI];
    y_neg = [y_neg mean(accuracy) - CI(1)];
    y_pos = [y_pos CI(2) - mean(accuracy)];
end

disp('trials');
disp(trials);
disp('mean');
disp(means);
disp('Standard Deviation');
disp(std_d);
disp('Confidence Interval');
disp(conf_i);

errorbar(trials,means,y_neg,y_pos,'o');
title('Perceptron Confidence Intervals');
ylabel('Mean');
xlabel('Trials');






function avg = CS4300_get_stats(FEATURE_TYPE, trials)

alpha = 0.1;
max_iter = 2;
rate = 1;

LABEL_G = 1;
LABEL_P = 2;
LABEL_W = 3;

[G, P, W] = CS4300_load_images(false);

avg = [];

for i=1:100

    [x,y] = getFeatures(LABEL_G, FEATURE_TYPE, G, P, W);
    [g_weights,hist] = CS4300_perceptron_learning(x,y,alpha,trials,rate);
    %printPretty('W',hist);

    [x,y] = getFeatures(LABEL_P, FEATURE_TYPE, G, P, W);
    [p_weights,hist] = CS4300_perceptron_learning(x,y,alpha,trials,rate);
    %printPretty('W',hist);

    [x,y] = getFeatures(LABEL_W, FEATURE_TYPE, G, P, W);
    [w_weights,hist] = CS4300_perceptron_learning(x,y,alpha,trials,rate);
    %printPretty('W',hist);

    success = CS4300_test_success(g_weights, p_weights, w_weights, G, P, W, FEATURE_TYPE);
    avg = [avg mean(success)];
    
end

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


