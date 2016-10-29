function out = get_info(stats)
% On input:
%     stats: (struct) relevant stats for the trials
%       stats.times1 (7x6x200 matrix) all timings for AC1
%       stats.times3 (7x6x200 matrix) all timings for AC3
%       stats.mean1  (7x6 matrix) mean timing for AC1
%       stats.mean3  (7x6 matrix) mean timing for AC3 
%       stats.diff   (7x6 matrix) diff of AC1 mean time - AC3 mean time
%       stats.better (7x6 matrix) value = 1 if AC3 mean faster than AC3
%       stats.onesbef(7x6x200 matrix) starting 1's for each trial
%       stats.onesaft(7x6x200 matrix) ending 1's for each trial
%       stats.onesdif(7x6x200 matrix) diff in 1's for each trial
%       stats.mean1s (7x6 matrix) mean reduction of 1's 

% 1 graph for each board size 4:10
% plot ac1 ave vector against ac3 ave vector
out = 0;

for b = 1:7
    figure();
    bm1 = 1000*stats.mean1(b,:);
    bm3 = 1000*stats.mean3(b,:);
    
    x = [0.0 0.2 0.4 0.6 0.8 1.0];
    
    p1=polyfit(x,bm1,2);
    disp 'p1';
    disp (p1);
    
    y1=polyval(p1,x);
    p3=polyfit(x,bm3,2);
    disp 'p3';
    disp (p3)
    y3=polyval(p3,x);
    
    plot(x,y1);
    hold on;
    plot(x,y3, 'r');
    
    legend('AC1','AC3');
    
    scatter(x,y3,'g');
    scatter(x,y1,'o');
    
    xlabel('Probability of Ones');
    ylabel('Average time cost (millis)');
    
    hold off;
end

