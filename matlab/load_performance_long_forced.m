close all;
%clear all;

feedback_types = ["18", "36", "180", "none"];
%% Loading Long Forced 
metrics_long_forced = zeros(5,10,10,4); %metric,generation, run, feedback type 
for f = 1:1
    for r = 0:9
        directory_name = strcat('orientfb_',feedback_types(f),'_',string(r),'/');
        for g = 1000:1000:10000
            filename = strcat('performance_metrics_long_forced_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_long_forced(:,g/1000,r+1,f) = filedata;
        end
    end
end

%% Plotting Performance


final_performance_long_forced = reshape(metrics_long_forced(1,10,:,:),[10 4]);
figure(5)
boxplot(final_performance_long_shutoff,'Labels', feedback_types);
title("Performance (15s) of Final Generation with Applied Force");
ylabel("Meters");
xlabel("Feedback Level");




%% Plotting Orientation

% final_orientation_short = reshape(abs(metrics_short(2,10,:,:)),[10 4]);
% figure(11)
% boxplot(final_orientation_short,'Labels', feedback_types);
% title("Orientation Error of Final Generation");
% ylabel("Degrees");
% xlabel("Feedback Level");
% 
% final_orientation_long = reshape(abs(metrics_long(2,10,:,:)),[10 4]);
% figure(12)
% boxplot(final_orientation_long,'Labels', feedback_types);
% title("Orientation Error (15s) of Final Generation");
% ylabel("Degrees");
% xlabel("Feedback Level");