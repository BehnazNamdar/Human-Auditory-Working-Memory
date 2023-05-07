%% check keyboard secsion and puase and exit section


%% Human Auditory Working Memory Task - Farsi version
% ** Without fixation point(+),...
% ** With each trial feedback, ...
% ** With red and green square association when stimulus onset
% ** This task need mouse for getting response

% The subject self-initiated each trial by clicking the left key on the mouse.
% The first sound is then presented together with a green square ...
%       on the left side of a PC monitor in front of the subject.
% A delay period, indicated by ‘WAIT!’ on the screen
% the second sound is presented together ...
%       with a red square on the right side of the screen.
% After displying green and red squares together,
% subject indicate choice by clicking on the green square ...
%       (if left side-first sound was louder) or ...
%       the green square (if right side-second sound was louder)
% Then a question will be asked about the confidence level while ...
%       responding to the trial. 
% At the end of every trial, a written feedback is displayed....
%       ("False" with purple color and "True" with turquoise color)
%% clear and get path
clearvars; clc;
f       = filesep;
path    = cd;
addpath(genpath([path f 'suppl']));
load([path ,f 'suppl' f 'sound_param.mat']);

%% settings - session settings
% dialogue input box to get session info
prompt         = {'Enter experimenter name:',...
                  'Enter subject name:',...
                  'Do you need to read instruction? (y/n)',...
                  'Do you need to practice? (y/n)'};
dlgtitle       = 'Session Info ';
dims           = [1 35];
definput       = {'behnaz','hwm','y','y'};
opts           = 'on';

answer         = inputdlg(prompt, dlgtitle, dims, definput);
exp_name       = answer{1};
subject        = answer{2};
Instruction    = answer{3};
practice       = answer{4};
mkdir([path f 'data_set_human'],subject);
date           = datestr(now, 'yymmdd');
training_stage = 'human';

%% Block and trial numbers
tri_num      = 150;
tri_in_block = 30;
bl_num       = tri_num / tri_in_block ;
%% settings - keyboard
KbName('UnifyKeyNames');
KbDeviceIndex = [];
exit_key      = KbName('ESCAPE');
pause_key     = KbName('space');
save_key      = KbName('y');

%% settings - delay interval

% practice
% --------
time_d2_p    = [2,2,2,6,6,6];

% Sa_Sb
% --------
% function "delay2_duration" can be use to generate delay interval time.
% but here I prefere not to use it because only 2 options for delay used.

% build delay2 array
delay_time   = [2,6]';
num_del_time = length(delay_time);
time_d2      = Shuffle(repmat(delay_time,[(tri_num / num_del_time), 1]));

%% settings - stimuli

% stimuli pairs sound db:
ss             = (60:2:72);
% I have different sound_table stimulus for different part of experiment

% *** practice part sound_table ***
% --------------------------------------------
sound_sa_p     = [62 72 62 72 70 60 ];
sound_sb_p     = [72 60 66 66 60 70 ];
choice_p       = [1  -1  1 -1 -1  1 ];

% *** Sa is fix but Sb is variable *** 
% --------------------------------------------
% sa           = [66 66 66 66 66 66 66]; % Sa_fix
% sound_db_a   = repmat(sa,1,7);
% sound_db_b   = repmat(ss,7,1);
% sound_db_b   = sound_db_b(:)';
% for        i = 1 : size(sound_db_b,2)
%       sound_db{i,:} = [sound_db_a(i) sound_db_b(i)];
% end
% 
% [sound_db_s_a,sound_db_s_b,choice] = ...
%     sound_db_table(sound_db, bl_num, tri_in_block);
% sound_db_s_a = reshape(sound_db_s_a,[tri_num,1]);
% sound_db_s_b = reshape(sound_db_s_b,[tri_num,1]);
% choice       = reshape(choice,[tri_num,1]);

