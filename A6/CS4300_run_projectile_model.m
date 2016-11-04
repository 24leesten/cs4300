function [y,v,M] = CS4300_run_projectile_model(x0,y0,v0,vx0,g,t_max,dt)
% CS4300_run_projectile_model - calculates projectile trajectory
% On input:
%     x0 (float): initial distance of object
%     y0 (float): initial height of object
%     v0 (float): initial velocity of object in the y direction
%     vx0 (float): initial velocity of object in the x direction
%     g (float): acceleration
%     t_max (float): max time to run simulation
%     dt (float): time step
% On output:
%     y (nx1 vector): height trajectory of object
%     v (nx1 vector): velocity trajectory of object
%     M (movie): movie of falling object
% Call:
%     [y,v,M] = CS4300_run_projectile_model(0,0.2,20,2,-9.81,10,0.5);
% Author:
%     Ryan Keepers and Leland Stenquist
%     UU
%     Fall 2016
%

t_vals = [0:dt:t_max];
num_t_vals = length(t_vals);
y = zeros(num_t_vals,1);
y(1) = y0;
x = zeros(num_t_vals,1);
x(1) = x0;
v = zeros(num_t_vals,1);
v(1) = v0;
plot([-10,10],[0,0]);
hold on
plot([0,0],[-1,100]);
plot(3,y0,'ko');
M(1) = getframe;
for s = 1:num_t_vals
    v(s+1) = CS4300_update_velocity(v(s),g,dt);
    [x(s+1), y(s+1)] = CS4300_projectile_model(x(s),vx0,y(s),v(s+1),dt);
    if y(s+1)<0
        y(s+1) = abs(y(s+1));
        v(s+1) = -v(s+1);
    end
    clf
    plot([-10,10],[0,0]);
    hold on
    plot([0,0],[-1,100]);
    plot(x(s+1),y(s+1),'ko');
    M(s+1) = getframe;
end
