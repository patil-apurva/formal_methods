close all;
figure(1)
hold on;

%plot obstacles 
for adv_id=1:size(obsx,1)
    fill(cell2mat(obsx(adv_id)),cell2mat(obsy(adv_id)),'r')
end
%plot goal
fill(goalx,goaly,'g');
fill(initx,inity,'y');    
ax = gca;
ax.YTick = 0:d:1;
ax.XTick = 0:d:1;
grid on;
box on;

runs=100000; %for MC simulation
failure=0; %for MC simulation

for ijk=1:runs
    ijk
    clearvars path 
    %start of the robot
    path(1,1)=0+d/2;
    path(1,2)=0+d/2;
    
    flag_obs=0; %to check whether it collides
    adv_id=1; %for indexing adv matrix
    path_id=1; %for indexing path
    while (1)
        pathst=randsample(adv(adv_id:adv_id+2,2),1,true,adv(adv_id:adv_id+2,3)); %randomly select next state out of three possibilities depending upon the probability distribution
        x=(fix(pathst/div))/div+d/2; % x coordinate corresponding to the state
        y=(mod(pathst,div))/div+d/2; % y coordinate corresponding to the state
        %save the x,y coordinates in the path
        path_id=path_id+1;
        path(path_id,1)=x;
        path(path_id,2)=y;
        
        %check if x,y is inside any obstacles?
        for j=1:size(obsx,1)
            if(x>=obs_min_x(j) && x<=obs_max_x(j) && y>=obs_min_y(j) && y<=obs_max_y(j))
                flag_obs=1;
                break;
            end
        end

        if(flag_obs==1)
            break;
        end

        if(x>=goal_min_x && x<=goal_max_x && y>=goal_min_y && y<=goal_max_y)
            break;
        end
       
        ind=find(adv(:,1)==pathst); %find the indices in adv whose current state is pathst
        adv_id=ind(1); %pick the first of these indices
    end
    
    if(flag_obs==0) %flag_obs==1 if you want to find the path which fails, flag_obs==0 if you want to find a path which succeeds
%         failure=failure+1; %if you want to compute the MC probability, set flag_obs==1 above, uncomment this line and comment the next line with
%         break.
        break;
    end
end

% prob=1-(failure/runs)
plot(path(:,1), path(:,2), 'b', 'LineWidth',2);