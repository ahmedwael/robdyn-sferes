program_types=["orientfb", "angled", "angled_pn", "torque"];
feedback_types = ["18", "36", "180", "none"];
metrics_long = zeros(6,10,3); %metric,program, run, feedback type 
metrics_bias_cw = zeros(6,10,3); %metric,program, run, feedback type 
metrics_bias_acw = zeros(6,10,3); %metric,program, run, feedback type 
metrics_shutoff = zeros(6,10,3); %metric,program, run, feedback type 
%%
for p = 1:4
for f = 1:3
    for r = 0:9
            directory_name = strcat(program_types(p),'/',program_types(p),'_',feedback_types(f),'/',program_types(p),'_',feedback_types(f),'_',string(r),'/');
            filename = strcat('performance_metrics_long_', feedback_types(f),'_', string(r),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_long(:,r+1,f) = filedata;
            
            filename = strcat('performance_metrics_long_bias_30_', feedback_types(f),'_', string(r),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_bias_cw(:,r+1,f) = filedata;
            
            filename = strcat('performance_metrics_long_bias_30_negative_', feedback_types(f),'_', string(r),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_bias_acw(:,r+1,f) = filedata;
            
            filename = strcat('performance_metrics_long_shutoff_', feedback_types(f),'_', string(r),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_shutoff(:,r+1,f) = filedata;
                                   
            save(strcat('ofb_sig_',program_types(p),'.mat'),'metrics_long','metrics_bias_cw','metrics_bias_acw','metrics_shutoff');
    end
end
end
%%
close all
program_types_nice=["OFB and BL", "MD-R", "MD-B", "PERT"];
stats = zeros(10,8);
for p = 1:4
    
load(strcat('ofb_sig_',program_types(p),'.mat'));

metrics_long(metrics_long == - 1000) = -179;
metrics_shutoff(metrics_shutoff == - 1000) = -179;
metrics_bias_cw(metrics_bias_cw == - 1000) = -179;
metrics_bias_acw(metrics_bias_acw == - 1000) = -179;


arrival_long = reshape(metrics_long(5,:,:),[10 3]);
arrival_shutoff = reshape(metrics_shutoff(5,:,:),[10 3]);
arrival_bias_cw = reshape(metrics_bias_cw(5,:,:),[10 3]);
arrival_bias_acw = reshape(metrics_bias_acw(5,:,:),[10 3]);

arrival_change = abs(arrival_long - arrival_shutoff) + abs(arrival_long - arrival_bias_cw) + abs(arrival_long - arrival_bias_acw);
% arrival_change_2 = abs(arrival_long - arrival_bias_cw);
% arrival_change_3 = abs(arrival_long - arrival_bias_acw);

arrival_change = arrival_change/3;


legend_types = ["18°", "36°", "180°"];
 
figure(p+10)
boxplot(arrival_change, 'Labels', legend_types);
hold on
% (rand(size(arrival_change(:,1)))-0.5)/3
% linspace(0.3,0.7,10)
scatter(ones(size(arrival_change(:,1))).*(1+linspace(-0.2,0.2,10)'),arrival_change(:,1),'b');
scatter(1+ones(size(arrival_change(:,1))).*(1+linspace(-0.2,0.2,10)'),arrival_change(:,2),'b');
scatter(2+ones(size(arrival_change(:,1))).*(1+linspace(-0.2,0.2,10)'),arrival_change(:,3),'b');
pause(0.5)
grid on
set(gca,...
'Units','normalized',...
'FontWeight','normal',...
'FontSize',10.5);
width = 3.25;     % Width in inches
height = 2.5;    % Height in inches
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);
title(program_types_nice(p));
ylabel("Arrival Angle Change (°)");
xlabel("Orientation Feedback Setting");
ylim([0 180]);
print(strcat('boxsig_',program_types(p)),'-depsc2','-r300');
end
% 
% mean(mean(stats));
% mean(mean(stats(:,1:4)));
% mean(mean(stats(:,1:4)));
% mean(mean(stats(:,[4,8])));
% mean(mean(stats(:,[1,2,3,5,6,7])));
% median(median(stats(:,[4,8])));
% median(median(stats(:,[1,2,3,5,6,7])));
% numel(stats(stats <33.3))/80
% o = zeros(80,2);
% o(o == 0) = NaN;
% of= reshape(stats(:,[1,2,3,5,6,7]),[60 1])-10;
% nof = reshape(stats(:,[4,8]),[20,1]);
% [x,h,tbl] = ranksum(of,nof,'alpha',0.05,...
%   'tail','right','method','approximate')


