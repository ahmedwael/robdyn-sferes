close all;
clear all;

r = 0;
f = 1;
%% Loading Metrics Long 
metrics_torque = zeros(6,16); %metric,generation, run, feedback type 
directory_name = strcat('orientfb_18_',string(r),'/');
for t = 0:15
    filename = strcat('performance_metrics_rand_moving_rand_',string(t),'.dat');
    fullname = fullfile(directory_name, filename);
    filedata = load(fullname);
    metrics_torque(:,t+1) = filedata;
end

arrivalangle = metrics_torque(5, :);
arrivalangle_diff = metrics_torque(5, :)- metrics_torque(5, 1);
average = mean(abs(arrivalangle))*ones(1,30);
torque = linspace(0,15,16);

figure('Name','Orientation vs Torque')
plot(torque, abs(arrivalangle_diff))
title("Change in Orientation with CW Torque on Moving Hexapod");
xlabel("Torque (Nm)");
ylabel("Absolute Change in Orientation (degrees)");
grid on
hold on
% plot(torque, arrivalangle_diff)
% plot(average);



