
%% Human Auditory Working Memory Task 
% ** Without fixation point(+),...
% ** With each trial feedback, ...
% ** With red and green square association when stimulus onset
% ** This task need mouse for getting response

% The subject self-initiated each trial by pressing the left key on the mouse.
% The first sound is then presented together with a green square ...
%       on the left side of a computer monitor in front of the subject.
% A delay period, indicated by ‘WAIT!’ on the screen
% the second sound is presented together ...
%       with a red square on the right side of the screen.
% After displying green and red squares together,
% subject indicate choice by clicking on the green square ...
%       (left side-first sound was louder) or ...
%       the green square (right side-second sound was louder)
% Then a question will be asked about the level confidence while ...
%       responding to the trial. 
% At the end of every trial, a written feedback is displayed....
%       ("False" with purple color and "True" with turquoise color)

%% clear and get path
clearvars; clc;

path = cd;
addpath(genpath([path '/Human_task']));
addpath(genpath([path '/General']));
load(strcat(path ,'/General/sound_param.mat'));

%% settings - basic items of experiment

exp_name = input('Enter experimenter name:  ','s');
subject = input('Enter subject name:  ', 's');
Instruction = input('Do you need to read instruction? (y/n)','s');
practice = input( 'Do you need to practice? (y/n)','s');

date = datestr(now, 'yymmdd');
training_stage = 'human';

% need trial num and block for every stage

tri_num = 10;
tri_in_block = 10;
bl_num = tri_num / tri_in_block ;

