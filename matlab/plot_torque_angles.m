close all;
clear all;

r = 0;
f = 1;
%% Loading Metrics Long 
metrics_torque = zeros(6,30); %metric,generation, run, feedback type 
directory_name = strcat('orientfb_18_',string(r),'/');
for t = 1:30
    filename = strcat('performance_metrics_tmp_',string(t),'.dat');
    fullname = fullfile(directory_name, filename);
    filedata = load(fullname);
    metrics_torque(:,t) = filedata;
end

arrivalangle = abs(metrics_torque(5, :));
torque = linspace(1,30,30);

figure('Name','Orientation vs Torque')
plot(arrivalangle);
title("Chnage in Orientation with Torque on a Stationary Hexapod");
xlabel("Torque (Nm)");
ylabel("Change in Orientation (degrees)");
grid on




