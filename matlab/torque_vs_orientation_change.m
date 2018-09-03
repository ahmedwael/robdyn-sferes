close all;
clear all;

r = 0;
f = 1;
%% Loading Metrics Moving 
metrics_torque_moving = zeros(6,16); %metric,generation, run, feedback type 
% directory_name = strcat('orientfb_18_',string(r),'/');
directory_name = 'torque_tests';
for t = 0:15
    filename = strcat('performance_metrics_rand_moving_rand_',string(t),'.dat');
    fullname = fullfile(directory_name, filename);
    filedata = load(fullname);
    metrics_torque_moving(:,t+1) = filedata;
end

arrivalangle_moving = metrics_torque_moving(5, :);
arrivalangle_diff_moving = metrics_torque_moving(5, :)- metrics_torque_moving(5, 1);
average_moving = mean(abs(arrivalangle_moving))*ones(1,30);
torque_moving = linspace(0,15,16);
%% Loading Metrics Stationary 
metrics_torque_stationary = zeros(6,30); %metric,generation, run, feedback type 
% directory_name = strcat('orientfb_18_',string(r),'/');
directory_name = 'torque_tests';
for t = 1:30
    filename = strcat('performance_metrics_tmp_',string(t),'.dat');
    fullname = fullfile(directory_name, filename);
    filedata = load(fullname);
    metrics_torque_stationary(:,t) = filedata;
end

arrivalangle_stationary = abs(metrics_torque_stationary(5, :));
torque_stationary = linspace(1,30,30);

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
plot(torque_moving(2:end), abs(arrivalangle_diff_moving(2:end)),'LineWidth',2, 'Color', [0    0.4470    0.7410]);
grid on
hold on
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
legend("Moving Hexapod", "Stationary Hexapod", "Probability of Torque");

