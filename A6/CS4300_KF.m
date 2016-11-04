function [mu_t,Sigma_t] = CS4300_KF(mu_tm1,Sigma_tm1,u_t,z_t,A_t,R_t,...
B_t,C_t,Q_t)
% CS4300_KF - one step in Kalman Filter
% On input:
%   mu_tm1 (nx1 vector): previous state estimate vector
%   Sigma_tm1 (nxn matrix): state covariance matrix
%   u_t (nx1 vector): control vector
%   z_t (nx1 vector): measurement vector
%   A_t (nxn matrix): state transition matrix
%   R_t (nxn matrix): state transition covariance matrix
%   C_t (nxn matrix): linear transform for measurement equation
%   Q_t (nxn matrix): noise covariance matrix
% On output:
%   mu_t (nx1 vector): next state estimate
%   Sigma_t (nxn matrix): state covariance matrix
% Call:
%   [x,Sigma2] = CS4300_KF(x,Sigma2,u,z,A,B,R,C,Q);
% Author:
%   Ryan Keepers and Leland Stenquist
%   UU
%   Fall 2016
%

DEBUG = 0;

if DEBUG
    disp 'A';
    disp(A_t);
    disp 'mu tm1';
    disp (mu_tm1);
    disp 'B';
    disp (B_t);
    disp 'u';
    disp (u_t);
end

% mu = A*u_t-1 + B*u_t
mu_t = A_t * mu_tm1 + B_t * u_t;

% SIGMA = A*SIGMA_t-1*AT + R
Sigma_t = A_t * Sigma_tm1 * A_t' + R_t;

% K = SIGMA*CT*inv(C*SIGMA*CT + Q)
K = Sigma_t * C_t' * inv(C_t * Sigma_t * C_t' + Q_t);

% mu_t = mu + K*(z_t - C*mu)
mu_t = mu_t + K * (z_t - C_t * mu_t);

% SIGMA_t = (I-K*C)*SIGMA
Sigma_t = (eye(length(u_t)) - K * C_t) * Sigma_t;
