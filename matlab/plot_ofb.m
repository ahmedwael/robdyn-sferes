feedback_types = ["\pm18\circ", "\pm36\circ", "\pm180\circ"];
degrees = linspace(-180,180,361);
ofb180 = degrees/180;	
ofb18 = 10*degrees/180;
ofb18(ofb18 > 1 ) =1;
ofb18(ofb18 < -1 ) = -1;
ofb36 = 5*degrees/180;
ofb36(ofb36 > 1 ) =1;
ofb36(ofb36 < -1 ) = -1;
close all;

% figure(1);
figure(1);
grid on
hold on
p1 = plot(degrees,ofb18,'LineWidth',2);
p2 = plot(degrees,ofb36,'LineWidth',2);
p3 = plot(degrees,ofb180,'LineWidth',2);
xticks(linspace(-180,180,7))
xlim([-180 180])
ylim([-1.5 1.5])
title('Orientation Feedback Sensitivities');
xlabel('Hexapod Yaw Error (degrees)');
ylabel('SUPG Input');
leg = legend(feedback_types);
title(leg,'Sensitivity');
p1.Color(4)=0.8;
p2.Color(4)=0.8;
p3.Color(4)=0.8;
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
%%
% close all
figure(2);
hold on
grid on
x = 0;
y = 0;
L = 10;
theta = 18;
x2=x+(L*sin(theta*pi()/180));
y2=y+(L*cos(theta*pi()/180));
plot([x x2],[y y2],'Color',[0    0.4470    0.7410] ,'LineStyle','--');
theta = -18;
x2=x+(L*sin(theta*pi()/180));
y2=y+(L*cos(theta*pi()/180));
plot([x x2],[y y2],'Color',[0    0.4470    0.7410] ,'LineStyle','--');
theta = 36;
x2=x+(L*sin(theta*pi()/180));
y2=y+(L*cos(theta*pi()/180));
plot([x x2],[y y2],'Color',[0.8500    0.3250    0.0980] ,'LineStyle','--');
theta = -36;
x2=x+(L*sin(theta*pi()/180));
y2=y+(L*cos(theta*pi()/180));
plot([x x2],[y y2],'Color',[0.8500    0.3250    0.0980] ,'LineStyle','--');
xlim([-10 10])
ylim([-10 10])
daspect([1 1 1])      
%%
close all
figure(3)
grid on
hold on
theta = linspace(-36, 36)/180*pi;
p1 = patch([0 sin(theta) 0], [0 cos(theta) 0],[0.8500    0.3250    0.0980]);
theta = linspace(-18, 18)/180*pi;
p2 =patch([0 1.1*sin(theta) 0], [0 1.1*cos(theta) 0],[0    0.4470    0.7410]);
rectangle('Position', [-0.1 -0.15 0.2 0.3], 'FaceColor',[.7 .7 .7]);
quiver(0,0,0,0.65,'r','LineWidth',2, 'MaxHeadSize', 5);
alpha(0.4)
axis equal
leg = legend([p2 p1], feedback_types(1:2));
title(leg,'Sensitive Field of View');
xlim([-1 1])
ylim([-0.5 1.5])
title('Orientation Feedback Sensitive Range');
% xlabel('x');
% ylabel('y');
set(gca,'visible','off')

daspect([1 1 1])      