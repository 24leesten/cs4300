function [x_t,y_t] = CS4300_projectile_model(x_initial,x_velocity_t,y_initial,y_velocity_t,dt)
% CS4300_projectile_model - calculates one step in falling object trajectory
% On input:
%     x_initial (float): distance at previous time
%     x_velocity_t (float): control parameter at this step
%     y_initial (float): height at previous time
%     y_velocity_t (float): control parameter at this step
%     dt (float): time step
% On output:
%     x_t (float): distance at next time
%     y_t (float): height at next time
% Call:
%     y(s+1) = CS4300_projectile_model(x(s),x(s+1),y(s),v(s+1),dt);
% Author:
%     Ryan Keepers and Leland Stenquist
%     UU
%     Fall 2016
%

x_t = x_initial + x_velocity_t*dt;
y_t = y_initial + y_velocity_t*dt;
