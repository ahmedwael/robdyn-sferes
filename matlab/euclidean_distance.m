%% Loading Trajectories of Short

close all;
clear all;
metrics_long = zeros(6,10,10,3); %metric,generation, run, feedback type
program_types=["orientfb", "angled", "angled_pn", "torque"];
p=1;
normalized_distance_shutoff = zeros(3,10);
normalized_distance_bias30_acw = zeros(3,10);
normalized_distance_bias30_cw = zeros(3,10);
regular_distance_shutoff = zeros(3,10);
regular_distance_bias30_acw = zeros(3,10);
regular_distance_bias30_cw = zeros(3,10);

trajdatalong = zeros(1000,3);
trajdatalongshutoff = zeros(1000,3);
trajdatalongbias30_acw = zeros(1000,3);
trajdatalongbias30_cw = zeros(1000,3);
feedback_types = ["18", "36", "180"];
exp_types = ["Shutoff", "Bias ACW", "Bias CW"];
g = 10000;
for f = 1:3
    for r = 0:9
        directory_name = strcat(program_types(p),'/',program_types(p),'_',feedback_types(f),'/',program_types(p),'_',feedback_types(f),'_',string(r),'/');
        filename = strcat('traj_simu_1_long_', feedback_types(f),'_', string(r),'.txt');
        fullname = fullfile(directory_name, filename);
        data = load(fullname);
        trajdatalong(1:size(data,1),:) = data;        
        trajdatalong(size(data,1):end,:) = repmat(data(end,:),1001-size(data,1),1);        
        
        filename = strcat('traj_simu_1_long_shutoff_', feedback_types(f),'_', string(r),'.txt');
        fullname = fullfile(directory_name, filename);
        data = load(fullname);
%         test = size(data,1);
        trajdatalongshutoff(1:size(data,1),:) = data;        
        trajdatalongshutoff(size(data,1):end,:) = repmat(data(end,:),1001-size(data,1),1);        


        filename = strcat('traj_simu_1_long_bias_30_', feedback_types(f),'_', string(r),'.txt');
        fullname = fullfile(directory_name, filename);
        data = load(fullname);
%         test = size(data,1);
        trajdatalongbias30_acw(1:size(data,1),:) = data;
        trajdatalongbias30_acw(size(data,1):end,:) = repmat(data(end,:),1001-size(data,1),1);

        filename = strcat('traj_simu_1_long_bias_30_negative_', feedback_types(f),'_', string(r),'.txt');
        fullname = fullfile(directory_name, filename);
        data = load(fullname);
%         test = size(data,1);
        trajdatalongbias30_cw(1:size(data,1),:) = data;
        trajdatalongbias30_cw(size(data,1):end,:) = repmat(data(end,:),1001-size(data,1),1);
        

        filename = strcat('performance_metrics_long_', feedback_types(f),'_', string(r),'.dat');
        fullname = fullfile(directory_name, filename);
        filedata = load(fullname);
        metrics_long(:,g/1000,r+1,f) = filedata;
        normalizer = metrics_long(1,10,r+1,f)+25 ;
%         normalizer = normalizer*1000;

        dist_shutoff = sqrt((trajdatalong(:,1)-trajdatalongshutoff(:,1)).^2 + (trajdatalong(:,2)-trajdatalongshutoff(:,2)).^2);            
        normalized_distance_shutoff(f,r+1) = sum(dist_shutoff)/normalizer^2;
%         regular_distance_shutoff(f,r+1) = sum(dist_shutoff);

        dist_bias30_acw = sqrt((trajdatalong(:,1)-trajdatalongbias30_acw(:,1)).^2 + (trajdatalong(:,2)-trajdatalongbias30_acw(:,2)).^2);            
        normalized_distance_bias30_acw(f,r+1) = sum(dist_bias30_acw)/normalizer^2;
%         regular_distance_bias30_acw(f,r+1) = sum(dist_bias30_acw);

        dist_bias30_cw = sqrt((trajdatalong(:,1)-trajdatalongbias30_cw(:,1)).^2 + (trajdatalong(:,2)-trajdatalongbias30_cw(:,2)).^2);            
        normalized_distance_bias30_cw(f,r+1) = sum(dist_bias30_cw)/normalizer^2;
%         regular_distance_bias30_cw(f,r+1) = sum(dist_bias30_cw);
        
    end
end
%%
nd_18 = [normalized_distance_shutoff(1,:); normalized_distance_bias30_acw(1,:); normalized_distance_bias30_cw(1,:)];
nd_36 = [normalized_distance_shutoff(2,:); normalized_distance_bias30_acw(2,:); normalized_distance_bias30_cw(2,:)];
nd_180 = [normalized_distance_shutoff(3,:); normalized_distance_bias30_acw(3,:); normalized_distance_bias30_cw(3,:)];
nd_18 = nd_18 /1000;
nd_36 = nd_36 /1000;
nd_180 = nd_180/1000;
% rd_18 = [regular_distance_shutoff(1,:); regular_distance_bias30_acw(1,:); regular_distance_bias30_cw(1,:)];
% rd_36 = [regular_distance_shutoff(2,:); regular_distance_bias30_acw(2,:); regular_distance_bias30_cw(2,:)];
% rd_180 = [regular_distance_shutoff(3,:); regular_distance_bias30_acw(3,:); regular_distance_bias30_cw(3,:)];
%%
figure(1)
% subplot(3,1,1)
bar(nd_18');
legend(exp_types);
ylabel("Normalized Sum of Euclidean Distance (m)");
xlabel("Experiment Run");
title("Difference in Trajectories Based on Orientation Feedback Modification (OFB 18)");
% ylim([0 300]);
% savefig("Euclid_18");    

figure(2)
% subplot(3,1,2)
bar(nd_36');
legend(exp_types);
ylabel("Normalized Sum of Euclidean Distance (m)");
xlabel("Experiment Run");
title("Difference in Trajectories Based on Orientation Feedback Modification (OFB 36)");
% ylim([0 300]);
% savefig("Euclid_36");

figure(3)
% subplot(3,1,3)
bar(nd_180');
legend(exp_types);
ylabel("Normalized Sum of Euclidean Distance (m)");
xlabel("Experiment Run");
title("Difference in Trajectories Based on Orientation Feedback Modification (OFB 180)");
% ylim([0 300]);
% savefig("Euclid_180");

%%
mean_dist = [mean(mean(nd_18)); mean(mean(nd_36)); mean(mean(nd_180))];
figure(4)
bar(mean_dist);
set(gca, 'XTickLabel',feedback_types, 'XTick',1:numel(feedback_types))
% legend(exp_types);
ylabel("Average Normalized Sum of Euclidean Distance (m)");
xlabel("Feedback Type");
title("Significance of Orientation Feedback Input");
% savefig("Euclid_average");
%%
close all
mean_dist_new = [mean(nd_18); mean(nd_36); mean(nd_180)];
figure(5)
boxplot(mean_dist_new','Labels', feedback_types);
ylabel("Average Normalized Sum of Euclidean Distance (m)");
xlabel("Feedback Type");
title("Significance of Orientation Feedback Input");
hold on
grid on
plot(1,mean_dist_new(1,:)', 'o');
plot(2,mean_dist_new(2,:)', 'o');
plot(3,mean_dist_new(3,:)', 'o');
set(gca,'ylim',[0 5]);
% scatter([18 36 180], mean_dist_new(1,:)');