% *** Sb is fix but Sa is variable ***
% --------------------------------------------
% sb           = [66 66 66 66 66 66 66]; % Sb_fix
% sound_db_a   = repmat(ss,1,7);
% sound_db_b   = repmat(sb,7,1);
% sound_db_b   = sound_db_b(:)';
% for       i  = 1 : size(sound_db_b,2)
%       sound_db{i,:} = [sound_db_a(i) sound_db_b(i)];
% end
% 
% [sound_db_s_a,sound_db_s_b,choice] = ...
%     sound_db_table(sound_db, bl_num, tri_in_block); 
% sound_db_s_a = reshape(sound_db_s_a,[tri_num,1]);
% sound_db_s_b = reshape(sound_db_s_b,[tri_num,1]);
% choice       = reshape(choice,[tri_num,1]);

% *** both Sa and Sb are variable ***
% -------------------------------------------- 
sound_db_a     = repmat(ss,1,7); % Sa_Sb
sound_db_b     = repmat(ss,7,1);
sound_db_b     = sound_db_b(:)';
for         i  = 1 : size(sound_db_b,2)
      sound_db{i,:} = [sound_db_a(i) sound_db_b(i)];
end

[sound_db_s_a,sound_db_s_b,choice] = ...
     sound_db_table(sound_db, bl_num, tri_in_block);
sound_db_s_a   = reshape(sound_db_s_a,[tri_num,1]);
sound_db_s_b   = reshape(sound_db_s_b,[tri_num,1]);
choice         = reshape(choice,[tri_num,1]);
%% settings - Screen  

Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference', 'ConserveVRAM', 1 ); %1 == kPsychDisableAUXBuffers
%Screen('Preference', 'ConserveVRAM', 2); %2 == kPsychDontCacheTextures

ScreenNumber       = max(Screen('Screens'));
[width, height]    = Screen('WindowSize',ScreenNumber);
win_rect           = [0 0 width-5 height];
win_color          = 128;
[wPtr,rect]        = Screen('OpenWindow',ScreenNumber, win_color, win_rect);

% Get the center coordinate of the window
[xCenter, yCenter] = RectCenter(win_rect);

% squares settings
color_g_sq         = [0 255 0];
color_r_sq         = [255 0 0];
rect_g_sq          = [ xCenter/2 + 50  ,yCenter-50 , xCenter/2 + 150 ,yCenter + 50];
rect_r_sq          = [ ((xCenter *3) /2) - 150  ,yCenter-50 , ((xCenter *3) /2)-50  ,yCenter+50];

% set confidence level screen
rect_confi         = [xCenter - 30 ,yCenter - 200 , xCenter + 30 ,yCenter + 200];
color_confi        =  WhiteIndex(wPtr);
color_confi_level  = [50 250 100];

% set texts format
Screen('TextFont',wPtr,'Calibri');
Screen('TextStyle',wPtr,1); % Bold font style

text_color         = 255;
text_color_true    = [64 224 208];
text_color_false   = [128,0,128];
%% texts content
% load png files containing instruction texts
% there are 2 options for instruction images, 
% one is for small monitors (1400,900) and 
% one is for bigger monitors (1920,1080)
if width > 1400 
    text_files      = dir([path,f 'suppl' f 'Farsi_Instruction' f '1920-1080-pixel' f, '*.png']);
    path_text_files = [path, f 'suppl' f 'Farsi_Instruction' f '1920-1080-pixel'];

else
    text_files      = dir([path,f 'suppl' f 'Farsi_Instruction' f '1400-900-pixel' f, '*.png']);
    path_text_files = [path, f 'suppl' f 'Farsi_Instruction' f '1400-900-pixel'];

end

% read and make png files
text_ins1         = imresize(imread([path_text_files,f 'text_ins1.png']),[win_rect(4),win_rect(3)]);
text_ins_confid   = imresize(imread([path_text_files,f 'text_ins_confid.png']),[win_rect(4),win_rect(3)]);
text_ins_feedbck  = imresize(imread([path_text_files,f 'text_ins_feedbck.png']),[win_rect(4),win_rect(3)]);
text_ins_main     = imresize(imread([path_text_files,f 'text_ins_main.png']),[win_rect(4),win_rect(3)]);
text_ins_practice = imresize(imread([path_text_files,f 'text_ins_practice.png']),[win_rect(4),win_rect(3)]);
text_sound_check  = imresize(imread([path_text_files,f 'text_sound_check.png']),[win_rect(4),win_rect(3)]);
text_finished     = imresize(imread([path_text_files,f 'text_finished.png']),[win_rect(4),win_rect(3)]);
text_ins1         = Screen('MakeTexture',wPtr,text_ins1);
text_ins_confid   = Screen('MakeTexture',wPtr,text_ins_confid);
text_ins_feedbck  = Screen('MakeTexture',wPtr,text_ins_feedbck);
text_ins_main     = Screen('MakeTexture',wPtr,text_ins_main);
text_ins_practice = Screen('MakeTexture',wPtr,text_ins_practice);
text_sound_check  = Screen('MakeTexture',wPtr,text_sound_check);
text_finished     = Screen('MakeTexture',wPtr,text_finished);

