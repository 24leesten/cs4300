function P = CS4300_get_P_matrix(states, actions, isWumpus)
% CS4300_get_P_matrix - take in a state and action and return the
% probability of getting to each neighboring state from there.
% On input:
%     states (1xn int vector): the total list of states
%     actions (1xk int vector): the total list of actions
% On output:
%     P (nxk float vector): the probability of reaching states s' from
%     every state,action
% Call:
%     states = [1:12];
%     actions = [1:4];
%     P = CS4300_get_P_matrix(states,actions);
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%
ROWS = length(states);
COLS = length(actions);

P = [];

for s = 1:ROWS
    for a = 1:COLS
        if isWumpus
            P(s,a).probabilities = CS4300_get_state_probs(s,a,4,4);
        else
            P(s,a).probabilities = CS4300_book_board_probs(s,a,3,4);
        end
    end
end