function [x_trace,a_trace,z_trace,Sigma2_trace] = CS4300_A5_driver_lin(...
x0,y0,vx0,vy0,max_time,del_t,theta)
% CS4300_A5_driver_lin - driver function for linear Kalman Filter
% On input:
%   x0 (float): initial x location
%   y0 (float): initial y location
%   vx0 (float): initial x velocity
%   vy0 (float): initial y velocity
%   max_time (float): max time for tracking
%   del_t (float): time step size
%   theta (float): angle of line (in radians)
% On output:
%   x_trace (nx2 array): each row has estimated pose (x,y vals)
%   a_trace (nx2 array): actual location at each time step
%   z_trace (nx2 array): sensed location at each time step
%   Sigma2_trace (struct array): covariance of estimated location
%       (i).Sigma2 (2x2 array): covariance matrix for i_th step
% Call:
%   [xt,at,zt,St] = CS4300_A5_driver_lin(0,0,1,1,1,0.1,pi/4);
% Author:
%   Ryan Keepers and Leland Stenquist
%   UU
%   Fall 2016
%

% Constants
ALPHA = 0;
GRAVITY = -9.81 * ALPHA;
SIGMA2 = 0.1;
SIGMA2Z = 0.25;

% Let's Add in the ideal
time_vals = [0:del_t:max_time];
num_time_vals = length(time_vals);

x_trace = zeros(num_time_vals,2);
a_trace = zeros(num_time_vals,2);
z_trace = zeros(num_time_vals,2);
Sigma2_trace = [];

x_model = x0;
x_noisy = x_model;
x_sensor = x_model;
y_model(1) = y0;
y_noisy = y_model;
y_sensor = y_model;

v_x = vx0;
v_y = vy0;

x_bar = [x0; y0; v_x; v_y];
A = eye(4);
A(1,3) = del_t;
A(2,4) = del_t;
B = [(del_t^2)/2 0; 0 (del_t^2)/2; del_t 0; 0 del_t];
u_bar = [0; 0]
R = A * SIGMA2;
Q = A * SIGMA2Z;

mu = [x0; y0];
var = zeros(2);

for s=1:num_time_vals 
   %record the current x,y
   x_trace(s,:) = [mu(1) mu(2)];
   a_trace(s,:) = [x_noisy y_noisy];
   z_trace(s,:) = [x_sensor y_sensor];
   Sigma2_trace(s).Sigma2 = var;
   
   x_bar = (A * x_bar) + (B * u_bar);
   [x_model, y_model] = CS4300_projectile_model(x_model, vx0, y_model,v_y,del_t);
   
   if(y_model < 0)
       y_model = abs(y_model);
       v_y = -v_y;
   end
 
   x_noisy = x_model + sqrt(SIGMA2)*randn;
   y_noisy = y_model + sqrt(SIGMA2)*randn;
   
   [x_sensor,y_sensor] = CS4300_projectile_sensor(x_model, y_model, 1, SIGMA2Z);
   
   [mu, var] = CS4300_KF(mu, var, [v_x, v_y]', [x_sensor, y_sensor]', A, B, R, eye(2), Q);
   
end

