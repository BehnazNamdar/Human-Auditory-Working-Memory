function [sound_db_s_a,sound_db_s_b,choice] = sound_db_table(base,block_num,tri_per_block)


% Input:  basic sound db , settings.Sound_db
%         training_stg , settings.Training_Stage
%         block_num  , settings.blocks
%         tri_per_block   ,settings.num_of_trials_in_block
% Output: sound_db_s_a 
%         sound_db_s_b
%         choice: -1 for left and 1 for right 


sound_db_s_a = zeros(block_num,tri_per_block);
sound_db_s_b = zeros(block_num,tri_per_block);
choice = zeros(block_num,tri_per_block);


sound_pairs_num = length(base); 
sound_db_ind = randi([1 sound_pairs_num],[block_num,tri_per_block]);
sound_db_cell = base(sound_db_ind);
  if   block_num==1
      sound_db_cell=sound_db_cell';
  end

for i = 1: block_num
    for j =1: tri_per_block
        sound_db_s_a(i,j) = sound_db_cell{i,j}(1);
        sound_db_s_b(i,j) = sound_db_cell{i,j}(2);
        if sound_db_s_a(i,j) > sound_db_s_b(i,j)
            choice(i,j) = -1; %left side
        else
            choice(i,j) = 1; % right side
        end
    end
end
         
        
end

