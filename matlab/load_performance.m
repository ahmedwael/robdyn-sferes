close all;
%clear all;

feedback_types = ["18", "36", "180", "none"];
%% Loading Metrics Short
metrics_short = zeros(5,10,10,4); %metric,generation, run, feedback type 
for f = 1:1
    for r = 0:9
        directory_name = strcat('orientfb_',feedback_types(f),'_',string(r),'/');
        for g = 1000:1000:10000
            filename = strcat('performance_metrics_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_short(:,g/1000,r+1,f) = filedata;
        end
    end
end

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

%% Loading Long Shutoff 
metrics_long_shutoff = zeros(5,10,10,3); %metric,generation, run, feedback type 
for f = 1:1
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

%% Loading Long Bias 30 
metrics_long_bias30 = zeros(5,10,10,3); %metric,generation, run, feedback type 
for f = 1:1
    for r = 0:9
        directory_name = strcat('orientfb_',feedback_types(f),'_',string(r),'/');
        for g = 1000:1000:10000
            filename = strcat('performance_metrics_long_bias_30_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_long_bias30(:,g/1000,r+1,f) = filedata;
        end
    end
end

%% Loading Long Forced 
metrics_long_forced = zeros(5,10,10,3); %metric,generation, run, feedback type 
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

final_performance_short = reshape(metrics_short(1,10,:,:),[10 4]);
figure(1)
boxplot(final_performance_short,'Labels', feedback_types);
title("Performance of Final Generation");
ylabel("Meters");
xlabel("Feedback Level");

final_performance_long = reshape(metrics_long(1,10,:,:),[10 4]);
figure(2)
boxplot(final_performance_long,'Labels', feedback_types);
title("Performance (15s) of Final Generation");
ylabel("Meters");
xlabel("Feedback Level");

% final_performance_long_shutoff = reshape(metrics_long_shutoff(1,10,:,:),[10 3]);
% figure(3)
% boxplot(final_performance_long_shutoff,'Labels', feedback_types);
% title("Performance (15s) of Final Generation with Shutoff");
% ylabel("Meters");
% xlabel("Feedback Level");
% 
% final_performance_long_bias30 = reshape(metrics_long_bias30(1,10,:,:),[10 3]);
% figure(4)
% boxplot(final_performance_long_30,'Labels', feedback_types);
% title("Performance (15s) of Final Generation with 30 Degree Bias");
% ylabel("Meters");
% xlabel("Feedback Level");
% 
% final_performance_long_forced = reshape(metrics_long_forced(1,10,:,:),[10 3]);
% figure(5)
% boxplot(final_performance_long_shutoff,'Labels', feedback_types);
% title("Performance (15s) of Final Generation with Applied Force");
% ylabel("Meters");
% xlabel("Feedback Level");




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