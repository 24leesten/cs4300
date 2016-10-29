function times = driver()

max_steps = 2000;
f_name = 'CS4300_HWA';

clear(f_name);

board1 = [0,0,0,3;...
    0,0,0,0;...
    2,1,0,0;...
    0,0,0,0];
board3 = [0,0,0,0;...
    0,0,0,0;...
    3,2,0,0;...
    0,1,0,0];


b1Times = [];
b2Times = [];

for i = 1:25
    
    tic

    [score,trace] = CS4300_WW1(max_steps,f_name,board1);

    b1Times = [b1Times toc];


end
    


times(1).b1t = b1Times;
times(1).b1m = mean(b1Times);

