close all;
feedback_types = ["18", "36", "180", "baseline"];
program_types=["orientfb", "angled", "angled_pn", "torque"];
%% Loading Metrics Short
metrics_short = zeros(5,10,10,4); %metric,generation, run, feedback type 
p = 1;
for f = 1:4
    for r = 0:9
        directory_name = strcat(program_types(p),'/',program_types(p),'_',feedback_types(f),'/',program_types(p),'_',feedback_types(f),'_',string(r),'/');
        for g = 1000:1000:9000
            filename = strcat('performance_metrics_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_short(:,g/1000,r+1,f) = filedata;
        end
    end
end

%% Plotting Performance

generation_performance_short = reshape(metrics_short(1,:,1,1)+25,[10 1]);
figure(30)
plot(generation_performance_short);
title("Performance of Final Generation");
ylabel("Meters");
xlabel("Generations");
