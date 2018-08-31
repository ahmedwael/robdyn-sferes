close all;
%clear all;

feedback_types = ["18", "36", "180"];%, "none"];
exp_types = ["None", "B ACW", "B CW", "ShutOff"];

metrics_long = zeros(6,10,10,3); %metric,generation, run, feedback type 
metrics_long_shutoff = zeros(6,10,10,3); %metric,generation, run, feedback type
metrics_long_bias30_acw= zeros(6,10,10,3); %metric,generation, run, feedback type
metrics_long_bias30_cw= zeros(6,10,10,3); %metric,generation, run, feedback type 
for f = 1:3
    for r = 0:9
        directory_name = strcat('orientfb_',feedback_types(f),'/orientfb_',feedback_types(f),'_',string(r),'/');
        for g = 10000:10000%:10000            
            filename = strcat('performance_metrics_long_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_long(:,g/1000,r+1,f) = filedata;
            
            filename = strcat('performance_metrics_long_bias_30_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_long_bias30_acw(:,g/1000,r+1,f) = filedata;
            
            filename = strcat('performance_metrics_long_bias_30n_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_long_bias30_cw(:,g/1000,r+1,f) = filedata;
            
            filename = strcat('performance_metrics_long_shutoff_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_long_shutoff(:,g/1000,r+1,f) = filedata;
        end
    end
end
feedback_types = ["18°", "36°", "180°"];
velocity = zeros(10,12);
velocity(:,1:4:12) = reshape((metrics_long(1,10,:,:)+25)/15,[10 3]);
velocity(:,2:4:12) = reshape((metrics_long_bias30_acw(1,10,:,:)+25)/15,[10 3]);
velocity(:,3:4:12) = reshape((metrics_long_bias30_cw(1,10,:,:)+25)/15,[10 3]);
velocity(:,4:4:12) = reshape((metrics_long_shutoff(1,10,:,:)+25)/15,[10 3]);

divergence = zeros(10, 12);
divergence(:,1:4:12) = reshape(abs(metrics_long(2,10,:,:))/15,[10 3]);
divergence(:,2:4:12) = reshape(abs(metrics_long_bias30_acw(2,10,:,:))/15,[10 3]);
divergence(:,3:4:12) = reshape(abs(metrics_long_bias30_cw(2,10,:,:))/15,[10 3]);
divergence(:,4:4:12) = reshape(abs(metrics_long_shutoff(2,10,:,:))/15,[10 3]);

arrival = zeros(10, 12);
arrival(:,1:4:12) = reshape(metrics_long(5,10,:,:),[10 3]);
arrival(:,2:4:12) = reshape(metrics_long_bias30_acw(5,10,:,:),[10 3]);
arrival(:,3:4:12) = reshape(metrics_long_bias30_cw(5,10,:,:),[10 3]);
arrival(:,4:4:12) = reshape(metrics_long_shutoff(5,10,:,:),[10 3]);

absolute_arrival = abs(arrival);

%% Plotting

figure(5)
boxplot(velocity, {reshape(repmat(feedback_types,4,1),12,1) repmat(exp_types',3,1)} ,'color','brkg');
title("Significance of Orientation Feedback as Input to Velocity");
xlabel("Feedback Type and Test");
ylabel('Y-Direction Velocity (m/s)');


%%
figure(6)
boxplot(divergence, {reshape(repmat(feedback_types,4,1),12,1) repmat(exp_types',3,1)} ,'color','brkg');
title("Significance of Orientation Feedback as Input to Divergence");
xlabel("Feedback Type and Test");
ylabel('Rate of Divergence (degree/s)');

%%
figure(13)
boxplot(arrival, {reshape(repmat(feedback_types,4,1),12,1) repmat(exp_types',3,1)} ,'color','brkg');
title("Significance of Orientation Feedback as Input to Arrival Angle");
xlabel("Feedback Type and Test");
ylabel('Arrival Angle (degrees)');

%%
figure(21)
boxplot(absolute_arrival, {reshape(repmat(feedback_types,4,1),12,1) repmat(exp_types',3,1)} ,'color','brkg');
title("Significance of Orientation Feedback as Input to Absolute Arrival Angle");
xlabel("Feedback Type and Test");
ylabel('Absolute Arrival Angle (degrees)');