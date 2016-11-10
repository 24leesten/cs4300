function CS4300_A6_plot_vel(x, a)
% CS4300_A5_driver_lin - driver function for plotting velocities
% On input:
%   x (1xn vector): estimates locations
%   a (1xn vector): actual locations
% Call:
%   [xt,at,zt,St] = CS4300_A5_driver_lin(0,0,1,20,10,0.3,pi/4);
%   CS4300_A6_plotter(xt,at);
% Author:
%   Ryan Keepers and Leland Stenquist
%   UU
%   Fall 2016
%

clf;
hold on;
title('Velocity')
xlabel('time')
plot(a(:,3), 'r--');
plot(a(:,4), 'g');
plot(x(:,3), 'b');
plot(x(:,4));
legend('actual x','actual y', 'estimate x', 'estimate y');