% drawText instructions
text_save         = 'Do you want to save data?(y/n) ?';
text_start_tr     = 'Click when ready';
text_break        = ['Have a break\n...' ...
                     '\n...' ...
                     'Click when ready'];
text_wait         = 'Wait!';
text_true         = 'True';
text_false        = 'False';
text_confi_ques   = 'How much are you sure?';
text_confi_contin = 'Continue';

%% experiment running

session_start = tic;
%% Pause and Exit Option
%**************************
% subject is able to pause or exit the experiment whenever needed.
% when leaving is selected, there is an option to save data already
% gathered in task.
[keyIsDown,secs,keyCode] = KbCheck(-1);
res_key = find(keyCode);

if res_key  == exit_key
    Screen('TextSize',wPtr,24);
    DrawFormattedText(wPtr, text_save ,'center', 'center', text_color);
    Screen('Flip', wPtr);
    while 1
        [keyIsDown,secs,keyCode] = KbCheck(-1);
        res_key = find(keyCode);
        if res_key  == save_key
            save_y = 'y';
            break;
        end
    end
    return;
elseif res_key == pause_key
    pause;
end

%% Display Instruction
% showing instruction of the experiment if needed
if Instruction == 'y'
    
    Screen('DrawTexture',wPtr,text_ins1);
    Screen('Flip', wPtr);
    
    GetClicks(wPtr,0);
    Screen('Flip', wPtr);
    
    Screen('DrawTexture',wPtr,text_ins_confid);
    Screen('Flip', wPtr);
    
    GetClicks(wPtr,0);    
    Screen('Flip', wPtr);
    
    Screen('DrawTexture',wPtr,text_ins_feedbck);
    Screen('Flip', wPtr);
    
    GetClicks(wPtr,0);
    Screen('Flip', wPtr);
    
end
%% Run Practice section

% Running 6 easy trials for training subject if needed

