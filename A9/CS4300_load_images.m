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

GOLD   = 1;
PIT    = 2;
WUMPUS = 3

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
                g_imgs(length(g_imgs)+1).im = img;
                g_imgs(length(g_imgs)+1).cls = -1;
                g_imgs(length(g_imgs)+1).val = GOLD;
            case 'p'
                p_imgs(length(p_imgs)+1).im = img;
                p_imgs(length(p_imgs)+1).cls = -1;
                p_imgs(length(p_imgs)+1).val = PIT;
            case 'w'
                w_imgs(length(w_imgs)+1).im = img;
                w_imgs(length(w_imgs)+1).cls = -1;
                w_imgs(length(w_imgs)+1).val = WUMPUS;
        end
    end
end