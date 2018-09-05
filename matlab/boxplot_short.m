clear all
close all
program_types=["orientfb", "angled", "angled_pn", "torque"];
file_names = ["orientfb","angled","angled_pn","torque"];
% feedback_types = ["18°", "36°", "180°", "Baseline"];
legend_types = ["18°", "36°", "180°", "NF"];
% program_types_nice=["Baseline and Orient. FB", "\pm60\circ Goal (Random)", "\pm60\circ Goal (Both Directions)", "Perturbation Applied"];
program_types_nice=["OFB and BL", "MD-R", "MD-B", "PERT"];
final_performance_short_all=zeros(10,16);
for p = 1:4

load(strcat("performance_100s_max_",program_types(p),".mat"));
performance_all(performance_all > -1) = NaN;
nonnan = sum(~isnan(performance_all));
nonnan(nonnan == 0) = 1;
nonnan=reshape(nonnan,[4 10]);

if p == 3
   performance_all = performance_all*0.5; 
end

for i = 1:4
   for j=1:10
       performance_all(101,i,j)=performance_all(nonnan(i,j),i,j);
   end
end

final_performance_short = reshape((performance_all(101,:,:)+25)/5,[4 10]);
final_performance_short = final_performance_short';
final_performance_short_all(:,4*(p-1)+1:4*p) = final_performance_short;

figure(p+10)
if (p == 2 || p==3)
    boxplot(final_performance_short(:,1:3), 'Labels', legend_types(1:3));
else
    boxplot(final_performance_short(:,1:4), 'Labels', legend_types(1:4));
end
pause(0.5)
grid on
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
title(program_types_nice(p));
ylabel("Forward Velocity (m/s)");
xlabel("Orientation Feedback Setting");
ylim([0 1.0]);
print(strcat('boxshort_',file_names(p)),'-depsc2','-r300');
end
%% stats
% [x,tbl,stats] = kruskalwallis(final_performance_short_all(:,[1,2,3,4,5,6,7,9,10,11,14,16]),[],'off')
% [x,tbl,stats] = kruskalwallis(final_performance_short_all(:,2:4:16),[],'off')
ofb = vertcat(final_performance_short_all(:,1),final_performance_short_all(:,2),final_performance_short_all(:,3));
bl_ofb= vertcat(ofb,final_performance_short_all(:,4));
straight = vertcat(bl_ofb,final_performance_short_all(:,14),final_performance_short_all(:,16)); 
modified = vertcat(final_performance_short_all(:,5),final_performance_short_all(:,6),final_performance_short_all(:,7),final_performance_short_all(:,9),final_performance_short_all(:,9),final_performance_short_all(:,11));
median(straight);
median(modified);
median(modified(1:30))
iqr(straight);
iqr(modified(1:30))
median(modified(31:60))
iqr(modified(31:60))
% [x,h,stats] = ranksum(ofb,final_performance_short_all(:,4),'alpha',0.05,...
%     'tail','right','method','approximate')
% [x,h,stats] = ranksum(final_performance_short_all(:,14),final_performance_short_all(:,16),'alpha',0.05,...
% 'tail','left','method','approximate')
%  [x,h,stats] = ranksum(modified,straight,'alpha',0.05,...
%  'tail','left','method','approximate')
[x,h,stats] = ranksum(modified(31:60),modified(1:30),'alpha',0.05,...
 'tail','left','method','approximate')
% x = kruskalwallis(final_performance_short_all(:,[8,12,13,15]))
%%
figure(99)

%% Plotting Performance

final_performance_short = reshape((metrics_short(1,10,:,:)+25)/5,[10 4]);
figure(2)
boxplot(final_performance_short, 'Notch','on', 'Labels', feedback_types,'LineWidth',2);
title("Forward Velocity of Final Generation (5 s)");
ylabel("Forward Velocity (m/s)");
xlabel("Orientation Feedback Type");

%% Plotting Orientation

final_orientation_short = reshape(abs(metrics_short(2,10,:,:))/5,[10 4]);
figure(2)
boxplot(final_orientation_short,'Labels', feedback_types);
title("Rate of Divergence of Final Generation (5 s)");
ylabel("Rate of Divergence (degrees/sec)");
xlabel("Orientation Feedback Type");
%%
c = multcompare(metrics_short(1,10,:,:));

%% 
% for f = 1:4
%     for r = 0:9
%         directory_name = strcat(program_types(p),'/',program_types(p),'_',feedback_types(f),'/',program_types(p),'_',feedback_types(f),'_',string(r),'/');
% %         for g = 10000:10000:10000
%             filename = strcat('performance_metrics_', feedback_types(f),'_', string(r),'.dat');
%             fullname = fullfile(directory_name, filename);
%             filedata = load(fullname);
%             metrics_short(:,g/1000,r+1,f) = filedata;
% %         end
%     end
% end
feedback_types = ["18", "36", "180", "none"];
g=10000;
metrics_short = zeros(6,10,10,4); %metric,generation, run, feedback type 
% title("Forward Velocity of Final Generation (5 s)");