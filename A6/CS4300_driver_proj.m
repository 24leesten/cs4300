function [xt,at,zt,St] = CS4300_driver_proj(dt,t_max,obs_freq,g,r,q)
% CS4300_driver_proj - driver for Kalman Filter projectile tracking
% This script demonstrates the use of the kalman filter in projectile
% tracking.
%
%   A simple model for a 2D projectile is obtained and used for the
%   kalman
%   filter transition model. The actual trajectory of the projectile is
%   simulated using a more complex and accurate model. Observations of
%   the
%   actual projectile trajectory are obtained. The kalman filter is used
%   to
%   generate beliefs on the actual projectile state. All three
%   trajectories
%   (the simple model, the complex model, and the kalman belief) are
%   plotted,
%   along with the observations made.
% On input:
%   dt (float): simulation time step in seconds (e.g., 0.1)
%   t_max (float): max simulation time in seconds (e.g., 35)
%   obs_freq (float): frequency with which time steps are observed,
%       range [0,1] (e.g., .35)
%   g (float): gravitational acceleration in m/sˆ2 (9.8)
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
