feedback_types = ["18", "36", "180", "none"];

metrics_short = zeros(5,10,10,4); %metric,generation, run, feedback type 
for f = 1:4
    for r = 0:9
        directory_name = strcat('orientfb_',feedback_types(f),'/orientfb_',feedback_types(f),'_',string(r),'/');
        for g = 1000:1000:10000
            filename = strcat('performance_metrics_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_short(:,g/1000,r+1,f) = filedata;
        end
    end
end
feedback_types = ["18°", "36°", "180°", "None"];
%% Plotting Performance

final_performance_short = reshape((metrics_short(1,10,:,:)+25)/5,[10 4]);
figure(1)
boxplot(final_performance_short,'Labels', feedback_types);
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
