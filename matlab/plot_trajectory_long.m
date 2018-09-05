%% Loading Trajectories of Short

close all;
clear all;
program_types=["orientfb", "angled", "angled_pn", "torque"];
feedback_types = ["18", "36", "180","none"];
for p = 1:1
for f = 4:4
    for r = 8:8 
        directory_name = strcat(program_types(p),'/',program_types(p),'_',feedback_types(f),'/',program_types(p),'_',feedback_types(f),'_',string(r),'/');
        for g = 10000:10000%:10000
            filename = strcat('traj_simu_1_long_', feedback_types(f),'_', string(r),'.txt');
            fullname = fullfile(directory_name, filename);
            trajdatalong = load(fullname);
            
                      
            figure(20+r)
            hold on
            grid on
            p1 = plot(trajdatalong(1:334,1),trajdatalong(1:334,2),'-k','LineWidth',1.5);
            p2 = plot(trajdatalong(335:end,1),trajdatalong(335:end,2),'--','LineWidth',1.5);%,'-r');
            
            xlim([-5 5])
            ylim([-0.5 10])
            xlabel('X (meters)')
            ylabel('Y (meters)')
%             title(strcat("Trajectories of Hexapod ", string(r)," Feedback ", feedback_types(f)));%, " Run ", string(r)));
            set(gca,...
            'Units','normalized',...
            'FontWeight','normal',...
            'FontSize',10.5);
            width = 2.5;     % Width in inches
            height = 2.5;    % Height in inches
            set(gcf,'InvertHardcopy','on');
            set(gcf,'PaperUnits', 'inches');
            papersize = get(gcf, 'PaperSize');
            left = (papersize(1)- width)/2;
            bottom = (papersize(2)- height)/2;
            myfiguresize = [left, bottom, width, height];
            set(gcf,'PaperPosition', myfiguresize);
            legend_types = ["t < 5 ", "t > 5"];
            legend([p1 p2],legend_types(:),...
            'FontUnits','points',...
            'FontSize',8,...
            'Location','NorthWest');            
            daspect([1 1 1])
            print('cs_brittle_nf','-depsc2','-r300');
        end
    end
end
end


