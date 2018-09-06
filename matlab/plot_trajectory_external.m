%% Loading Trajectories of Short

close all;
clear all;
program_types=["orientfb", "angled", "angled_pn", "torque"];
feedback_types = ["18", "36", "180", "none"];
for p = 1:1
for f = 1:1
    for r = 6:6 
        directory_name = strcat(program_types(p),'/',program_types(p),'_',feedback_types(f),'/',program_types(p),'_',feedback_types(f),'_',string(r),'/');
        for g = 10000:10000%:10000
            filename = strcat('traj_simu_1_long_', feedback_types(f),'_', string(r),'.txt');
            fullname = fullfile(directory_name, filename);
            trajdatalong = load(fullname);
%             filename = strcat('traj_simu_1_angled_60_pn_long_', feedback_types(f),'_', string(r),'.txt');
%             fullname = fullfile(directory_name, filename);
%             trajdatalong_1 = load(fullname);
% 
%             filename = strcat('traj_simu_-1_angled_60_pn_long_', feedback_types(f),'_', string(r),'.txt');
%             fullname = fullfile(directory_name, filename);
%             trajdatalong_2 = load(fullname);
%             trajdatalong=vertcat(trajdatalong_1,trajdatalong_2);
            
%             filename = strcat('traj_simu_1_long_forced_', feedback_types(f),'_', string(r),'.txt');%,'_', string(g),'.txt');
%             fullname = fullfile(directory_name, filename);
%             trajdatalongforced = load(fullname);
%             
%             filename = strcat('traj_simu_1_long_forced_negative_', feedback_types(f),'_', string(r),'.txt');%,'_', string(g),'.txt');
%             fullname = fullfile(directory_name, filename);
%             trajdatalongforcednegative = load(fullname);
            
            filename = strcat('traj_simu_1_long_torque_', feedback_types(f),'_', string(r),'.txt');%,'_', string(g),'.txt');
            fullname = fullfile(directory_name, filename);
            trajdatalongtorque = load(fullname);
            
%             filename = strcat('traj_simu_1_angled_60_pn_long_torque_', feedback_types(f),'_', string(r),'.txt');%,'_', string(g),'.txt');
%             fullname = fullfile(directory_name, filename);
%             trajdatalongtorque_1 = load(fullname);
            
            
%             filename = strcat('traj_simu_-1_angled_60_pn_long_torque_', feedback_types(f),'_', string(r),'.txt');%,'_', string(g),'.txt');
%             fullname = fullfile(directory_name, filename);
%             trajdatalongtorque_2 = load(fullname);
%             trajdatalongtorque =vertcat(trajdatalongtorque_1,trajdatalongtorque_2);           

            filename = strcat('traj_simu_1_long_torque_negative_', feedback_types(f),'_', string(r),'.txt');%,'_', string(g),'.txt');
            fullname = fullfile(directory_name, filename);
            trajdatalongtorquenegative = load(fullname);
            
%             filename = strcat('traj_simu_1_angled_60_pn_long_torque_negative_', feedback_types(f),'_', string(r),'.txt');%,'_', string(g),'.txt');
%             fullname = fullfile(directory_name, filename);
%             trajdatalongtorquenegative_1 = load(fullname);
%             
%             filename = strcat('traj_simu_-1_angled_60_pn_long_torque_negative_', feedback_types(f),'_', string(r),'.txt');%,'_', string(g),'.txt');
%             fullname = fullfile(directory_name, filename);
%             trajdatalongtorquenegative_2 = load(fullname);
%             trajdatalongtorquenegative =vertcat(trajdatalongtorquenegative_1,trajdatalongtorquenegative_2);
            
            figure(20+r)
            hold on
            grid on
            p1 = plot(trajdatalong(1:1000,1),trajdatalong(1:1000,2),'-k','LineWidth',1.5);
%             p2 = plot(trajdatalong(1001:end,1),trajdatalong(1001:end,2),'-k','LineWidth',1.5);
%             p2 = plot(trajdatalongforced(335:end,1),trajdatalongforced(335:end,2),'LineWidth',1.5);%,'-r');
%             p3 = plot(trajdatalongforcednegative(335:end,1),trajdatalongforcednegative(335:end,2),'LineWidth',1.5);%,'-r');
            p4 = plot(trajdatalongtorque(334:end,1),trajdatalongtorque(334:end,2),'-r','LineWidth',1.5);
%             p6 = plot(trajdatalongtorque(1335:end,1),trajdatalongtorque(1335:end,2),'-r','LineWidth',1.5);
            p5 = plot(trajdatalongtorquenegative(334:end,1),trajdatalongtorquenegative(334:end,2),'-b','LineWidth',1.5);%,'-r');
%             p7 = plot(trajdatalongtorquenegative(1335:end,1),trajdatalongtorquenegative(1335:end,2),'-b','LineWidth',1.5);%,'-r');
%             p2.Color(4) = 0.4;
%             p3.Color(4) = 0.4;
            p4.Color(4) = 0.4;
            p5.Color(4) = 0.4;
            xlim([-5 5])
            ylim([0 10])
            xlabel('X (meters)')
            ylabel('Y (meters)')
            title(strcat("Trajectories of Hexapod ", string(r)," Feedback ", feedback_types(f)));%, " Run ", string(r)));
            width = 3.25;     % Width in inches
            height = 2.5;    % Height in inches
            set(gcf,'InvertHardcopy','on');
            set(gcf,'PaperUnits', 'inches');
            papersize = get(gcf, 'PaperSize');
            left = (papersize(1)- width)/2;
            bottom = (papersize(2)- height)/2;
            myfiguresize = [left, bottom, width, height];
            set(gcf,'PaperPosition', myfiguresize);
%             legend_types = ["standard", "forced L", "forced R", "Torque ACW", "Torque CW"];
            legend_types = ["standard", "Torque ACW", "Torque CW"];
%             legend([p1 p2 p3 p4 p5],legend_types(1:5),...
%             legend([p1 p4 p5],legend_types(1:3),...
%             'FontUnits','points',...
%             'FontSize',7,...
%             'Location','bestoutside');
            daspect([1 1 1])
            print('rob_good_2','-depsc2','-r300');
        end
    end
end
end


