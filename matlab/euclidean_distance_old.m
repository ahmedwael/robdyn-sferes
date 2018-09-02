%% Loading Trajectories of Short

close all;
clear all;
metrics_long = zeros(6,10,10,3); %metric,generation, run, feedback type
normalized_distance_shutoff = zeros(3,10);
normalized_distance_bias30_acw = zeros(3,10);
normalized_distance_bias30_cw = zeros(3,10);
regular_distance_shutoff = zeros(3,10);
regular_distance_bias30_acw = zeros(3,10);
regular_distance_bias30_cw = zeros(3,10);

feedback_types = ["18", "36", "180"];
exp_types = ["Shutoff", "Bias ACW", "Bias CW"];
g = 10000;
for f = 1:3
    for r = 0:9
        directory_name = strcat('orientfb_',feedback_types(f),'/orientfb_',feedback_types(f),'_',string(r),'/');
        filename = strcat('traj_simu_long_', feedback_types(f),'_', string(r),'_', string(g),'.txt');
        fullname = fullfile(directory_name, filename);
        trajdatalong = load(fullname);
        
        filename = strcat('traj_simu_long_shutoff_', feedback_types(f),'_', string(r),'_', string(g),'.txt');
        fullname = fullfile(directory_name, filename);
        trajdatalongshutoff = load(fullname);

        filename = strcat('traj_simu_long_forced_', feedback_types(f),'_', string(r),'_', string(g),'.txt');
        fullname = fullfile(directory_name, filename);
        trajdatalongforced = load(fullname);

        filename = strcat('traj_simu_long_bias_30_', feedback_types(f),'_', string(r),'_', string(g),'.txt');
        fullname = fullfile(directory_name, filename);
        trajdatalongbias30_acw = load(fullname);

        filename = strcat('traj_simu_long_bias_30n_', feedback_types(f),'_', string(r),'_', string(g),'.txt');
        fullname = fullfile(directory_name, filename);
        trajdatalongbias30_cw = load(fullname);
        

        filename = strcat('performance_metrics_long_', feedback_types(f),'_', string(r),'_', string(g),'.dat');
        fullname = fullfile(directory_name, filename);
        filedata = load(fullname);
        metrics_long(:,g/1000,r+1,f) = filedata;
        normalizer = metrics_long(1,10,r+1,f)+25 ;

        dist_shutoff = sqrt((trajdatalong(:,1)-trajdatalongshutoff(:,1)).^2 + (trajdatalong(:,2)-trajdatalongshutoff(:,2)).^2);            
        normalized_distance_shutoff(f,r+1) = sum(dist_shutoff)/normalizer^2;
        regular_distance_shutoff(f,r+1) = sum(dist_shutoff);

        dist_bias30_acw = sqrt((trajdatalong(:,1)-trajdatalongbias30_acw(:,1)).^2 + (trajdatalong(:,2)-trajdatalongbias30_acw(:,2)).^2);            
        normalized_distance_bias30_acw(f,r+1) = sum(dist_bias30_acw)/normalizer^2;
        regular_distance_bias30_acw(f,r+1) = sum(dist_bias30_acw);

        dist_bias30_cw = sqrt((trajdatalong(:,1)-trajdatalongbias30_cw(:,1)).^2 + (trajdatalong(:,2)-trajdatalongbias30_cw(:,2)).^2);            
        normalized_distance_bias30_cw(f,r+1) = sum(dist_bias30_cw)/normalizer^2;
        regular_distance_bias30_cw(f,r+1) = sum(dist_bias30_cw);
        
    end
end
%%
nd_18 = [normalized_distance_shutoff(1,:); normalized_distance_bias30_acw(1,:); normalized_distance_bias30_cw(1,:)];
nd_36 = [normalized_distance_shutoff(2,:); normalized_distance_bias30_acw(2,:); normalized_distance_bias30_cw(2,:)];
nd_180 = [normalized_distance_shutoff(3,:); normalized_distance_bias30_acw(3,:); normalized_distance_bias30_cw(3,:)];
rd_18 = [regular_distance_shutoff(1,:); regular_distance_bias30_acw(1,:); regular_distance_bias30_cw(1,:)];
rd_36 = [regular_distance_shutoff(2,:); regular_distance_bias30_acw(2,:); regular_distance_bias30_cw(2,:)];
rd_180 = [regular_distance_shutoff(3,:); regular_distance_bias30_acw(3,:); regular_distance_bias30_cw(3,:)];
%%
figure(1)
% subplot(3,1,1)
bar(nd_18');
legend(exp_types);
ylabel("Normalized Sum of Euclidean Distance (m)");
xlabel("Experiment Run");
title("Difference in Trajectories Based on Orientation Feedback Modification (OFB 18)");
ylim([0 300]);
savefig("Euclid_18");    

figure(2)
% subplot(3,1,2)
bar(nd_36');
legend(exp_types);
ylabel("Normalized Sum of Euclidean Distance (m)");
xlabel("Experiment Run");
title("Difference in Trajectories Based on Orientation Feedback Modification (OFB 36)");
ylim([0 300]);
savefig("Euclid_36");

figure(3)
% subplot(3,1,3)
bar(nd_180');
legend(exp_types);
ylabel("Normalized Sum of Euclidean Distance (m)");
xlabel("Experiment Run");
title("Difference in Trajectories Based on Orientation Feedback Modification (OFB 180)");
ylim([0 300]);
savefig("Euclid_180");

%%
mean_dist = [mean(mean(nd_18)); mean(mean(nd_36)); mean(mean(nd_180))];
figure(4)
bar(mean_dist);
set(gca, 'XTickLabel',feedback_types, 'XTick',1:numel(feedback_types))
% legend(exp_types);
ylabel("Average Normalized Sum of Euclidean Distance (m)");
xlabel("Feedback Type");
title("Significance of Orientation Feedback Input");
savefig("Euclid_average");