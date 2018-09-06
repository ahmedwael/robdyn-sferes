program_types=["orientfb", "angled", "angled_pn", "torque"];
feedback_types = ["18", "36", "180", "none"];
metrics_long = zeros(6,10,4); %metric,program, run, feedback type 
metrics_pn_long = zeros(12,10,4); %metric,program, run, feedback type 
% metrics_pn_torque = zeros(6,10,4); %metric,program, run, feedback type 
% metrics_pn_torque_n = zeros(6,10,4); %metric,program, run, feedback type 
metrics_torque = zeros(6,10,4); %metric,program, run, feedback type 
metrics_torque_n = zeros(6,10,4); %metric,program, run, feedback type 
metrics_pn_torque = zeros(12,10,4); %metric,program, run, feedback type 
metrics_pn_torque_n = zeros(12,10,4); %metric,program, run, feedback type 

p_end=[4,3,3,4];
%%
p_end=[4,3,3,4];
for p = 1:4
for f = 1:p_end(p)
    for r = 0:9
            directory_name = strcat(program_types(p),'/',program_types(p),'_',feedback_types(f),'/',program_types(p),'_',feedback_types(f),'_',string(r),'/');
            filename = strcat('performance_metrics_long_', feedback_types(f),'_', string(r),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_long(:,r+1,f) = filedata;
            
%             filename = strcat('performance_metrics_long_forced_', feedback_types(f),'_', string(r),'.dat');
%             fullname = fullfile(directory_name, filename);
%             filedata = load(fullname);
%             metrics_forced(:,r+1,f) = filedata;
% %             
%             filename = strcat('performance_metrics_long_forced_negative_', feedback_types(f),'_', string(r),'.dat');
%             fullname = fullfile(directory_name, filename);
%             filedata = load(fullname);
%             metrics_forced_n(:,r+1,f) = filedata;
            
            filename = strcat('performance_metrics_long_torque_', feedback_types(f),'_', string(r),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_torque(:,r+1,f) = filedata;
            
            filename = strcat('performance_metrics_long_torque_negative_', feedback_types(f),'_', string(r),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_torque_n(:,r+1,f) = filedata;
            
            if  (p ==2 || p==3)
                
            filename = strcat('performance_metrics_angled_60_pn_long_', feedback_types(f),'_', string(r),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_pn_long(:,r+1,f) = filedata;
            
            filename = strcat('performance_metrics_angled_60_pn_long_torque_', feedback_types(f),'_', string(r),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_pn_torque(:,r+1,f) = filedata;
            
            filename = strcat('performance_metrics_angled_60_pn_long_torque_negative_', feedback_types(f),'_', string(r),'.dat');
            fullname = fullfile(directory_name, filename);
            filedata = load(fullname);
            metrics_pn_torque_n(:,r+1,f) = filedata;
            
            end
            
                                   
            save(strcat('robust_',program_types(p),'.mat'),'metrics_long','metrics_torque','metrics_torque_n','metrics_pn_torque','metrics_pn_torque_n');
    end
end
end
%%
p_end=[4,3,3,4];
close all
program_types_nice=["OFB and BL", "MD-R", "MD-B", "PERT"];
stats = zeros(10,8);
for p = 1:4
    
load(strcat('robust_',program_types(p),'.mat'));

metrics_long(metrics_long < -900) = NaN;
metrics_torque(metrics_torque < -900) = NaN;
metrics_torque_n(metrics_torque_n < -900) = NaN;
metrics_pn_torque(metrics_pn_torque < -900) = NaN;
metrics_pn_torque_n(metrics_pn_torque_n < -900) = NaN;



arrival_long = reshape(metrics_long(5,:,:),[10 4]);
arrival_torque = reshape(metrics_torque(5,:,:),[10 4]);
arrival_torque_n = reshape(metrics_torque_n(5,:,:),[10 4]);

arrival_pn_long_1 = reshape(metrics_pn_long(5,:,:),[10 4]);
arrival_pn_long_2 = reshape(metrics_pn_long(11,:,:),[10 4]);

arrival_pn_torque_1 = reshape(metrics_pn_torque(5,:,:),[10 4]);
arrival_pn_torque_n_1 = reshape(metrics_pn_torque_n(5,:,:),[10 4]);

arrival_pn_torque_2 = reshape(metrics_pn_torque(11,:,:),[10 4]);
arrival_pn_torque_n_2 = reshape(metrics_pn_torque_n(11,:,:),[10 4]);

if (p == 2 || p ==3)
    arrival_long = max(arrival_pn_long_1,arrival_pn_long_2);
    arrival_torque = max(arrival_pn_torque_1,arrival_pn_torque_2);
    arrival_torque_n = max(arrival_pn_torque_n_1,arrival_pn_torque_n_2);
end
% metrics_long(metrics_long < -25) = -25;
% metrics_torque(metrics_torque < -25) = -25;
% metrics_torque_n(metrics_torque_n < -25) = -25;
% metrics_forced(metrics_forced < -25) = -25;
% metrics_forced_n(metrics_forced_n < -25) = -25;

% velocity_long = reshape((metrics_long(1,:,:)+25)/15,[10 4]);
% velocity_torque = reshape((metrics_torque(1,:,:)+25)/15,[10 4]);
% velocity_torque_n = reshape((metrics_torque_n(1,:,:)+25)/15,[10 4]);
% velocity_forced = reshape((metrics_forced(1,:,:)+25)/15,[10 4]);
% velocity_forced_n = reshape((metrics_forced_n(1,:,:)+25)/15,[10 4]);


% arrival_change = abs(arrival_long - arrival_torque) + abs(arrival_long - arrival_torque_n) + abs(arrival_long - arrival_forced) + abs(arrival_long - arrival_forced_n);
arrival_change = abs(arrival_long - arrival_torque) + abs(arrival_long - arrival_torque_n);
% arrival_change_2 = abs(arrival_long - arrival_bias_cw);
% arrival_change_3 = abs(arrival_long - arrival_bias_acw);
arrival_change = arrival_change/2;

% velocity_new = velocity_torque + velocity_torque_n;
% velocity_new = velocity_new/2;
% velocity_per_diff = (velocity_new./velocity_long)*100;


legend_types = ["18°", "36°", "180°", "NF"];
 
figure(p+10)
boxplot(arrival_change(:,1:p_end(p)), 'Labels', legend_types(1:p_end(p)));
hold on
% (rand(size(arrival_change(:,1)))-0.5)/3
% linspace(0.3,0.7,10)
scatter(ones(size(arrival_change(:,1))).*(1+linspace(-0.2,0.2,10)'),arrival_change(:,1),'b');
scatter(1+ones(size(arrival_change(:,1))).*(1+linspace(-0.2,0.2,10)'),arrival_change(:,2),'b');
scatter(2+ones(size(arrival_change(:,1))).*(1+linspace(-0.2,0.2,10)'),arrival_change(:,3),'b');
if p_end(p) == 4
scatter(3+ones(size(arrival_change(:,1))).*(1+linspace(-0.2,0.2,10)'),arrival_change(:,4),'b');
end
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
ylim([0 360]);
% print(strcat('boxrob_',program_types(p)),'-depsc2','-r300');
arrivalelse = vertcat(arrival_change(:,1),arrival_change(:,3),arrival_change(:,4));
[x,h,tbl] = ranksum(arrival_change(:,3),arrivalelse,'alpha',0.05,...
  'tail','left','method','approximate')
end

% figure(p+20)
% boxplot(velocity_per_diff(:,1:p_end(p)), 'Labels', legend_types(1:p_end(p)));
% hold on
% % (rand(size(arrival_change(:,1)))-0.5)/3
% % linspace(0.3,0.7,10)
% scatter(ones(size(arrival_change(:,1))).*(1+linspace(-0.2,0.2,10)'),velocity_per_diff(:,1),'b');
% scatter(1+ones(size(arrival_change(:,1))).*(1+linspace(-0.2,0.2,10)'),velocity_per_diff(:,2),'b');
% scatter(2+ones(size(arrival_change(:,1))).*(1+linspace(-0.2,0.2,10)'),velocity_per_diff(:,3),'b');
% if p_end(p) == 4
% scatter(3+ones(size(arrival_change(:,1))).*(1+linspace(-0.2,0.2,10)'),velocity_per_diff(:,4),'b');
% end
% pause(0.5)
% grid on
% set(gca,...
% 'Units','normalized',...
% 'FontWeight','normal',...
% 'FontSize',10.5);
% width = 3.25;     % Width in inches
% height = 2.5;    % Height in inches
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits', 'inches');
% papersize = get(gcf, 'PaperSize');
% left = (papersize(1)- width)/2;
% bottom = (papersize(2)- height)/2;
% myfiguresize = [left, bottom, width, height];
% set(gcf,'PaperPosition', myfiguresize);
% title(program_types_nice(p));
% ylabel("Perfomance Retained (%)");
% xlabel("Orientation Feedback Setting");
% ylim([0 150]);
% print(strcat('boxrobper_',program_types(p)),'-depsc2','-r300');
% end


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


