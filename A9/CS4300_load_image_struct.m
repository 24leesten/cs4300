function [g_imgs, p_imgs, w_imgs] = CS4300_load_image_struct
% CS4300_load_images - loads images and returns them as an array of arrays.
% On input:
% On output:
%     g_imgs (kxm matrix): contains k image vectors of m length
%     p_imgs (kxm matrix): contains k image vectors of m length
%     w_imgs (kxm matrix): contains k image vectors of m length
% Call:
%     [g_images, p_images, w_images] = CS4300_load_image_struct;
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

w = load('images/W.mat');
w = w.W;
p = load('images/P.mat');
p = p.P;
g = load('images/G.mat');
g = g.G;

g_imgs = [];
p_imgs = [];
w_imgs = [];

for i = 1:length(w)
    disp(w(i).im);
    
    g_imgs = [g_imgs; g(i).im];
    p_imgs = [p_imgs; p(i).im];
    w_imgs = [w_imgs; w(i).im];
end
    