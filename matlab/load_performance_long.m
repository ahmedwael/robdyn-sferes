close all;
%clear all;

feedback_types = ["18", "36", "180", "none"];
%% Loading Metrics Long 
metrics_long = zeros(5,10,10,4); %metric,generation, run, feedback type 
for f = 1:4
    for r = 0:9
        directory_name = strcat('orientfb_',feedback_types(f),'_',string(r),'/');
        for g = 1000:1000:10000
            filename = strcat('performance_metrics_long_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_long(:,g/1000,r+1,f) = filedata;
        end
    end
end

%% Plotting Performance
final_performance_long = reshape(metrics_long(1,10,:,:)+25,[10 4]);
figure(2)
boxplot(final_performance_long,'Labels', feedback_types);
title("Performance (15s) of Final Generation");
ylabel("Meters");
xlabel("Feedback Level");

%% Plotting Orientation

final_orientation_long = reshape(abs(metrics_long(2,10,:,:)),[10 4]);
figure(12)
boxplot(final_orientation_long,'Labels', feedback_types);
title("Orientation Error (15s) of Final Generation");
ylabel("Degrees");
xlabel("Feedback Level");