function [feature] = CS4300_feature_area(X)
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

feature = [];
[row col] = size(X); 
for i =1:row
   x = X(i,:);
   f = sum(sum(x == 1));
   feature = [feature; f];
end