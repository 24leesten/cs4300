function [zx, zy] = CS4300_projectile_sensor(x,y,C,sigma2)
% CS4300_fall_sensor - observes falling object
% On input:
%     x (float): acutal distance of object
%     y (float): actual height of object
%     C (float): sensor process model
%     sigma2 (float): variance of Gaussian noise for sensor
% On output:
%     zx (float): sensed distance of object
%     zy (float): sensed height of object
% Call:
%     [zx,zy] = CS4300_fall_sensor(x,y,1,0.1);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

zx = C*x + sqrt(sigma2)*randn;
zy = C*y + sqrt(sigma2)*randn;