if practice == 'y'
    % Tune volume
    
    Screen('DrawTexture',wPtr,text_sound_check);
    Screen('Flip', wPtr);
    pause(2);
    sound_param.S_one_sound.Vol = 60/1000;
    sound_param.S_one_sound.Dur1 = 3;
    [w , sample_rate] = sound_interface('WhiteNoise', sound_param , 'S_one_sound');
    sound(w,sample_rate);
    pause(1);
    sound_param.S_one_sound.Vol = 72/1000;
    [w , sample_rate] = sound_interface('WhiteNoise', sound_param , 'S_one_sound');
    sound(w,sample_rate);
    GetClicks(wPtr,0);
    sound_param.S_one_sound.Dur1 = 0.400;
    
    
    Screen('DrawTexture',wPtr,text_ins_practice);
    Screen('Flip', wPtr);
    
    GetClicks(wPtr,0);
    Screen('Flip', wPtr);
    
    for i = 1 : 6
        
        % display 'click when ready'
        Screen('TextSize',wPtr,44);
        Screen('TextStyle',wPtr,1); 
        DrawFormattedText(wPtr, text_start_tr ,'center', 'center', text_color);
        Screen('Flip', wPtr);
        
        GetClicks(wPtr,0);
        WaitSecs(0.5);
        
        % S1 presentation
        
        sound_param.S_one_sound.Vol = sound_sa_p(i)/1000;
        [w , sample_rate] = sound_interface('WhiteNoise', sound_param , 'S_one_sound');
        Screen('FillRect',wPtr,color_g_sq,rect_g_sq);
        
        % Draw square
        Screen('Flip',wPtr);
        % play sound one
        sound(w,sample_rate);
        
        
        % Delay Interval between S1 and S2
        
        % display 'Wait'
        Screen('TextSize',wPtr,60);
        Screen('TextStyle',wPtr,1); 
        DrawFormattedText(wPtr, text_wait ,'center', 'center', text_color);
        Screen('Flip', wPtr);
        WaitSecs(time_d2_p(i));
        
        
        % S2 presentation
        Screen('FillRect',wPtr,color_r_sq,rect_r_sq);
        sound_param.S_two_sound.Vol = sound_sb_p(i)/1000;
        [w , sample_rate] = sound_interface('WhiteNoise', sound_param , 'S_two_sound'  );
        
        % Draw square
        Screen('Flip',wPtr);
        % play sound Two
        sound(w,sample_rate);
        
        Screen('Flip',wPtr);
        WaitSecs(0.5);
        
        % display response screen
        Screen('FillRect',wPtr,color_r_sq,rect_r_sq);
        Screen('FillRect',wPtr,color_g_sq,rect_g_sq);
        Screen('Flip',wPtr);

        
        % get response
        
        while 1
            [clicks,xm,ym] = GetClicks(wPtr,0);
            if clicks == 1 ...
                    && ((xm >= rect_g_sq(1) && xm <= rect_g_sq(3)) ...
                    && (ym >= rect_g_sq(2) && ym <= rect_g_sq(4)))
                
                answer_p(i) = -1 ; % Sa is loader
                break;
            elseif clicks == 1 ...
                    && ((xm >= rect_r_sq(1) && xm <= rect_r_sq(3)) ...
                    && (ym >= rect_r_sq(2) && ym <= rect_r_sq(4)))
                
                answer_p(i) = 1 ; % Sb is loader
                break;
            end
        end
        Screen('Flip',wPtr);
        
        % Confidence level
        
        Screen('TextSize',wPtr,34);
        Screen('TextStyle',wPtr,1); 
        Screen('FillRect',wPtr,color_confi,rect_confi);
        Screen('DrawText',wPtr, text_confi_ques, xCenter-180, yCenter-230 ,text_color );
        Screen('Flip', wPtr);
        
        [newX,newY,textHeight] = Screen('DrawText',wPtr, text_confi_contin,xCenter-65, yCenter+225,text_color);
        txt_confi_level = []; xm = 0; ym = 0;
        buttons = 0; ex_butt = 0;
        while ~(~isempty(txt_confi_level) ...
                && (xm >= xCenter-60 && xm <= newX) ...
                && (ym >= newY && ym <= newY+textHeight)...
                && buttons(1) == 1 && ex_butt == 0)
            [xm,ym,buttons] = GetMouse;
            if (xm >= rect_confi(1) && xm <= rect_confi(3)) ...
                    && (ym >= rect_confi(2) && ym <= rect_confi(4))...
                    && buttons(1) ==1
                ex_butt = 1;
                Screen('FillRect',wPtr,color_confi_level,...
                    [rect_confi(1) ,ym , rect_confi(3) ,rect_confi(4)]);
                Screen('FillRect',wPtr,color_confi,...
                    [rect_confi(1) ,rect_confi(2) , rect_confi(3) ,ym]);
                txt_confi_level = strcat(num2str(round(((rect_confi(4) - ym)./...
                    (rect_confi(4)- rect_confi(2)))* 100)), '%');
                Screen('TextSize',wPtr,34);
                Screen('DrawText',wPtr, txt_confi_level,xCenter-30, yCenter-230,text_color );
                [newX,newY,textHeight] = Screen('DrawText',wPtr, text_confi_contin,xCenter-65, yCenter+225,text_color);
                Screen('Flip', wPtr);
            end
            ex_butt = 0;
        end
       
        WaitSecs(0.1);
        
        % feedback
        if choice_p(i) == answer_p(i)
            Screen('TextSize',wPtr,44);
            Screen('TextStyle',wPtr,1); % bold
            DrawFormattedText(wPtr, text_true ,'center', 'center', text_color_true);
            Screen('Flip', wPtr);
        else
            Screen('TextSize',wPtr,44);
            Screen('TextStyle',wPtr,1); % bold
            DrawFormattedText(wPtr, text_false ,'center', 'center', text_color_false);
            Screen('Flip', wPtr);
        end
        WaitSecs(0.5);
        Screen('Flip', wPtr);
    end
    
