function [delay2] = ...
    delay2_duration(training_stg,del_initiation,block_num,last_del,...
    tri_per_block,pre_tri_resp)

% Input:    Training_stage : 2,3,4,5,6  ,settings.Training_Stage
%           del_initiation : 0.01   ,settings.del_initiation
%           block_num  , settings.blocks
%           last_del    ,  data.Training_Stage3.Last_Keep_C_Poke_Duration
%           tri_per_block   ,settings.num_of_trials_in_block
%           last_block_del  , tempo_mat(jj-1).c_poke_duration(end)
% Output:   delay2 , a tri_per_block vector
%  

 
switch training_stg
    case 2
        delay2 = del_initiation .* ones(block_num,tri_per_block);
        
    case 3
        for i = 1: block_num
        if pre_tri_resp == -1             
            if i == 1
               b = (last_del - del_initiation) / tri_per_block;
               delay2 = del_initiation + b .* [1:tri_per_block];
            else                 
%             delay2 = [delay2; last_del .* ones(1,tri_per_block)  ];
            delay2 = [delay2; nan(1,tri_per_block)  ];
            end
        end
        end
       
            
            
%                delay2 = [delay2; delay2(i-1,end) + ...
%                     + del_initiation .* [1:tri_per_block]...
%                     + normrnd(0 , 0.1)];
        
        
    case 4 
        end_point = 6.5;  % end duration in stage 4 
        for i = 1: block_num
        
            if i == 1
               b = end_point / (tri_per_block * 2) ;
               delay2 =  b .* [1:tri_per_block];
            elseif i == 2 
               delay2 =  [delay2; delay2(i-1,end) + ... 
                   b .* [1:tri_per_block]];
            else 
               delay2 = [delay2; end_point .* ones(1,tri_per_block)];
                    
            end
        end
        
    case 5 
        del_points = [2.1 , 3.1];
        delay2 = Shuffle( repmat(del_points, [1,round((tri_per_block * block_num)/2)]));
        delay2 = reshape(delay2,[block_num,tri_per_block]);
        
      
    case 6 
        del_bound = [2,8];
        delay2 = rand([block_num,tri_per_block]) + randi([del_bound(1) del_bound(2)-1],[block_num,tri_per_block]);
        
    case 'human'
        del_bound = [2, 10];
        delay2 = rand([block_num,tri_per_block]) + randi([del_bound(1) del_bound(2)-1],[block_num,tri_per_block]);
       
end

    
end