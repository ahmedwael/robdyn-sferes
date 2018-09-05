program_types=["orientfb", "angled", "angled_pn", "torque"];
program_types_1=["orientfb", "angled", "angled_pn", "torque"];
feedback_types = ["18", "36", "180", "none"];
metrics = zeros(12,2,10,3); %metric,program, run, feedback type 
for p = 2:3
    for f = 1:3
        for r = 0:9
            directory_name = strcat(program_types(p),'/',program_types(p),'_',feedback_types(f),'/',program_types(p),'_',feedback_types(f),'_',string(r),'/');
                filename = strcat('performance_metrics_angled_60_pn_', feedback_types(f),'_', string(r),'.dat');
                fullname = fullfile(directory_name, filename);
                filedata = load(fullname);
                metrics(:,p-1,r+1,f) = filedata;
        end
    end
end
%%
metrics_both_left= reshape(metrics(1,2,:,:),[30 1])+25;
metrics_both_right= reshape(metrics(7,2,:,:),[30 1])+25;
metrics_rand_left= reshape(metrics(1,1,:,:),[30 1])+25;
metrics_rand_right= reshape(metrics(7,1,:,:),[30 1])+25;

metrics_both_best = max(metrics_both_left,metrics_both_right)/5;
metrics_rand_best = max(metrics_rand_left,metrics_rand_right)/5;

metrics_both_worst = min(metrics_both_left,metrics_both_right)/5;
metrics_rand_worst = min(metrics_rand_left,metrics_rand_right)/5;

percentage_diff_both = (metrics_both_best - metrics_both_worst)./metrics_both_best;
mean(percentage_diff_both)*100;
percentage_diff_rand = (metrics_rand_best - metrics_rand_worst)./metrics_rand_best;
mean(percentage_diff_rand)*100;
median(metrics_both_worst)
median(metrics_both_best)
% 
median(metrics_rand_worst);
median(metrics_rand_best);
% ;
% [x,h,stats] = ranksum(metrics_rand_worst',metrics_rand_best','alpha',0.05,...
% 'tail','left','method','approximate')
% 
% [x,h,stats] = ranksum(metrics_both_worst',metrics_both_best','alpha',0.05,...
% 'tail','left','method','approximate')
% % a = metrics_rand_worst;
% % b =metrics_rand_best;
% % [x,tbl,stats] = kruskalwallis([a,b])
% % 
% % c = metrics_both_worst;
% % d =metrics_both_best;
% % [y,tblz,statsz] = kruskalwallis([c,d])