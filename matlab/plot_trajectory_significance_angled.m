%% Loading Trajectories of Short

close all;
clear all;
program_types=["orientfb", "angled", "angled_pn", "torque"];
feedback_types = ["18", "36", "180"];
angle = ["_1_angled_60_pn","_-1_angled_60_pn"];
a = 1;
for p = 2:2
for f = 1:1
    for r = 0:9 
        directory_name = strcat(program_types(p),'/',program_types(p),'_',feedback_types(f),'/',program_types(p),'_',feedback_types(f),'_',string(r),'/');
        for g = 10000:10000%:10000
            filename = strcat('traj_simu',angle(1),'_long_', feedback_types(f),'_', string(r),'.txt');
            fullname = fullfile(directory_name, filename);
            trajdatalong_1 = load(fullname);
            
            filename = strcat('traj_simu',angle(2),'_long_', feedback_types(f),'_', string(r),'.txt');
            fullname = fullfile(directory_name, filename);
            trajdatalong_2 = load(fullname);
           
            
%             filename = strcat('traj_simu_1_',angle(a),'_long_shutoff_', feedback_types(f),'_', string(r),'.txt');%,'_', string(g),'.txt');
%             fullname = fullfile(directory_name, filename);
%             trajdatalongshutoff = load(fullname);
%         
%             filename = strcat('traj_simu_1_',angle(a),'_long_bias_30_', feedback_types(f),'_', string(r),'.txt');%,'_', string(g),'.txt');
%             fullname = fullfile(directory_name, filename);
%             trajdatalongbias30_acw = load(fullname);
%                 
%             filename = strcat('traj_simu_1_',angle(a),'_long_bias_30_negative_', feedback_types(f),'_', string(r),'.txt');%,'_', string(g),'.txt');
%             fullname = fullfile(directory_name, filename);
%             trajdatalongbias30_cw = load(fullname);
            
            figure(20+r)
            hold on
            grid on
            p1 = plot(trajdatalong_1(:,1),trajdatalong_1(:,2),'-k','LineWidth',1.5);
            p2 = plot(trajdatalong_2(:,1),trajdatalong_2(:,2),'-r','LineWidth',1.5);
%             p6 = plot(trajdatalongshutoff(335:end,1),trajdatalongshutoff(335:end,2),'LineWidth',1.5);%,'-r');
%             p7 = plot(trajdatalongbias30_acw(335:end,1),trajdatalongbias30_acw(335:end,2),'LineWidth',1.5);%,'-b');
%             p8 = plot(trajdatalongbias30_cw(335:end,1),trajdatalongbias30_cw(335:end,2),'LineWidth',1.5);%,'-g');
%             p6.Color(4) = 0.4;
%             p7.Color(4) = 0.4;  
%             p8.Color(4) = 0.4;
%             x = trajdatalongshutoff(334,1);
%             y = trajdatalongshutoff(334,2);
%             L = 10;
%             alpha = pi()/6;
% %             x2=x+(L*sin(alpha));
%             y2=y+(L*cos(alpha));
%             p9 = plot([x x2],[y y2], '--r');
%             alpha = -1*pi()/6;
%             x2=x+(L*sin(alpha));
%             y2=y+(L*cos(alpha));
%             p10 = plot([x x2],[y y2], '--r');
%             p9.Color(4) = 0.4;  
%             p10.Color(4) = 0.4;
%             if (p==2 || p==3)
%             alpha = pi()/3;
%             x2=(L*sin(alpha));
%             y2=(L*cos(alpha));
%             p11 = plot([0 x2],[0 y2], '--g');
%             alpha = -1*pi()/3;
%             x2=(L*sin(alpha));
%             y2=(L*cos(alpha));
%             p12 = plot([0 x2],[0 y2], '--g');
%             p11.Color(4) = 0.4;  
%             p12.Color(4) = 0.4;
%             end
            xlim([-5 5])
            ylim([-0.5 10])
            xlabel('X (meters)')
            ylabel('Y (meters)')
            title(strcat("Trajectories of Hexapod ", string(r)," Feedback ", feedback_types(f)));%, " Run ", string(r)));
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
            legend_types = ["CW", "ACW"];
            legend([p1 p2],legend_types(:),...
            'FontUnits','points',...
            'FontSize',8,...
            'Location','NorthWest');
%             if (p==2 || p==3)
%             legend_types = ["standard", "shutoff","bias 30° ACW", "bias 30° CW", "+-30° Indicator", "+-60°"];
%             legend([p1 p6 p7 p8 p9 p11],legend_types(:),...
%             'FontUnits','points',...
%             'FontSize',8,...
%             'Location','NorthWest');
%             else
%             legend_types = ["standard", "shutoff","bias 30° ACW", "bias 30° CW", "+-30° Indicator"];
%             legend([p1 p6 p7 p8 p9],legend_types(:),...
%             'FontUnits','points',...
%             'FontSize',8,...
%             'Location','NorthWest');
%             end
            daspect([1 1 1])            
        end
    end
end
end


