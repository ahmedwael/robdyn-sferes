
feedback_types = ["18", "36", "180", "baseline"];
close all
generations = linspace(0,10000,101);
% r = 5
r = 3
figure(r+1)    
for f = 1:4
    plot(generations, reshape((performance_all(:,f,r+1)+25)/5,1,101));
    hold on
end
title(strcat("Maximum Performance Across Generations, Run ", string(r)));
xlabel("Generation");
ylabel('Y-Direction Velocity (m/s)');
grid on    
ylim([0 1]);
legend(feedback_types);
savefig(strcat("Max_Performance_Run_", string(r)));    