%% Stage (This part is set for testing...
%  fixed 1st stimulus and variable 2nd stimulus ( stage = {'Sa_fix'} )
%  fixed 2nd stimulus and variable 1st stimulus ( stage = {'Sb_fix'} )
%  variable 1st and 2nd stimuli ( stage = {'Sb_fix'} )

stage = {'Sa_fix' , 'Sb_fix' ,'Sa_Sb'};

%% texts content

text_ins1 = ['A pair of audios will be played with a random delay in every trial\n' ...
    '   \n'...
    'along with a green square on the left side and \n'...
    '   \n'...
    'a red square on the left side. \n'...
    '   \n'...
    'Click on the "Green" square when the first one is louder than second one.\n' ...
    '   \n'...
    'and Click on the "Red" square if the second one is louder than first one.\n'...
    '   \n'...
    '   \n'...
    '   \n'...
    '   \n'...
    'Click to continue'];
text_ins_confid = [ 'After your response, a question will be asked \n'...
    '   \n'...
    'about level of confidence while responsing. \n'...
    '   \n'...
    'you should move slider to define your confidence level. \n'...
    '   \n'...
    '   \n'...
    '   \n'...
    '   \n'...
    'Click to continue'];
text_ins_feedbck = ['You will be provided by the feedback , \n'...
    '   \n'...
    '"TRUE" if your response is correct, \n'...
    '   \n'...
    'and "FALSE" if your response is wrong. \n'...
    '   \n'...
    '   \n'...
    '   \n'...
    '   \n'...
    'Click to continue'];

text_ins_practice = ['First, have some practice to get accustomed to the task...\n'...
    '   \n'...
    '   \n'...
    '   \n'...
    '   \n'...
    'Click when ready'];
text_ins_main = ['Now the main experiment will be start.\n'...
    '   \n'...
    '   \n'...
    '   \n'...
    '   \n'...
    'Click when ready'];
% text_ins_block1 = ['First Block....\n'...
%          '   \n'...
%          '   \n'...
%          '   \n'...
%          '   \n'...
%          'Click when ready'];
% text_ins_block2 = ['Second Block....\n'...
%          '   \n'...
%          'You can have a few minutes off.\n'...
%          '   \n'...
%          '   \n'...
%          '   \n'...
%          '   \n'...
%          'Click when you ready'];
% text_ins_block3 = ['Third Block....\n'...
%          '   \n'...
%          'You can have a few minutes off.\n' ...
%          '   \n'...
%          '   \n'...
%          '   \n'...
%          '   \n'...
%          'Click when you ready'];

text_save = 'Do you want to save data?(y/n) ?';
text_start_tr = 'Click when ready';
text_wait = 'Wait!';
text_true = 'True';
text_false = 'False';
text_confi_ques = 'How much are you sure?';
text_confi_contin = 'Continue';
text_sound_check = ['Please tune the volume of the headphone.\n'...
    '   \n'...
    'The volume should neither be too high to discomfort you;\n'...
    '   \n'...
    'nor too low to have difficulty hearing sounds.'...
    '   \n'...
    '   \n'...
    '   \n'...
    '   \n'...
    'Click to continue'];


%% settings - keyboard
KbName('UnifyKeyNames');
KbDeviceIndex = [];

exit_key = KbName('ESCAPE');
pause_key = KbName('space');
save_key = KbName('y');

%% settings - delay interval

% practice
time_d2_p = [2,2,2,6,6,6];

% Sa_fix

% Sb_fix


% Sa_Sb
% function "delay2_duration" can be use to generate delay interval time.
% but here I prefere not to use it.

% build delay2 array
delay_time = [2,6]';
num_del_time = length(delay_time);
time_d2 = Shuffle(repmat(delay_time,[(tri_num / num_del_time), 1]));
time_d2 = reshape(time_d2,[bl_num,tri_in_block]);

%% settings - stimuli

% ** This stimuli pairs as used in Akrami's experiment
% sound_db = {[60,62.7];...
%     [62.7,65.4];...
%     [65.4,68.1];...
%     [68.1,70.8];...
%     [70.8,73.5];...
%     [73.5,70.8];...
%     [70.8,68.1];...
%     [68.1,65.4];...
%     [65.4,62.7];...
%     [62.7,60]};  % [S_a,S-b]

% But here I consider a different figures for sound db:
ss = (60:2:72);

% I have different sound_table stimulus for different part of experiment

% practice part sound_table

sound_sa_p = [62 72 62 72 70 60 ];
sound_sb_p = [72 60 66 66 60 70 ];
choice_p   = [1  -1  1 -1 -1  1 ];

% % Sa is fix but Sb is variable
% % Sa_fix

% % Sb is fix but Sa is variable
%
% % Sb_fix


% ** both Sa and Sb are variable
% Sa_Sb

sound_db_a = repmat(ss,1,7);
sound_db_b = repmat(ss,7,1);
sound_db_b=sound_db_b(:)';
for i= 1:size(sound_db_b,2)
    sound_db{i,:}=[sound_db_a(i) sound_db_b(i)];
end

[sound_db_s_a,sound_db_s_b,choice] = sound_db_table(...
    sound_db,...
    bl_num,...
    tri_in_block);

%% settings - Screen 

Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference', 'ConserveVRAM', 1 ); %1 == kPsychDisableAUXBuffers
%Screen('Preference', 'ConserveVRAM', 2); %2 == kPsychDontCacheTextures

Screen('Screens');
ScreenNumber = max(Screen('Screens'));
[width, height]=Screen('WindowSize',ScreenNumber);
win_rect = [0 0 width-20 height];
win_color = 128;
[wPtr,rect] = Screen('OpenWindow',ScreenNumber, win_color, win_rect);


% Get the center coordinate of the window
[xCenter, yCenter] = RectCenter(win_rect);

% squares settings
color_g_sq = [0 255 0];
color_r_sq = [255 0 0];
rect_g_sq = [ xCenter/2 - 30 ,yCenter-50 , xCenter/2 + 70 ,yCenter + 50];
rect_r_sq = [ (xCenter *3) /2 - 70  ,yCenter-50 , (xCenter *3) /2  + 30 ,yCenter+50];

% set confidence level screen
rect_confi = [xCenter - 30 ,yCenter - 200 , xCenter + 30 ,yCenter + 200];
color_confi =  WhiteIndex(wPtr);
color_confi_level = [50 250 100];

% set texts format
Screen('TextFont',wPtr,'Calibri');
Screen('TextStyle',wPtr,0); % regular font style
% Screen('TextFont',wPtr,'Helvetica');
text_color       = 255;
text_color_true  = [64 224 208];
text_color_false = [128,0,128];


%% experiment running

session_start = tic;


%% Pause and Exit Option
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
    
    Screen('TextSize',wPtr,24);
    DrawFormattedText(wPtr, text_ins1 ,'center', 'center', text_color);
    Screen('Flip', wPtr);
    
    GetClicks(wPtr,0);
    
    Screen('Flip', wPtr);
    
    
    DrawFormattedText(wPtr, text_ins_confid ,'center', 'center', text_color);
    Screen('Flip', wPtr);
    
    GetClicks(wPtr,0);
    
    Screen('Flip', wPtr);
    
    
    DrawFormattedText(wPtr, text_ins_feedbck ,'center', 'center', text_color);
    Screen('Flip', wPtr);
    
    GetClicks(wPtr,0);
    
    Screen('Flip', wPtr);
    
end
%% Run Practice section

% Running 6 easy trials for training subject if needed

if practice == 'y'
    % Tune volume
    DrawFormattedText(wPtr, text_sound_check ,'center', 'center', text_color);
    Screen('Flip', wPtr);
    pause(3);
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
    
    DrawFormattedText(wPtr, text_ins_practice ,'center', 'center', text_color);
    Screen('Flip', wPtr);
    
    GetClicks(wPtr,0);
    Screen('Flip', wPtr);
    
    for i = 1 : 6
        
        % display 'click when ready'
        Screen('TextSize',wPtr,30);
        Screen('TextStyle',wPtr,1); % bold
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
        Screen('TextSize',wPtr,48);
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
        
        Screen('TextSize',wPtr,24);
        Screen('TextStyle',wPtr,1);
        Screen('FillRect',wPtr,color_confi,rect_confi);
        Screen('DrawText',wPtr, text_confi_ques, xCenter-160, yCenter-230 ,text_color );
        Screen('Flip', wPtr);
        
        [newX,newY,textHeight] = Screen('DrawText',wPtr, text_confi_contin,xCenter-60, yCenter+225,text_color);
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
                Screen('DrawText',wPtr, txt_confi_level,xCenter-30, yCenter-230,text_color );
                [newX,newY,textHeight] = Screen('DrawText',wPtr, text_confi_contin,xCenter-60, yCenter+225,text_color);
                Screen('Flip', wPtr);
            end
            ex_butt = 0;
        end
       
        WaitSecs(0.1);
        
        % feedback
        if choice_p(i) == answer_p(i)
            Screen('TextSize',wPtr,40);
            Screen('TextStyle',wPtr,1); % bold
            DrawFormattedText(wPtr, text_true ,'center', 'center', text_color_true);
            Screen('Flip', wPtr);
        else
            Screen('TextSize',wPtr,40);
            Screen('TextStyle',wPtr,1); % bold
            DrawFormattedText(wPtr, text_false ,'center', 'center', text_color_false);
            Screen('Flip', wPtr);
        end
        WaitSecs(0.5);
        Screen('Flip', wPtr);
    end
    
end

%% Run Main Experiment section

Screen('TextSize',wPtr,24);
Screen('TextStyle',wPtr,0);
DrawFormattedText(wPtr, text_ins_main ,'center', 'center', text_color);
Screen('Flip', wPtr);

GetClicks(wPtr,0);
Screen('Flip', wPtr);

for j = 1 : bl_num
    for i = 1 : tri_in_block
        
        response(j,i).Block = j;
        response(j,i).Trial = i;
        response(j,i).S1 = sound_db_s_a(j,i);
        response(j,i).S2 = sound_db_s_b(j,i);
        response(j,i).Delay_time = time_d2(j,i);
        response(j,i).True_choice = choice(j,i);
        
        % display 'click when ready'
        Screen('TextSize',wPtr,30);
        Screen('TextStyle',wPtr,1); % bold
        DrawFormattedText(wPtr, text_start_tr ,'center', 'center', text_color);
        Screen('Flip', wPtr);
       
        % Because on Mac sometimes there is lags and laptop hangs and... 
        % there is no way to save updated data, below added to get rid ...
        % of the force Matlab quit.
        % ***
        [click,x,y]= GetClicks(wPtr,0);
        if x> 1300 && y > 800
            break;
        end
        % ***
        WaitSecs(0.5);
        
        % record timing - start trial 
        trial_start = tic;
        
        % S1 presentation
        sound_param.S_one_sound.Vol = sound_db_s_a(j,i)/1000;
        [w , sample_rate] = sound_interface('WhiteNoise', sound_param , 'S_one_sound');
        Screen('FillRect',wPtr,color_g_sq,rect_g_sq);
        
        % Draw square
        Screen('Flip',wPtr);
         % play sound one
        sound(w,sample_rate);
        
        
        % Delay Interval between S1 and S2
        
        % display 'Wait'
        Screen('TextSize',wPtr,48);
        DrawFormattedText(wPtr, text_wait ,'center', 'center', text_color);
        Screen('Flip', wPtr);
        WaitSecs(time_d2(j,i));
        
        
        % S2 presentation
        sound_param.S_two_sound.Vol = sound_db_s_b(j,i)/1000;
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
                
                response(j,i).answer = -1 ; % Sa is loader
                response(j,i).RT = toc(trial_start) - t_elapsed;
                break;
            elseif clicks == 1 ...
                    && ((xm >= rect_r_sq(1) && xm <= rect_r_sq(3)) ...
                    && (ym >= rect_r_sq(2) && ym <= rect_r_sq(4)))
                
                response(j,i).answer = 1 ; % Sb is loader
                response(j,i).RT = toc(trial_start) - t_elapsed;
                break;
            end
        end
        Screen('Flip',wPtr);
        
        % Confidence level
        
        Screen('TextSize',wPtr,24);
        Screen('FillRect',wPtr,color_confi,rect_confi);
        Screen('DrawText',wPtr, text_confi_ques, xCenter-160, yCenter-230 ,text_color );
        Screen('Flip', wPtr);
        
        [newX,newY,textHeight] = Screen('DrawText',wPtr, text_confi_contin,xCenter-60, yCenter+225,text_color);
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
                Screen('DrawText',wPtr, txt_confi_level,xCenter-30, yCenter-230,text_color );
                [newX,newY,textHeight] = Screen('DrawText',wPtr, text_confi_contin,xCenter-60, yCenter+225,text_color);
                Screen('Flip', wPtr);
            end
            ex_butt = 0;
        end
        response(j,i).confi_level = str2double(txt_confi_level(1:end-1));
        WaitSecs(0.1);
        
        % feedback
        if response(j,i).True_choice == response(j,i).answer
            response(j,i).HIT = 1;
            Screen('TextSize',wPtr,40);
            DrawFormattedText(wPtr, text_true ,'center', 'center', text_color_true);
            Screen('Flip', wPtr);
        else
            response(j,i).HIT = 0;
            Screen('TextSize',wPtr,40);
            DrawFormattedText(wPtr, text_false ,'center', 'center', text_color_false);
            Screen('Flip', wPtr);
        end
        WaitSecs(0.5);
        Screen('Flip', wPtr);
    end
    
    path_save_data = strcat('/data_set_human/');   
    save(strcat(path, path_save_data,...
            date,...
            '_',subject,...
            '_',num2str(j),...
            '_',exp_name,...
            '.mat'),'response');
end

save_y = 'y';

experiment_duration = toc(session_start) ;
Screen('CloseAll');


%% save
% save dataset

switch save_y
    case 'y'
        path_save_data = strcat('/data_set_human/');
        
        save(strcat(path, path_save_data,...
            date,...
            '_',subject,...
            '_',exp_name,...
            '.mat'),'response');
end

