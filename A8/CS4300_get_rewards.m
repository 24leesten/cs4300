function R = CS4300_get_rewards(reward, isWumpus)
% CS4300_get_rewards - take in a state and action and return the
% probability of getting to each neighboring state from there.
% On input:
%     reward (float): the reward at each step
%     isWumpus (bool): sets the static reward states
% On output:
%     R (vector): 1 x n float array of reward values
% Call:
%     reward = -0.04;
%     R = CS4300_get_rewards(reward,false);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

if isWumpus
    R = zeros(1,16) + reward;
    R(7) = -1;
    R(11) = -1;
    R(12) = -1;
    R(16) = 1;
else
    R = zeros(1,12) + reward;
    R(6) = 0;
    R(8) = -1;
    R(12) = 1;
end