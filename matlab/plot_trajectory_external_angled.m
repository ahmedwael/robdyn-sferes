%% Loading Trajectories of Short

close all;
clear all;
program_types=["orientfb", "angled", "angled_pn", "torque"];
feedback_types = ["18", "36", "180", "none"];
for p = 4:4
for f = 2:2
    for r = 0:9 
        directory_name = strcat(program_types(p),'/',program_types(p),'_',feedback_types(f),'/',program_types(p),'_',feedback_types(f),'_',string(r),'/');
        for g = 10000:10000%:10000
            filename = strcat('traj_simu_1_long_', feedback_types(f),'_', string(r),'.txt');
            fullname = fullfile(directory_name, filename);
            trajdatalong = load(fullname);
            
            filename = strcat('traj_simu_1_long_forced_', feedback_types(f),'_', string(r),'.txt');%,'_', string(g),'.txt');
            fullname = fullfile(directory_name, filename);
            trajdatalongforced = load(fullname);
            
            filename = strcat('traj_simu_1_long_forced_negative_', feedback_types(f),'_', string(r),'.txt');%,'_', string(g),'.txt');
            fullname = fullfile(directory_name, filename);
            trajdatalongforcednegative = load(fullname);
            
            filename = strcat('traj_simu_1_long_torque_', feedback_types(f),'_', string(r),'.txt');%,'_', string(g),'.txt');
            fullname = fullfile(directory_name, filename);
            trajdatalongtorque = load(fullname);
            
            filename = strcat('traj_simu_1_long_torque_negative_', feedback_types(f),'_', string(r),'.txt');%,'_', string(g),'.txt');
            fullname = fullfile(directory_name, filename);
            trajdatalongtorquenegative = load(fullname);
            
            figure(20+r)
            hold on
            grid on
            p1 = plot(trajdatalong(:,1),trajdatalong(:,2),'-k');            
            p2 = plot(trajdatalongforced(335:end,1),trajdatalongforced(335:end,2));%,'-m');
            p3 = plot(trajdatalongforcednegative(335:end,1),trajdatalongforcednegative(335:end,2),'-g');
            p4 = plot(trajdatalongtorque(335:end,1),trajdatalongtorque(335:end,2),'-b');
            p5 = plot(trajdatalongtorquenegative(335:end,1),trajdatalongtorquenegative(335:end,2), '-r');
            p2.Color(4) = 0.4;
            p3.Color(4) = 0.4;
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
            legend_types = ["original", "forced R", "forced L", "Torque ACW", "Torque CW","shutoff","bias 30° ACW", "bias 30° CW", "+-30°"];
            legend([p1 p2 p3 p4 p5],legend_types(1:5),...
            'FontUnits','points',...
            'FontSize',8,...
            'Location','NorthWest');
            daspect([1 1 1])            
        end
    end
end
end


