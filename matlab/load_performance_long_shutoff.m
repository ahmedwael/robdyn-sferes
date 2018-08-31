close all;
%clear all;

feedback_types = ["18", "36", "180", "none"];

%% Loading Long Shutoff 
metrics_long_shutoff = zeros(5,10,10,3); %metric,generation, run, feedback type 
for f = 1:3
    for r = 0:9
        directory_name = strcat('orientfb_',feedback_types(f),'_',string(r),'/');
        for g = 1000:1000:10000
            filename = strcat('performance_metrics_long_shutoff_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_long_shutoff(:,g/1000,r+1,f) = filedata;
        end
    end
end


%% Plotting Performance

final_performance_long_shutoff = reshape(metrics_long_shutoff(1,10,:,:),[10 3]);
figure(3)
boxplot(final_performance_long_shutoff,'Labels', feedback_types);
title("Performance (15s) of Final Generation with Shutoff");
ylabel("Meters");
xlabel("Feedback Level");
 
%% Plotting Orientation

