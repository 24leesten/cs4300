function [g_imgs, p_imgs, w_imgs] = CS4300_load_images
% CS4300_load_images - loads images and returns them as an array of arrays.
% On input:
% On output:
%     g_imgs (struct vector): contains n images
%       g_imgs(n).im = the nth image
%     p_imgs (struct vector): contains n images
%       p_imgs(n).im = the nth image
%     w_imgs (struct vector): contains n images
%       w_imgs(n).im = the nth image
% Call:
%     [g_images, p_images, w_images] = CS4300_load_images;
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

UNCLASSIFIED = -1;
GOLD   = 1;
PIT    = 2;
WUMPUS = 3;

g_imgs = [];
p_imgs = [];
w_imgs = [];

for letter = ['g','p','w']
    for num = 1:9
        img_raw = imread(strcat('images/',num2str(letter),num2str(num),'.jpg'));
        img_binary = img_raw > 150;
        img = imresize(img_binary,[15,15]);
        switch (letter)
            case 'g'
                index = length(g_imgs)+1;
                g_imgs(index).im  = img;
                g_imgs(index).cls = UNCLASSIFIED;
                g_imgs(index).val = GOLD;
            case 'p'
                index = length(p_imgs)+1;
                p_imgs(index).im  = img;
                p_imgs(index).cls = UNCLASSIFIED;
                p_imgs(index).val = PIT;
            case 'w'
                index = length(w_imgs)+1;
                w_imgs(index).im  = img;
                w_imgs(index).cls = UNCLASSIFIED;
                w_imgs(index).val = WUMPUS;
        end
    end
end