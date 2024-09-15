function [near_states, near_points]=Near(points,state,r)
near_states=[];
near_points=[];
    for i=1:size(points,1)
        if(norm(points(state,:)-points(i,:))<r)&&(i~=state)
            near_states=[near_states; i];
            near_points=[near_points; points(i,:)];
        end
    end