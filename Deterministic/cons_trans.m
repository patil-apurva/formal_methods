function [trans, trans_smv_fnl] =cons_trans(N,points,r,obs_num,live_num,obsx,obsy,livex,livey)

    trans=[]; 
    for state=1:N
        trans_state=[];
    % for state=1:2 
        [near_states,near_points]=Near(points,state,r);
        for u=1:size(near_states,1)
            x=[points(state,1),near_points(u,1)];
            y=[points(state,2),near_points(u,2)];
            obs_flag=0;
            live_flag=0;

            for i=1:obs_num
                [check_x,check_y] = polyxpoly(cell2mat(obsx(i)),cell2mat(obsy(i)),x,y);
                if (length(check_x)==2)
                    obs_flag=1;
                    break;
                end
            end

            if (obs_flag==0)
                for j=1:live_num
                [check_x,check_y] = polyxpoly(cell2mat(livex(j)),cell2mat(livey(j)),x,y);
                    if (length(check_x)==2)
                        live_flag=1;
                        break;
                    end
                end
            end

            if((obs_flag==0)&&(live_flag==0))
                trans=[trans;[state,near_states(u)]];
                trans_state=[trans_state;[state,near_states(u)]];
            end
        end
%         if(state==10)
%             viscircles(points(state,:),r, 'Color','b');
% 
%             for i=1:size(trans,1)
%                 X=[points(trans(i,1),1),points(trans(i,2),1)];
%                 Y=[points(trans(i,1),2),points(trans(i,2),2)];
%                 plot(X,Y, 'k')
%             end
%         end
    end
    
    %write transitions for NuSMV
    trans_smv=cell(1,2);
    trans_smv(1,1)={trans(1,1)};
    temp=trans(1,1);
    j=1;
    for i=1:size(trans,1)
        if(temp~=trans(i,1))
            j=j+1;
            trans_smv(j,1)={trans(i,1)};
            temp=trans(i,1);
        end
        trans_smv{j,2}=[trans_smv{j,2},trans(i,2)];
    end

    trans_smv_fnl=cell(size(trans_smv,1)+2,1);
    trans_smv_fnl(1)={['init(s) := ',num2str(1),';']};
    trans_smv_fnl(2)={'next(s) := case'};
    for i=1:size(trans_smv,1)
    temp=[];
        for j=1:length(trans_smv{i,2})
            if(j~=1)
                temp=[temp,',',num2str(trans_smv{i,2}(j))];
            else
                temp=[temp,num2str(trans_smv{i,2}(j))];
            end
        end
        trans_smv_fnl(i+2) = {['(s=',num2str(trans_smv{i,1}),') : {',temp,'};']};
    end