end

%% Run Main Experiment section

Screen('DrawTexture',wPtr,text_ins_main);
Screen('Flip', wPtr);

GetClicks(wPtr,0);
Screen('Flip', wPtr);
Screen('TextStyle',wPtr,1);

for j = 1 : bl_num

    for i = 1 : tri_in_block
        
        response((j-1)* tri_in_block +i).Block = j;
        response((j-1)* tri_in_block +i).Trial = (j-1)* tri_in_block +i;
        response((j-1)* tri_in_block +i).S1 = sound_db_s_a((j-1)* tri_in_block +i);
        response((j-1)* tri_in_block +i).S2 = sound_db_s_b((j-1)* tri_in_block +i);
        response((j-1)* tri_in_block +i).Delay_time = time_d2((j-1)* tri_in_block +i);
        response((j-1)* tri_in_block +i).True_choice = choice((j-1)* tri_in_block +i);
        
        % display 'click when ready'
        Screen('TextSize',wPtr,44);
        Screen('TextStyle',wPtr,1); % bold
        
         
        DrawFormattedText(wPtr, text_start_tr ,'center', 'center', text_color);
        Screen('Flip', wPtr);
       
       
        % Because on Mac sometimes there is lags and laptop hangs and 
        % there is no way to save updated data, below added to get rid 
        % of the force Matlab quit.
        % ***
        [click,x,y]= GetClicks(wPtr,0);
        if x> win_rect(3)-100  && y > win_rect(4)-100
            break;
        end
        % ***
        WaitSecs(0.5);
        
        % record timing - start trial 
        trial_start = tic;
        
        % S1 presentation
        sound_param.S_one_sound.Vol = sound_db_s_a((j-1)* tri_in_block +i)/1000;
        [w , sample_rate] = sound_interface('WhiteNoise', sound_param , 'S_one_sound');
        Screen('FillRect',wPtr,color_g_sq,rect_g_sq);
        
        % Draw square
        Screen('Flip',wPtr);
         % play sound one
        sound(w,sample_rate);
        
        
        % Delay Interval between S1 and S2
        
        % display 'Wait'
        Screen('TextSize',wPtr,60);
        Screen('TextStyle',wPtr,1); % bold
        DrawFormattedText(wPtr, text_wait ,'center', 'center', text_color);
        Screen('Flip', wPtr);
        WaitSecs(time_d2((j-1)* tri_in_block +i));
        
        
        % S2 presentation
        sound_param.S_two_sound.Vol = sound_db_s_b((j-1)* tri_in_block +i)/1000;
        Screen('FillRect',wPtr,color_r_sq,rect_r_sq);
        [w , sample_rate] = sound_interface('WhiteNoise', sound_param , 'S_two_sound'  );
        
        % Draw square
        Screen('Flip',wPtr);
        % play sound Two
        sound(w,sample_rate);
        
        
        Screen('Flip',wPtr);
        WaitSecs(0.5);
        
        % display response screen
        Screen('FillRect',wPtr,color_r_sq,rect_r_sq);
        Screen('FillRect',wPtr,color_g_sq,rect_g_sq);
        Screen('Flip',wPtr);

        t_elapsed = toc(trial_start);
        
        % get response
        
        while 1
            [clicks,xm,ym] = GetClicks(wPtr,0);
            if clicks == 1 ...
                    && ((xm >= rect_g_sq(1) && xm <= rect_g_sq(3)) ...
                    && (ym >= rect_g_sq(2) && ym <= rect_g_sq(4)))
                
                response((j-1)* tri_in_block +i).answer = -1 ; % Sa is loader
                response((j-1)* tri_in_block +i).RT = toc(trial_start) - t_elapsed;
                break;
            elseif clicks == 1 ...
                    && ((xm >= rect_r_sq(1) && xm <= rect_r_sq(3)) ...
                    && (ym >= rect_r_sq(2) && ym <= rect_r_sq(4)))
                
                response((j-1)* tri_in_block +i).answer = 1 ; % Sb is loader
                response((j-1)* tri_in_block +i).RT = toc(trial_start) - t_elapsed;
                break;
            end
        end
        Screen('Flip',wPtr);
        
        % Confidence level
        
        Screen('TextSize',wPtr,34);
        Screen('FillRect',wPtr,color_confi,rect_confi);
        Screen('DrawText',wPtr, text_confi_ques, xCenter-180, yCenter-230 ,text_color );
        Screen('Flip', wPtr);
        
        [newX,newY,textHeight] = Screen('DrawText',wPtr, text_confi_contin,xCenter-65, yCenter+225,text_color);
        txt_confi_level = []; xm = 0; ym = 0;
        buttons = 0; ex_butt = 0;
        while ~(~isempty(txt_confi_level) ...
                && (xm >= xCenter-60 && xm <= newX) ...
                && (ym >= newY && ym <= newY+textHeight)...
                && buttons(1) == 1 && ex_butt == 0)
            [xm,ym,buttons] = GetMouse;
            if (xm >= rect_confi(1) && xm <= rect_confi(3)) ...
                    && (ym >= rect_confi(2) && ym <= rect_confi(4))...
                    && buttons(1) ==1
                ex_butt = 1;
                Screen('FillRect',wPtr,color_confi_level,...
                    [rect_confi(1) ,ym , rect_confi(3) ,rect_confi(4)]);
                Screen('FillRect',wPtr,color_confi,...
                    [rect_confi(1) ,rect_confi(2) , rect_confi(3) ,ym]);
                txt_confi_level = strcat(num2str(round(((rect_confi(4) - ym)./...
                    (rect_confi(4)- rect_confi(2)))* 100)), '%');
                Screen('TextStyle',wPtr,1); % bold
                Screen('DrawText',wPtr, txt_confi_level,xCenter-30, yCenter-230,text_color );
                [newX,newY,textHeight] = Screen('DrawText',wPtr, text_confi_contin,xCenter-65, yCenter+225,text_color);
                Screen('Flip', wPtr);
            end
            ex_butt = 0;
        end
        response((j-1)* tri_in_block +i).confi_level = str2double(txt_confi_level(1:end-1));
        WaitSecs(0.1);
        
        % feedback
        if response((j-1)* tri_in_block +i).True_choice == response((j-1)* tri_in_block +i).answer
            response((j-1)* tri_in_block +i).HIT = 1;
            Screen('TextSize',wPtr,44);
            Screen('TextStyle',wPtr,1); % bold
            DrawFormattedText(wPtr, text_true ,'center', 'center', text_color_true);
            Screen('Flip', wPtr);
        else
            response((j-1)* tri_in_block +i).HIT = 0;
            Screen('TextSize',wPtr,44);
            Screen('TextStyle',wPtr,1); % bold
            DrawFormattedText(wPtr, text_false ,'center', 'center', text_color_false);
            Screen('Flip', wPtr);
        end
        WaitSecs(0.5);
        Screen('Flip', wPtr);
    end
    
    path_save_data = [f 'data_set_human' f 'temporary_data_save_folder' f];   
    save(strcat(path, path_save_data,...
            date,...
            '_',subject,...
            '_',num2str(j),...
            '_',num2str(toc(session_start)/60),...
            '_',exp_name,...
            '.mat'),'response');
end

save_y = 'y';
experiment_duration = toc(session_start) ;
text_finished = imresize(imread([path_text_files,f 'text_finished.png']),[win_rect(4),win_rect(3)]);
text_finished = Screen('MakeTexture',wPtr,text_finished);
Screen('DrawTexture',wPtr,text_finished);
Screen('Flip', wPtr);

GetClicks(wPtr,0);
Screen('CloseAll');

%% save
% save dataset

switch save_y
    case 'y'
        path_save_data = [f 'data_set_human' f subject f];
        
        save(strcat(path, path_save_data,...
            subject,...
            '_APWM',...
            '_',exp_name,...
            '_',date,...
            '.mat'),'response' , 'experiment_duration');
end

