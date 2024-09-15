close all
clear
N=100; %number of sampled points
r=0.2; %radius of PRM algorithm
% points(1,:)=rand(1,2); %Initial point of the agent
points(1,:)=[0,0]; %Initial point of the agent
points(2:N,:)=rand(N-1,2); %sampled points

%to save obstacle and live regions
obsx=cell(1); 
obsy=cell(1);
livex=cell(1);
livey=cell(1);
%obstacle regions. obsx(i) contains x coordinates of the obstacle i. The
%elements of obsx(i)=num of vertices of ith obstacle+1
obsx(1,1)={[0,0.2,0.2,0,0]};
obsy(1,1)={[0.4,0.4,0.6,0.6,0.4]};

obsx(2,1)={[0.5,0.7,0.7,0.5,0.5]};
obsy(2,1)={[0.4,0.4,0.6,0.6,0.4]};

obsx(3,1)={[0.8,1,1,0.8]};
obsy(3,1)={[0.5,0.4,0.6,0.5]};

obsx(4,1)={[0.5,0.5,0.7,0.5]};
obsy(4,1)={[1,0.85,0.85,1]};

obsx(5,1)={[0.2,0.4,0.4,0.2,0.2]};
obsy(5,1)={[0,0,0.2,0.2,0]};

%liveness regions
livex(1,1)={[0.2,0.4,0.4,0.2,0.2]};
livey(1,1)={[0.8,0.8,1,1,0.8]};

livex(2,1)={[0.8,1,1,0.8,0.8]};
livey(2,1)={[0.8,0.8,1,1,0.8]};

livex(3,1)={[0.8,1,1,0.8,0.8]};
livey(3,1)={[0,0,0.2,0.2,0]};

obs_num=size(obsx,1);
live_num=size(livex,1);

%plot the regions
figure(1)
hold on;
axis equal;
xlim([0 1]); 
ylim([0 1]);
box on;

for i=1:size(obsx,1)
    fill(cell2mat(obsx(i)),cell2mat(obsy(i)),'r')
end

for i=1:size(livex,1)
    fill(cell2mat(livex(i)),cell2mat(livey(i)),'g')
end

text(0.03,0.05, 'x_0','FontSize', 14);
text(0.08,0.5, 'R_1','FontSize', 14);
text(0.28,0.9, 'R_2','FontSize', 14);
text(0.28,0.1, 'R_3','FontSize', 14);
text(0.53,0.9, 'R_4','FontSize', 14);
text(0.55,0.5, 'R_5','FontSize', 14);
text(0.9,0.93, 'R_6','FontSize', 14);
text(0.92,0.5, 'R_7','FontSize', 14);
text(0.9,0.1, 'R_8','FontSize', 14);
text(0.68,0.2, 'R_9','FontSize', 14);
scatter (points(1,1),points(1,2),800,'.','b');

%plot the sampled points
scatter (points(:,1),points(:,2),'.','k');
scatter (points(1,1),points(1,2),800,'.','b');

[obs_state_smv, live_state_smv]=define(N,points,obs_num,live_num,obsx,obsy,livex,livey); %find the points which are inside the obstacle and live regions
[trans, trans_smv_fnl] =cons_trans(N,points,r,obs_num,live_num,obsx,obsy,livex,livey); %construct appropriate transitions

%plot transitions
for i=1:size(trans,1)
    X=[points(trans(i,1),1),points(trans(i,2),1)];
    Y=[points(trans(i,1),2),points(trans(i,2),2)];
    plot(X,Y,'k')
end




