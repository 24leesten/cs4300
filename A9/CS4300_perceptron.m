function w = CS4300_perceptron(images,alpha)
% CS4300_perceptron - perceptron algorithm
% On input:
%     images (struct vector): array of images
%       images(n).im = mxm matrix: the nth image
%       images(n).lbl = the lable of the nth image
%     r (float): rate
% On output:
%     w (float vector): the perceptron linear separator
% Call:
%     CS4300_perceptron;
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

[imx,imy] = size(images(1).im);
imSize = imx*imy;

% start w0 = a vector of all zeros
w = zeros(imSize,1);

for img = images    
    % reshape the image matrix into a single vector
    x = reshape(img.im,imSize,1);
    y = img.lbl;
    
    y_prime = threshold(dot(w,x));
    if y ~= y_prime
      w = w + alpha*(y-y_prime)*x;
    end
end

function val = threshold(number)
    val = number >= 0;
