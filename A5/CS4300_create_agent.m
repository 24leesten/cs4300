function agent = CS4300_create_agent(state)
% CS4300_create_agent - create a hybrid agent struct
% On input:
%     state (1x3 array): representing the state of the agent
%         (1): x location of the agent
%         (2): y location of the agent
%         (3): direction the agent is facing
% On output:
%     agent (struct): the hybrid agent
%         x: x location of the agent
%         y: y loaction of the agent
%         dir: direction the agent is facing
% Call:
% action = CS4300_MC_HWA([1 0 0 1 0]);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

agent.x = state(1);
agent.y = state(2);
agent.dir = state(3);