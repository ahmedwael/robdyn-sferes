feedback_types = ["18", "36", "180", "none"];

metrics_short = zeros(6,10,9,4); %metric,generation, run, feedback type 
metrics_long = zeros(6,10,9,4); %metric,generation, run, feedback type 
for f = 1:4
    for r = 0:9
        directory_name = strcat('orientfb_',feedback_types(f),'/orientfb_',feedback_types(f),'_',string(r),'/');
        for g = 10000:10000%:10000
            filename = strcat('performance_metrics_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_short(:,g/1000,r+1,f) = filedata;
            filename = strcat('performance_metrics_long_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_long(:,g/1000,r+1,f) = filedata;
        end
    end
end
feedback_types = ["18°", "36°", "180°", "None"];
exp_types = ["5 s", "15 s"];
%% Loading

velocity = zeros(10, 8);
velocity(:,1:2:8) = reshape((metrics_short(1,10,:,:)+25)/5,[10 4]);
velocity(:,2:2:8) = reshape((metrics_long(1,10,:,:)+25)/15,[10 4]);


divergence = zeros(10, 8);
divergence(:,1:2:8) = reshape(abs(metrics_short(2,10,:,:))/5,[10 4]);
divergence(:,2:2:8) = reshape(abs(metrics_long(2,10,:,:))/15,[10 4]);

arrival = zeros(10, 8);
arrival(:,1:2:8) = reshape(metrics_short(5,10,:,:),[10 4]);
arrival(:,2:2:8) = reshape(metrics_long(5,10,:,:),[10 4]);

absolute_arrival = abs(arrival);
% divergence_modified = zeros(9, 4);
% divergence_modified = reshape(abs(metrics_short(2,10,:,:))/5,[10 4]);


%% Plotting

figure(3)
boxplot(velocity, {reshape(repmat(feedback_types,2,1),8,1) repmat(exp_types',4,1)} ,'factorgap',8,'color','br');
title("Forward Velocity of Final Generation 5vs15 s");
ylabel("Forward Velocity (m/s)");
xlabel("Orientation Feedback Type and Run Duration");


%%
figure(4)
boxplot(divergence, {reshape(repmat(feedback_types,2,1),8,1) repmat(exp_types',4,1)} ,'factorgap',8,'color','br');
title("Rate of Divergence of Final Generation 5vs15 s");
ylabel("Rate of Divergence (degrees/sec)");
xlabel("Orientation Feedback Type and Run Duration");

%%
figure(10)
boxplot(arrival, {reshape(repmat(feedback_types,2,1),8,1) repmat(exp_types',4,1)} ,'factorgap',8,'color','br');
title("Arrival Angle of Final Generation 5vs15 s");
ylabel("Arrival Angle (degrees)");
xlabel("Orientation Feedback Type and Run Duration");

%%
figure(20)
boxplot(absolute_arrival, {reshape(repmat(feedback_types,2,1),8,1) repmat(exp_types',4,1)} ,'factorgap',8,'color','br');
title("Absolute Arrival Angle of Final Generation 5vs15 s");
ylabel("Absolute Arrival Angle (degrees)");
xlabel("Orientation Feedback Type and Run Duration");