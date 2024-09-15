function [obs_state_smv, live_state_smv]= define(N,points,obs_num,live_num,obsx,obsy,livex,livey)
    
    %list down all the obstacle states
    obs_state=[];
    for state=1:N
        for i=1:obs_num
            if(inpolygon(points(state,1),points(state,2),cell2mat(obsx(i)),cell2mat(obsy(i))))
                obs_state=[obs_state;state];
                break;
            end
        end
    end
    
    %list down live states seperately for seperate live regions
    live_state=cell(live_num,1);
    for i=1:live_num
        temp=[];
        for state=1:N
            if(inpolygon(points(state,1),points(state,2),cell2mat(livex(i)),cell2mat(livey(i))))
                temp=[temp,state];
            end
        end
        live_state(i)={temp};
    end
    
    %write for NuSMV
    obs_state_smv="obs:=";
    for i=1:size(obs_state,1) 
        if (i==size(obs_state,1) )
            obs_state_smv=obs_state_smv+"s = "+ num2str(obs_state(i))+ " ; ";
        else
            obs_state_smv=obs_state_smv+"s = "+ num2str(obs_state(i)) + " | ";
        end
    end
    
    live_state_smv=cell(3,1);
    for j=1:live_num
        live_state_smv(j)={['live',num2str(j),':=']};
        temp=cell2mat(live_state(j));
        for i=1:length(temp) 
            if (i==length(temp))
                live_state_smv(j)={[cell2mat(live_state_smv(j)),'s = ', num2str(temp(i)), ' ; ']};
            else
                live_state_smv(j)={[cell2mat(live_state_smv(j)),'s = ', num2str(temp(i)), ' | ']};
            end
        end
    end
end