close all
clearvars -except adv
d=0.1; %grid spacing
div=1/d; %number of cells along each axis

%list of all the obstacles
obsx=cell(1); 
obsy=cell(1);

obsx(1,1)={[0,0.2,0.2,0,0]};
obsy(1,1)={[0.4,0.4,0.6,0.6,0.4]};

obsx(2,1)={[0.2,0.4,0.4,0.2,0.2]};
obsy(2,1)={[0,0,0.2,0.2,0]};

obsx(3,1)={[0.2,0.4,0.4,0.2,0.2]};
obsy(3,1)={[0.7,0.7,0.9,0.9,0.7]};

obsx(4,1)={[0.4,0.7,0.7,0.4,0.4]};
obsy(4,1)={[0.4,0.4,0.6,0.6,0.4]};

obsx(5,1)={[0.5,0.5,0.7,0.5]};
obsy(5,1)={[1,0.85,0.85,1]};

obsx(6,1)={[0.8,1,1,0.8]};
obsy(6,1)={[0.5,0.4,0.6,0.5]};

%goal position
goalx=[0.9,1,1,0.9,0.9];
goaly=[0.9,0.9,1,1,0.9];

%initial position
initx=[0,d,d,0,0];
inity=[0,0,d,d,0];

%plot the configuration space
figure(1)
hold on;
for adv_id=1:size(obsx,1)
    fill(cell2mat(obsx(adv_id)),cell2mat(obsy(adv_id)),'r')
end

fill(goalx,goaly,'g');
fill(initx,inity,'y');
    
ax = gca;
ax.YTick = 0:d:1;
ax.XTick = 0:d:1;
grid on;
box on;
axis equal;
xlim([0,1]);
ylim([0,1]);

% text(0.03,0.05, 'q_0','FontSize', 14);
% text(0.08,0.5, 'R_1','FontSize', 14);
% text(0.28,0.8, 'R_2','FontSize', 14);
% text(0.28,0.1, 'R_3','FontSize', 14);
% text(0.51,0.9, 'R_4','FontSize', 14);
% text(0.53,0.5, 'R_5','FontSize', 14);
% text(0.92,0.5, 'R_6','FontSize', 14);
% text(0.93,0.95, 'R_7','FontSize', 14);
% text(0.68,0.2, 'R_8','FontSize', 14);

%find out cells occupied by obstacles and goal
[obs_min_x, obs_max_x, obs_min_y, obs_max_y, goal_min_x, goal_max_x, goal_min_y, goal_max_y]=bb(obsx, obsy, goalx, goaly, d); 
%write down text for prism code
text_prism=write(div, d,obs_min_x, obs_max_x, obs_min_y, obs_max_y, goal_min_x, goal_max_x, goal_min_y, goal_max_y);