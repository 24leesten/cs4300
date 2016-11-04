function [xt,at,zt,St] = CS4300_driver_proj(dt,t_max,obs_freq,g,r,q)
% CS4300_driver_proj - driver for Kalman Filter projectile tracking
% This script demonstrates the use of the kalman filter in projectile
% tracking.
%
%   A simple model for a 2D projectile is obtained and used for the kalman
%   filter transition model. The actual trajectory of the projectile is
%   simulated using a more complex and accurate model. Observations of the
%   actual projectile trajectory are obtained. The kalman filter is used to
%   generate beliefs on the actual projectile state. All three trajectories
%   (the simple model, the complex model, and the kalman belief) are plotted,
%   along with the observations made.
% On input:
%   dt (float): simulation time step in seconds (e.g., 0.1)
%   t_max (float): max simulation time in seconds (e.g., 35)
%   obs_freq (float): frequency with which time steps are observed,
%       range [0,1] (e.g., .35)
%   g (float): gravitational acceleration in m/s�2 (9.8)
%   r (float): transition noise; (e.g., 2)
%       increase for faster response to observations
%   q (float):observation noise; increase for greater
%       observation spread (e.g., 10)
% On output:
%   xt (nx4 array): trace of estimated pose
%   at (nx4 array): trace of actual pose
%   zt (mx2 array): trace of sensor data
%   St (struct array): covariance matrix trace
%       (i).Sigma2 (4x4 array): estimated vector covariance
% Call:
% [xt,at,zt,St] = CS4300_driver_proj(0.1,35,0.35,9.8,2,10);
% Author:
%   Ryan Keepers and Leland Stenquist
%   UU
%   Fall 2016
%


% Constants
ALPHA = 1;
GRAVITY = -g * ALPHA;
SIGMA2 = r;
SIGMA2Z = q;

% Let's Add in the ideal
time_vals = [0:dt:t_max];
num_time_vals = length(time_vals);
St = [];

x0 = 0;
y0 = 0;
vx0 = 20;
vy0 = 100;

x_model = x0;
x_noisy = x_model;
x_sensor = x_model;
y_model(1) = y0;
y_noisy = y_model;
y_sensor = y_model;

v_x = vx0;
v_y = vy0;

A = eye(2);
B = A * dt;
R = A * SIGMA2;
Q = A * SIGMA2Z;

mu = [x0; y0];
var = zeros(2);

xt = [mu(1), mu(2)];
at = [x_noisy, y_noisy];
zt = [x_sensor, y_sensor];

for s=1:num_time_vals   
   v_y = CS4300_update_velocity(v_y, GRAVITY, dt);
   [x_model, y_model] = CS4300_projectile_model(x_model, vx0, y_model,v_y,dt);
   
   if(y_model < 0)
       y_model = abs(y_model);
       v_y = -v_y;
   end
 
   x_noisy = x_model + sqrt(SIGMA2)*randn;
   y_noisy = y_model + sqrt(SIGMA2)*randn;
   
   [x_sensor,y_sensor] = CS4300_projectile_sensor(x_model, y_model, 1, SIGMA2Z);
   
   [mu, var] = CS4300_KF(mu, var, [v_x, v_y]', [x_sensor, y_sensor]', A, B, R, eye(2), Q);
   
      %record the current x,y
   if mod(dt*s, obs_freq) == 0
       xt = [xt;[mu(1) mu(2)]];
       at = [at; [x_noisy y_noisy]];
       zt = [zt; [x_sensor y_sensor]];
       St(s).Sigma2 = var;
   end   
end

