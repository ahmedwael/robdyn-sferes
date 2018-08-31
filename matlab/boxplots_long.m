close all;
%clear all;

feedback_types = ["18", "36", "180", "none"];
%% Loading Metrics Long 
metrics_long = zeros(5,10,10,4); %metric,generation, run, feedback type 
metrics_long_shutoff = zeros(5,10,10,4); %metric,generation, run, feedback type 
metrics_long_bias30 = zeros(5,10,10,4); %metric,generation, run, feedback type 
metrics_long_forced = zeros(5,10,10,4); %metric,generation, run, feedback type 
for f = 1:4
    for r = 0:9
        directory_name = strcat('orientfb_',feedback_types(f),'_',string(r),'/');
        for g = 1000:1000:10000
            
            filename = strcat('performance_metrics_long_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_long(:,g/1000,r+1,f) = filedata;
            
            filename = strcat('performance_metrics_long_forced_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_long_forced(:,g/1000,r+1,f) = filedata;
            
            if f < 4
            
            filename = strcat('performance_metrics_long_shutoff_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_long_shutoff(:,g/1000,r+1,f) = filedata;
            
%             filename = strcat('performance_metrics_long_bias_30_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
%             fullname = fullfile(directory_name, filename);
%             filedata = load(fullname);
%             metrics_long_bias30(:,g/1000,r+1,f) = filedata;            
            
            else
                metrics_long_shutoff(:,g/1000,r+1,f) = NaN(5,10,10);
%                 metrics_long_bias30(:,g/1000,r+1,f) = NaN(5,10,10);     
            end
        end
    end
end



