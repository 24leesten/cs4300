function v_t = CS4300_update_velocity(v_initial, acceleration,dt)
% CS4300_projectile_model - update your velocity give a deltat time
% On input:
%     v_initial (float): initial velocity
%     acceleration (float): acceleration
%     dt (float): time step
% On output:
%     v_t (float): the new velocity
% Call:
%     v = 0
%     gravity = 9.81
%     dt = 0.05
%     v_t = CS4300_projectile_model(v,gravity,dt);
% Author:
%     Ryan Keepers and Leland Stenquist
%     UU
%     Fall 2016
%

v_t = v_initial + acceleration * dt;