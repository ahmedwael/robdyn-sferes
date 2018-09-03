clear all
close all
feedback_types = ["18", "36", "180", "none"];
program_types=["orientfb", "angled", "angled_pn", "torque"];
metrics_short = zeros(6,10,10,4); %metric,generation, run, feedback type 
g=10000;
p = 4;
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
feedback_types = ["18°", "36°", "180°", "Baseline"];
program_types_nice=["Standard", "Modified Fitness (Random)", "Modified Fitness (Both Directions)", "Torque Applied"];
% %% Plotting Performance
close all
%final_performance_short = reshape((metrics_short(1,10,:,:)+25)/5,[10 4]);
final_performance_short = reshape((performance_all(101,:,:)+25)/5,[4 10]);
final_performance_short = final_performance_short';
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
boxplot(final_performance_short(:,1:4), 'Labels', feedback_types(1:4));
% title("Forward Velocity of Final Generation (5 s)");
title(program_types_nice(p));
ylabel("Forward Velocity (m/s)");
xlabel("Orientation Feedback Type");
ylim([-0.2 1.0]);
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