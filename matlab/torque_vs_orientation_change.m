close all;
clear all;

r = 1;
f = 1;
program_types=["orientfb", "angled", "angled_pn", "torque"];
feedback_types = ["18", "36", "180", "none"];
p = 1;
%% Loading Metrics Moving Anti Clockwise
metrics_torque_moving_acw = zeros(6,21); %metric,generation, run, feedback type 
directory_name = strcat(program_types(p),'/',program_types(p),'_',feedback_types(f),'/',program_types(p),'_',feedback_types(f),'_',string(r),'/');
filename = strcat('performance_metrics_18_1.dat');
fullname = fullfile(directory_name, filename);
filedata = load(fullname);
metrics_torque_moving_acw(:,1) = filedata;
for t = 1:20
    filename = strcat('performance_metrics_torque',string(t),'_18_1.dat');
    fullname = fullfile(directory_name, filename);
    filedata = load(fullname);
    metrics_torque_moving_acw(:,t+1) = filedata;
end

arrivalangle_moving_acw = metrics_torque_moving_acw(5, :);
arrivalangle_diff_moving_acw = metrics_torque_moving_acw(5, :)- metrics_torque_moving_acw(5, 1);
average_moving_acw = mean(abs(arrivalangle_moving_acw))*ones(1,30);
torque_moving_acw = linspace(0,20,21);
%% Loading Metrics Moving Clockwise
metrics_torque_moving_cw = zeros(6,22); %metric,generation, run, feedback type 
directory_name = strcat(program_types(p),'/',program_types(p),'_',feedback_types(f),'/',program_types(p),'_',feedback_types(f),'_',string(r),'/');
filename = strcat('performance_metrics_18_1.dat');
fullname = fullfile(directory_name, filename);
filedata = load(fullname);
metrics_torque_moving_cw(:,1) = filedata;
for t = 1:21
    filename = strcat('performance_metrics_torque',string(t),'_negative_18_1.dat');
    fullname = fullfile(directory_name, filename);
    filedata = load(fullname);
    metrics_torque_moving_cw(:,t+1) = filedata;
end

arrivalangle_moving_cw = metrics_torque_moving_cw(5, :);
arrivalangle_diff_moving_cw = metrics_torque_moving_cw(5, :)- metrics_torque_moving_acw(5, 1);
average_moving_cw = mean(abs(arrivalangle_moving_cw))*ones(1,30);
torque_moving_cw = linspace(0,21,22);
%% Loading Metrics Stationary 
metrics_torque_stationary = zeros(6,31); %metric,generation, run, feedback type 
% directory_name = strcat('orientfb_18_',string(r),'/');
directory_name = 'torque_tests';
for t = 1:30
    filename = strcat('performance_metrics_tmp_',string(t),'.dat');
    fullname = fullfile(directory_name, filename);
    filedata = load(fullname);
    metrics_torque_stationary(:,t+1) = filedata;
end

arrivalangle_stationary = abs(metrics_torque_stationary(5, :));
torque_stationary = linspace(0,30,31);

% plot(torque, arrivalangle_diff)
% plot(average);
%%
close all
figure('defaultAxesColorOrder',[0.9290    0.6940    0.1250]);
set(gca,...
'Units','normalized',...
'FontWeight','normal',...
'FontSize',10.5);
width = 7.5;     % Width in inches
height = 2.5;    % Height in inches
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);
% set('defaultAxesColorOrder',[0 0 0; 0 0 0]);
plot(torque_moving_acw, abs(arrivalangle_diff_moving_acw),'LineWidth',2, 'Color', [0    0.4470    0.7410]);
grid on
hold on
plot(torque_moving_cw, abs(arrivalangle_diff_moving_cw),'LineWidth',2, 'Color', [0.4940, 0.1840, 0.5560]);
plot(torque_stationary, abs(arrivalangle_stationary),'LineWidth',2,'Color',[0.8500    0.3250    0.0980]);
ylabel("Orientation Change (degrees)");
yyaxis right
x = 0:0.1:30;
y = gauss_distribution(x,7, 1.5);
plot(x,y,'LineWidth',2,'Color',[0.9290    0.6940    0.1250]);
title("Change of Hexapod Orientation with Torque");
xlabel("Torque (Nm)");
ylabel("Probability");
ylim([0 1]);
legend(["Moving Hexapod (ACW)", "Moving Hexapod (CW)", "Stationary Hexapod", "Probability of Torque"],...
'FontUnits','points',...
'FontSize',8,...
'Location','NorthWest')
