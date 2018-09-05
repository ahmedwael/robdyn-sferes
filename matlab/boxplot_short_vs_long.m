program_types=["orientfb", "angled", "angled_pn", "torque"];
feedback_types = ["18", "36", "180", "none"];
metrics_short = zeros(6,10,4); %metric,generation, run, feedback type 
metrics_long = zeros(6,10,4); %metric,program, run, feedback type 
%%
for p = 1:1
for f = 1:4
    for r = 0:9
            directory_name = strcat(program_types(p),'/',program_types(p),'_',feedback_types(f),'/',program_types(p),'_',feedback_types(f),'_',string(r),'/');
            filename = strcat('performance_metrics_', feedback_types(f),'_', string(r),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname)
            metrics_short(:,r+1,f) = filedata;
            filename = strcat('performance_metrics_long_', feedback_types(f),'_', string(r),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_long(:,r+1,f) = filedata;
            save(strcat('short_long_',program_types(p),'.mat'),'metrics_short','metrics_long');
    end
end
end
%%

save('short_long.mat','metrics_short','metrics_long');
%%
program_types_nice=["OFB and BL", "MD-RAND", "MD-BOTH", "PERT"];
stats = zeros(10,8);
for p = 1:3:4

    
load(strcat('short_long_',program_types(p),'.mat'));

metrics_long(metrics_long == - 1000) = -25;
metrics_short(metrics_short == - 1000) = -25;

velocity_short = reshape((metrics_short(1,:,:)+25)/5,[10 4]);
velocity_long = reshape((metrics_long(1,:,:)+25)/15,[10 4]);

velocity_down = (velocity_long./velocity_short)*100;

if p == 1
stats(:,1:4)=velocity_down;
else
stats(:,5:8)=velocity_down;
end
legend_types = ["18°", "36°", "180°", "NF"];

figure(p+10)
boxplot(velocity_down, 'Labels', legend_types(1:4));
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
ylabel("Perfomance Retained (%)");
xlabel("Orientation Feedback Setting");
ylim([0 110]);
% print(strcat('boxshortslong_',program_types(p)),'-depsc2','-r300');
end

mean(mean(stats));
mean(mean(stats(:,1:4)));
mean(mean(stats(:,1:4)));
mean(mean(stats(:,[4,8])));
mean(mean(stats(:,[1,2,3,5,6,7])));
median(median(stats(:,[4,8])));
median(median(stats(:,[1,2,3,5,6,7])));
numel(stats(stats <33.3))/80
o = zeros(80,2);
o(o == 0) = NaN;
of= reshape(stats(:,[1,2,3,5,6,7]),[60 1])-10;
nof = reshape(stats(:,[4,8]),[20,1]);
% [x,h,tbl] = ranksum(of,nof,'alpha',0.05,...
%   'tail','right','method','approximate')


%% Plotting
feedback_types = ["18°", "36°", "180°", "NF"];
exp_types = ["5 s", "15 s"];
% figure(3)
% boxplot(velocity_down);
% boxplot(velocity_down, {reshape(repmat(feedback_types,2,1),8,1) repmat(exp_types',4,1)} ,'factorgap',8,'color','br');
% title("Forward Velocity of Final Generation 5vs15 s");
% ylabel("Forward Velocity (m/s)");
% xlabel("Orientation Feedback Type and Run Duration");

%% Loading

% velocity = zeros(5,10,4,8);
% velocity(:,1:2:8) = reshape((metrics_short(1,10,:,:)+25)/5,[10 4]);
% velocity(:,2:2:8) = reshape((metrics_long(1,10,:,:)+25)/15,[10 4]);


% divergence = zeros(10, 8);
% divergence(:,1:2:8) = reshape(abs(metrics_short(2,10,:,:))/5,[10 4]);
% divergence(:,2:2:8) = reshape(abs(metrics_long(2,10,:,:))/15,[10 4]);
% 
% arrival = zeros(10, 8);
% arrival(:,1:2:8) = reshape(metrics_short(5,10,:,:),[10 4]);
% arrival(:,2:2:8) = reshape(metrics_long(5,10,:,:),[10 4]);
% 
% absolute_arrival = abs(arrival);
% divergence_modified = zeros(9, 4);
% divergence_modified = reshape(abs(metrics_short(2,10,:,:))/5,[10 4]);


%%
figure(4)
boxplot(divergence, {reshape(repmat(feedback_types,2,1),8,1) repmat(exp_types',4,1)} ,'factorgap',8,'color','br');
title("Rate of Divergence of Final Generation 5vs15 s");
ylabel("Rate of Divergence (degrees/sec)");
xlabel("Orientation Feedback Type and Run Duration");

%%
figure(10)
boxplot(arrival, {reshape(repmat(feedback_types,2,1),8,1) repmat(exp_types',4,1)} ,'factorgap',8,'color','br');
title("Arrival Angle of Final Generation 5vs15 s");
ylabel("Arrival Angle (degrees)");
xlabel("Orientation Feedback Type and Run Duration");

%%
figure(20)
boxplot(absolute_arrival, {reshape(repmat(feedback_types,2,1),8,1) repmat(exp_types',4,1)} ,'factorgap',8,'color','br');
title("Absolute Arrival Angle of Final Generation 5vs15 s");
ylabel("Absolute Arrival Angle (degrees)");
xlabel("Orientation Feedback Type and Run Duration");