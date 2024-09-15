function [obs_min_x, obs_max_x, obs_min_y, obs_max_y, goal_min_x, goal_max_x, goal_min_y, goal_max_y]=bb(obsx, obsy, goalx, goaly, d) 
    obs_min_x=zeros(size(obsx,1),1);
    obs_max_x=zeros(size(obsx,1),1);
    obs_min_y=zeros(size(obsy,1),1);
    obs_max_y=zeros(size(obsy,1),1);

    for i=1:size(obsx,1)
        min_x=min(cell2mat(obsx(i)));
        max_x=max(cell2mat(obsx(i)));

        obs_min_x(i)=(floor(vpa(min_x/d,2)))*d;
        obs_max_x(i)=(ceil(vpa(max_x/d,2)))*d;

        min_y=min(cell2mat(obsy(i)));
        max_y=max(cell2mat(obsy(i)));

        obs_min_y(i)=(floor(vpa(min_y/d,2)))*d;
        obs_max_y(i)=(ceil(vpa(max_y/d,2)))*d;
    end

    goal_min_x=zeros(1,1);
    goal_max_x=zeros(1,1);
    goal_min_y=zeros(1,1);
    goal_max_y=zeros(1,1);

    min_x=min(goalx);
    max_x=max(goalx);
    
    goal_min_x(1,1)=(floor(vpa(min_x/d,2)))*d;
    goal_max_x(1,1)=(ceil(vpa(max_x/d,2)))*d;
    
    min_y=min(goaly);
    max_y=max(goaly);
    
    goal_min_y(1,1)=(floor(vpa(min_y/d,2)))*d;
    goal_max_y(1,1)=(ceil(vpa(max_y/d,2)))*d;