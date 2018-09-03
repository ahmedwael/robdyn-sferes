program_types=["orientfb", "angled", "angled_pn", "torque"];
program_types_nice=["Standard", "Modified Fitness (Random)", "Modified Fitness (Both Directions)", "Torque Applied"];
feedback_types = ["18", "36", "180", "baseline"];
legend_types = ["\pm18\circ", "\pm36\circ", "\pm180\circ", "baseline"];
close all
generations = linspace(0,10000,101);
p = 4;
load(strcat("performance_100s_max_",program_types(p),".mat"));
% r = 5
%r = 3
if p == 3
   performance_all = performance_all*0.5; 
end
performance_all(performance_all > -1) = NaN;
performance_median = nanmedian(performance_all, 3);
performance_1stqnt = quantile(performance_all,0.4,3);
performance_3rdqnt = quantile(performance_all,0.6,3);
performance_iqr= iqr(performance_all,3);
(performance_median(101,:)+25)
performance_iqr(101,:)
% performance_std = std(performance_all,0, 3);
% performance_std = 0.3*performance_std;
figure(1)
set(gca,...
'Units','normalized',...
'FontWeight','normal',...
'FontSize',10.5);
width = 3.25;     % Width in inches
height = 2.5;    % Height in inches
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);
hold on
% f = 1;
%     p1 = plot(generations, (performance_median(:,f,:)+25)/5,'Color',[0    0.4470    0.7410],'LineWidth',2);
%     ciplot((performance_1stqnt(:,f)+25)/5,(performance_3rdqnt(:,f)+25)/5,generations, [0    0.4470    0.7410]);
f = 2;
    p2 = plot(generations, (performance_median(:,f,:)+25)/5, 'Color',[0.8500    0.3250    0.0980],'LineWidth',2);
    ciplot((performance_1stqnt(:,f)+25)/5,(performance_3rdqnt(:,f)+25)/5,generations, [0.8500    0.3250    0.0980]);
% f = 3;
%     p3 = plot(generations, (performance_median(:,f,:)+25)/5,'Color', [0.9290    0.6940    0.1250],'LineWidth',2);
%     ciplot((performance_1stqnt(:,f)+25)/5,(performance_3rdqnt(:,f)+25)/5,generations, [0.9290    0.6940    0.1250]);
f = 4;
    p4 = plot(generations, (performance_median(:,f,:)+25)/5, 'Color', [0.4940    0.1840    0.5560],'LineWidth',2);
    ciplot((performance_1stqnt(:,f)+25)/5,(performance_3rdqnt(:,f)+25)/5,generations, [0.4940    0.1840    0.5560]);

 
% end
% title("Performance Time-Line: ",);
title(program_types_nice(p))
xlabel("Generation");
ylabel('Y-Direction Velocity (m/s)');
grid on    
ylim([0 0.8]);
legend([p2 p4],legend_types(2:2:4));
savefig(strcat("Median_Max_Performance_all_Generations_", program_types(p)));    