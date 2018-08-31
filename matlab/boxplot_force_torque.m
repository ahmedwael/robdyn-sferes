close all;
%clear all;

feedback_types = ["18", "36", "180", "none"];
exp_types = ["0", "ACW", "CW"];
% exp_types = ["None", "F Left", "F Right", "T ACW", "T CW"];

metrics_long = zeros(6,10,10,4); %metric,generation, run, feedback type 
% metrics_long_forced = zeros(6,10,10,4); %metric,generation, run, feedback type 
% metrics_long_forced_right = zeros(6,10,10,4); %metric,generation, run, feedback type
metrics_long_torque_acw = zeros(6,10,10,4); %metric,generation, run, feedback type
metrics_long_torque_cw = zeros(6,10,10,4); %metric,generation, run, feedback type
for f = 1:4
    for r = 0:9
        directory_name = strcat('orientfb_',feedback_types(f),'/orientfb_',feedback_types(f),'_',string(r),'/');
        for g = 10000:10000
            
            filename = strcat('performance_metrics_long_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_long(:,g/1000,r+1,f) = filedata;
            
%             filename = strcat('performance_metrics_long_forced_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
%             fullname = fullfile(directory_name, filename);
%             filedata = load(fullname);
%             metrics_long_forced(:,g/1000,r+1,f) = filedata;
%             
%             filename = strcat('performance_metrics_long_forced_', feedback_types(f),'_', string(r),'_other_', string(g),'.dat');
%             fullname = fullfile(directory_name, filename);
%             filedata = load(fullname);
%             metrics_long_forced_right(:,g/1000,r+1,f) = filedata;
            
            filename = strcat('performance_metrics_long_torque_', feedback_types(f),'_', string(r),'_acw_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_long_torque_acw(:,g/1000,r+1,f) = filedata;
            
            filename = strcat('performance_metrics_long_torque_', feedback_types(f),'_', string(r),'_cw_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_long_torque_cw(:,g/1000,r+1,f) = filedata;
        end
    end
end

% metrics_long_forced(metrics_long_forced <= -100) = NaN;
% metrics_long_forced_right(metrics_long_forced_right <= -100) = NaN;
metrics_long_torque_acw(metrics_long_torque_acw <= -100) = NaN;
metrics_long_torque_cw(metrics_long_torque_cw <= -100) = NaN;

velocity = zeros(10, 12);
velocity(:,1:3:12) = reshape((metrics_long(1,10,:,:)+25)/15,[10 4]);
% velocity(:,2:5:20) = reshape((metrics_long_forced(1,10,:,:)+25)/15,[10 4]);
% velocity(:,3:5:20) = reshape((metrics_long_forced_right(1,10,:,:)+25)/15,[10 4]);
velocity(:,2:3:12) = reshape((metrics_long_torque_acw(1,10,:,:)+25)/15,[10 4]);
velocity(:,3:3:12) = reshape((metrics_long_torque_cw(1,10,:,:)+25)/15,[10 4]);

divergence = zeros(10, 12);
divergence(:,1:3:12) = reshape(abs(metrics_long(2,10,:,:))/15,[10 4]);
% divergence(:,2:5:20) = reshape(abs(metrics_long_forced(2,10,:,:))/15,[10 4]);
% divergence(:,3:5:20) = reshape(abs(metrics_long_forced_right(2,10,:,:))/15,[10 4]);
divergence(:,2:3:12) = reshape(abs(metrics_long_torque_acw(2,10,:,:))/15,[10 4]);
divergence(:,3:3:12) = reshape(abs(metrics_long_torque_cw(2,10,:,:))/15,[10 4]);

arrival = zeros(10, 12);
arrival(:,1:3:12) = reshape(metrics_long(5,10,:,:),[10 4]);
% arrival(:,2:5:20) = reshape(metrics_long_forced(5,10,:,:),[10 4]);
% arrival(:,3:5:20) = reshape(metrics_long_forced_right(5,10,:,:),[10 4]);
arrival(:,2:3:12) = reshape(metrics_long_torque_acw(5,10,:,:),[10 4]);
arrival(:,3:3:12) = reshape(metrics_long_torque_cw(5,10,:,:),[10 4]);

absolute_arrival = abs(arrival);

feedback_types = ["18°", "36°", "180°", "None"];
%% Plotting

figure(7)
boxplot(velocity, {reshape(repmat(feedback_types,3,1),12,1) repmat(exp_types',4,1)} ,'factorgap',12,'color','brk');
title("Effect of Applying Torque on Hexapods Y-Direction Velocity");
xlabel("Orientation Feedback Type and Force Type");
ylabel('Y-Direction Velocity (m/s)');


%%
figure(8)
boxplot(divergence, {reshape(repmat(feedback_types,3,1),12,1) repmat(exp_types',4,1)} ,'factorgap',12,'color','brk');
xlabel("Orientation Feedback Type and Force Type");
ylabel('Rate of Divergence (degree/s)');
title("Effect of Applying Torque on Hexapods Rate of Divergence");
%%
figure(11)
boxplot(arrival, {reshape(repmat(feedback_types,3,1),12,1) repmat(exp_types',4,1)} ,'factorgap',12,'color','brk');
title("Effect of Applying Torque on Hexapods Arival Angle");
ylabel("Arrival Angle (degrees)");
xlabel("Orientation Feedback Type and Run Duration");

%%
figure(12)
boxplot(absolute_arrival, {reshape(repmat(feedback_types,3,1),12,1) repmat(exp_types',4,1)} ,'factorgap',12,'color','brk');
title("Effect of Applying Torque on Hexapods Arival Angle");
ylabel("Absolute Arrival Angle (degrees)");
xlabel("Orientation Feedback Type and Run Duration");
