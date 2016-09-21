
function queue = CS4300_test_inert_into_que()
% CS4300_test_inert_into_que - Test insertion into the queue
% On input:
% On output:
%     queue (nx1 array): a sequence of small nodes
%       (i).cost (int): cast of the node
%       (i).name (int): name to id the node
% Call:
%     b = CS4300_test_inert_into_que();
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

n1.cost = 2;
n1.name = 'n1';
n2.cost = 3;
n2.name = 'n2';
n3.cost = 4;
n3.name = 'n3';
n4.cost = 4;
n4.name = 'n4';
pq = [n1 n2 n3 n4];


nt.cost = 5;
nt.name = 'nt';


%que = pq;

queue = CS4300_insert_into_pqueue(pq,nt,1);