program_types=["orientfb", "angled", "angled_pn", "torque"];
% program_types_nice=["Baseline and Orient. FB", "\pm60\circ Goal (Random)", "\pm60\circ Goal (Both Directions)", "Perturbation Applied"];
program_types_nice=["OFB and BL", "MD-RAND", "MD-BOTH", "PERT"];
feedback_types = ["18", "36", "180", "baseline"];
legend_types = ["\pm18\circ", "\pm36\circ", "\pm180\circ", "NF"];
file_names = ["orientfb","angled","angled_pn","torque"];
close all
generations = linspace(0,10000,101);
for p = 4:4
% p = 4;
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
% (performance_median(81,:)+25)/5
performance_iqr(81,:)/5
% performance_std = std(performance_all,0, 3);
% performance_std = 0.3*performance_std;
figure(p)
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
f = 1;
    p1 = plot(generations, (performance_median(:,f,:)+25)/5,'Color',[0    0.4470    0.7410],'LineWidth',2);
%     ciplot((performance_1stqnt(:,f)+25)/5,(performance_3rdqnt(:,f)+25)/5,generations, [0    0.4470    0.7410]);
f = 2;
    p2 = plot(generations, (performance_median(:,f,:)+25)/5, 'Color',[0.8500    0.3250    0.0980],'LineWidth',2);
%     ciplot((performance_1stqnt(:,f)+25)/5,(performance_3rdqnt(:,f)+25)/5,generations, [0.8500    0.3250    0.0980]);
f = 3;
    p3 = plot(generations, (performance_median(:,f,:)+25)/5,'Color', [0.9290    0.6940    0.1250],'LineWidth',2);
%     ciplot((performance_1stqnt(:,f)+25)/5,(performance_3rdqnt(:,f)+25)/5,generations, [0.9290    0.6940    0.1250]);
f = 4;
    p4 = plot(generations, (performance_median(:,f,:)+25)/5, 'Color', [0.4940    0.1840    0.5560],'LineWidth',2);
%     ciplot((performance_1stqnt(:,f)+25)/5,(performance_3rdqnt(:,f)+25)/5,generations, [0.4940    0.1840    0.5560]);

title(program_types_nice(p))
xlabel("Generation");
ylabel("Forward Velocity (m/s)");
grid on    
ylim([0 0.8]);
if  p < 4
location = 'NorthWest';
else
location = 'SouthEast';
end
if (p == 2 || p== 3)
legend([p1 p2 p3],legend_types(1:1:3),...
'FontUnits','points',...
'FontSize',8,...
'Location',location);
else
legend([p1 p2 p3 p4],legend_types(1:1:4),...
'FontUnits','points',...
'FontSize',8,...
'Location',location);
end
% savefig(strcat("Median_Max_Performance_all_Generations_", program_types(p)));
print(strcat('convergence_',file_names(p)),'-depsc2','-r300');
end