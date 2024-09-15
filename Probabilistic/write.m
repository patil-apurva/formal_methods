function text_prism=write(div, d,obs_min_x, obs_max_x, obs_min_y, obs_max_y, goal_min_x, goal_max_x, goal_min_y, goal_max_y)
    text_prism=cell(1);
    
    text_prism(1,1)={"const int xSize = "+num2str(div-1)+";"};
    text_prism(2,1)={"const int ySize = "+num2str(div-1)+";"};
    text_prism(3,1)={" "};
    
    text_prism(4,1)={"const int xGoal_min = "+num2str(goal_min_x/d)+";"};
    text_prism(5,1)={"const int xGoal_max = "+num2str(goal_max_x/d-1)+";"};
    text_prism(6,1)={"const int yGoal_min = "+num2str(goal_min_y/d)+";"};
    text_prism(7,1)={"const int yGoal_max = "+num2str(goal_max_y/d-1)+";"};
    text_prism(8,1)={" "};

    for i=0:size(obs_min_x,1)-1
        text_prism(end+1,1)={"const int xObs"+num2str(i)+"_min = "+num2str(obs_min_x(i+1)/d)+";"};
        text_prism(end+1,1)={"const int xObs"+num2str(i)+"_max = "+num2str(obs_max_x(i+1)/d-1)+";"};
        text_prism(end+1,1)={"const int yObs"+num2str(i)+"_min = "+num2str(obs_min_y(i+1)/d)+";"};
        text_prism(end+1,1)={"const int yObs"+num2str(i)+"_max = "+num2str(obs_max_y(i+1)/d-1)+";"};
        text_prism(end+1,1)={" "};
    end
    
    text_prism_end="formula Cr = ";
    
    for i=0:size(obs_min_x,1)-1
        if (i==size(obs_min_x,1)-1)
            text_prism_end=text_prism_end+ "(xA>=xObs"+num2str(i)+"_min & xA<=xObs"+num2str(i)+"_max & yA>=yObs"+num2str(i)+"_min & yA<=yObs"+num2str(i)+"_max)" + " ; ";
        else
            text_prism_end=text_prism_end+ "(xA>=xObs"+num2str(i)+"_min & xA<=xObs"+num2str(i)+"_max & yA>=yObs"+num2str(i)+"_min & yA<=yObs"+num2str(i)+"_max)" + " | ";
        end
    end
    text_prism(end+1)={text_prism_end};