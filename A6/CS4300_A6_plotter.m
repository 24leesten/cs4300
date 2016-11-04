function CS4300_A6_plotter(x,a,z)
% CS4300_A5_driver_lin - driver function for linear Kalman Filter
% On input:
%   x0 (float): initial x location
%   y0 (float): initial y location
%   vx0 (float): initial x velocity
%   vy0 (float): initial y velocity
%   max_time (float): max time for tracking
%   del_t (float): time step size
%   theta (float): angle of line (in radians)
% Call:
%   [xt,at,zt,St] = CS4300_A5_driver_lin(0,0,1,20,10,0.3,pi/4);
%   CS4300_A6_plotter(xt,at,zt);
% Author:
%   Ryan Keepers and Leland Stenquist
%   UU
%   Fall 2016
%

clf;
plot(z(:,1),z(:,2), 'g.');
hold on;
plot(a(:,1),a(:,2), 'r--');
plot(x(:,1),x(:,2), 'b');