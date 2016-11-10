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

% This is where we are initializing velocity and position
x0 = 0;
y0 = 0;
vx0 = 340;
vy0 = 340;

x_bar = [x0; y0; 0; 0];

A = eye(4);
A(1,3) = dt;
A(2,4) = dt;

B = [(dt^2)/2, 0          ;
     0,        (dt^2)/2   ;
     dt,       0          ;
     0,        dt         ];
 
u_bar = [0; GRAVITY;];

R = eye(4) * SIGMA2;
Q = eye(4) * SIGMA2Z;
C = [1 0 0 0;
     0 1 0 0;
     0 0 0 0;
     0 0 0 0];

var = [ sqrt(SIGMA2)*randn 0 0 0;
        0 sqrt(SIGMA2)*randn 0 0;
        0 0 sqrt(SIGMA2)*randn 0;
        0 0 0 sqrt(SIGMA2)*randn ];

x_upd = [x0;y0;vx0;vy0];
x_actual = x_upd;
z_bar = x_upd;

xt = [x_bar'];
at = [x_actual'];
zt = [z_bar'];


for s=1:num_time_vals   
   %ideal
   x_upd = A * x_actual + B * u_bar;   
   %actual
   x_actual = x_upd + R * [randn; randn; randn; randn];   
   
   if(x_actual(2) < 0)
       x_actual(2) = abs(x_actual(2));
       x_actual(4) = -x_actual(4);
   end
   
   %sensor
   z_bar = C * x_actual + R * [randn; randn; 0; 0];
   
   %kf
   [x_bar, var] = CS4300_KF(x_bar, var, u_bar, z_bar, A, R, B, C, Q);
      
  %record the current x,y
   if mod(dt*s, obs_freq) == 0
       xt = [xt;x_bar'];
       at = [at;x_actual'];
       zt = [zt;z_bar'];
       St(s).Sigma2 = var;
   end   
end
