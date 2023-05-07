
%% This code is an analysis part of a psychophysic task named
%   Auditory parametric working memory 
%   for hunam subjects 

% list of sections:

% 1- Clear Workspace
% 2- Import a temporary .mat file to subject data-set. It is commented in
% normal situations.
% 3- Load Date-set 
%% clear
clear ; close ; clc
%% 2- Import a temporary .mat file to subject data-set
% This is for cases with uncompleted session

% % Choose the last .mat file saved for the subject
% [file, path] = uigetfile();
% load (strcat(path,file));
% 
% exp_name = input('Enter experimenter name:  ','s');
% date  = file(1:6);
% subject = file(8:14);
% 
% switch save_y
%     case 'y'
%         path_save_data = ['\data_set_human\' subject '\'];
%         
%         save(strcat(path, path_save_data,...
%             subject,...
%             '_APWM',...
%             '_',exp_name,...
%             '_',date,...
%             '.mat'),'response');
% end
%% Import Digit Span Task data 
%% Import PANAS data 
%% Import IVA data
%% 3- Load single sunbejct data
% Choose & load one subject data 
[file, path] = uigetfile();
load(strcat(path,file));
subject_id = file(1:6);
%% description single subject data 
stimuli_diff = [response.S1]-[response.S2];
sa_sb = unique(stimuli_diff);
% performance index  ( probablility of poking left side) 
var_h = [response.answer];
var_h([response.answer] == 1) = 0;
var_h([response.answer] == -1) = 1;
% confidence level index
var_c = [response.confi_level];
conf = [];
% rt index 
var_rt = [response.RT];
rt = [];
% delay-interval index 
var_delay = [response.Delay_time];
delays = unique(var_delay);
%% single subject 
labels = {'2s delay','6s delay','total delays'};

for i = 1 : size(sa_sb,2)    
    for j = 1 : length(delays)
        ind_h = ismember(stimuli_diff , sa_sb(i) );
        ind_h_del = ismember(var_delay , delays(j));
        perf(j,i) = sum(var_h(ind_h & ind_h_del) ) / length( var_h(ind_h & ind_h_del) );
        conf(j,i) = mean(var_c(ind_h & ind_h_del)) ;
        rt(j,i) = mean(var_rt(ind_h & ind_h_del)) ;
    end
    perf_dif(i) = sum(var_h(ind_h)) / length(var_h(ind_h));
    conf_dif(i) = mean(var_c(ind_h)) ;
    rt_dif(i) = mean(var_rt(ind_h)) ;
end
%% single subject plot

figure('Name', strcat('subject','_' ,subject_id));

subplot(1,3,1);
plot(sa_sb,perf); hold on;
plot(sa_sb,perf_dif,'LineWidth',2,'Color','k');
title(strcat('Performance-','subject-',subject_id),'FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);
xlabel('Sa-Sb','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);
ylabel('Performance (%)','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);    
legend(labels,'Location','best');
xticks(-12:2:12) ;
axis([-12 12 0 1]);

subplot(1,3,2);
plot(sa_sb,conf); hold on;
plot(sa_sb,conf_dif,'LineWidth',2,'Color','k');
title(strcat('Confidence level-','subject-',subject_id),'FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);
xlabel('Sa-Sb','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);
ylabel('Confidence level(%)','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);    
legend(labels,'Location','best');
xticks(-12:2:12) ;
axis([-12 12 0 100]);

subplot(1,3,3);
plot(sa_sb,rt);  hold on;
plot(sa_sb,rt_dif,'LineWidth',2,'Color','k'); 
title(strcat('RT-','subject-',subject_id),'FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);
xlabel('Sa-Sb','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);
ylabel('RT (s)','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);    
legend(labels,'Location','best');
xticks(-12:2:12) ;
axis([-12 12 0 4]);


%% behnaz - single human data - fit curve
beta0 = [-10 3 1 3];
x = sa_sb;
model_fun = @(b,x) b(1) + b(2) ./ (1 + exp((-1*(x-b(3))./b(4)))) ;

y_del1 = perf(1,:); 
y_del2 = perf(2,:);
y_dif = perf_dif; 

mdl_del1 = fitnlm(x,y_del1,model_fun,beta0);
mdl_del2 = fitnlm(x,y_del2,model_fun,beta0);
mdl_dif = fitnlm(x,y_dif,model_fun,beta0);

coef_del1 = mdl_del1.Coefficients.Estimate;
coef_del2 = mdl_del2.Coefficients.Estimate;
coef_dif = mdl_dif.Coefficients.Estimate;

Y_del1 = model_fun(coef_del1,x);
Y_del2 = model_fun(coef_del2,x);
Y_dif = model_fun(coef_dif,x);

%% single subject - plot fit curve
labels_fit_curve = {'2s delay','6s delay','total delays',...
    '2s delay-fit Curve','6s delay-fit Curve','total delays-fit Curve'};

figure('Name', strcat('subject','_' ,subject_id));
plot(sa_sb,perf(1,:),'b--o');
hold on;
plot(sa_sb,perf(2,:),'r--o');
hold on;
plot(sa_sb,perf_dif,'k--o');
hold on;
plot(x, Y_del1,'LineWidth',2,'Color','b'); 
hold on;
plot(x, Y_del2,'LineWidth',2,'Color','r'); 
hold on;
plot (x , Y_dif ,'LineWidth',2,'Color','k');
title(strcat('subject-' ,subject_id),'FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);
xlabel('Sa-Sb','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);
ylabel('Performance (%)','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);    
legend(labels_fit_curve,'Location','best');
xticks(-12:2:12) ;
axis([-12 12 0 1]);



%% load all subjects data
% Load all of the subjets data 
files_name = dir([path(1:end-7),'hwm*/','*APWM*']);
resp =[];
for i = 1 : size(files_name,1)
    load ([files_name(i).folder,'/',...
        files_name(i).name], 'response');
    subject = str2num(files_name(i).name(4:6));
        for j = 1 : size(response,2)
        response(j).subject = subject;
        end    
    resp = [resp,response];
end
%% excluding non_recorded trials 
resp(find(isempty([resp.RT]))) = []; 
%% population data description  
stimuli_diff = [resp.S1]-[resp.S2];
sa_sb = unique(stimuli_diff);
% performance index  ( probablility of poking left side) 
var_h = [resp.answer];
var_h([resp.answer] == 1) = 0;
var_h([resp.answer] == -1) = 1;
% confidence level index
var_c = [resp.confi_level];
conf = [];
% rt index 
var_rt = [resp.RT];
rt = [];
% delay-interval index 
var_delay = [resp.Delay_time];
delays = unique(var_delay);

%% population 
for i = 1 : size(sa_sb,2)    
    for j = 1 : length(delays)
        ind_h = ismember(stimuli_diff , sa_sb(i) );
        ind_h_del = ismember(var_delay , delays(j));
        perf(j,i) = sum(var_h(ind_h & ind_h_del) ) / length( var_h(ind_h & ind_h_del) );
        conf(j,i) = mean(var_c(ind_h & ind_h_del)) ;
        rt(j,i) = mean(var_rt(ind_h & ind_h_del)) ;
    end
    perf_dif(i) = sum(var_h(ind_h)) / length(var_h(ind_h));
    conf_dif(i) = mean(var_c(ind_h)) ;
    rt_dif(i) = mean(var_rt(ind_h)) ;
end

%% population plot 
figure('Name', 'Population');

subplot(1,3,1);
plot(sa_sb,perf); hold on;
plot(sa_sb,perf_dif,'LineWidth',2,'Color','k');
title('Population Performance','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);
xlabel('Sa-Sb','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);
ylabel('Performance (%)','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);    
legend(labels,'Location','best');
xticks(-12:2:12) ;
axis([-12 12 0 1]);

subplot(1,3,2);
plot(sa_sb,conf); hold on;
plot(sa_sb,conf_dif,'LineWidth',2,'Color','k');
title('Confidence level','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);
xlabel('Sa-Sb','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);
ylabel('Confidence level(%)','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);    
legend(labels,'Location','best');
xticks(-12:2:12) ;
axis([-12 12 0 100]);

subplot(1,3,3);
plot(sa_sb,rt);  hold on;
plot(sa_sb,rt_dif,'LineWidth',2,'Color','k'); 
title('RT','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);
xlabel('Sa-Sb','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);
ylabel('RT (s)','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);    
legend(labels,'Location','best');
xticks(-12:2:12) ;
axis([-12 12 0 4]);



%% behnaz - total human data - fit curve
beta0 = [-10 3 1 3];
x = sa_sb;
model_fun = @(b,x) b(1) + b(2) ./ (1 + exp((-1*(x-b(3))./b(4)))) ;

y_del1 = perf(1,:); 
y_del2 = perf(2,:);
y_dif = perf_dif; 

mdl_del1 = fitnlm(x,y_del1,model_fun,beta0);
mdl_del2 = fitnlm(x,y_del2,model_fun,beta0);
mdl_dif = fitnlm(x,y_dif,model_fun,beta0);

coef_del1 = mdl_del1.Coefficients.Estimate;
coef_del2 = mdl_del2.Coefficients.Estimate;
coef_dif = mdl_dif.Coefficients.Estimate;

Y_del1 = model_fun(coef_del1,x);
Y_del2 = model_fun(coef_del2,x);
Y_dif = model_fun(coef_dif,x);

%% Total subjects - plot fit curve
labels_fit_curve = {'2s delay','6s delay','total delays',...
    '2s delay-fit Curve','6s delay-fit Curve','total delays-fit Curve'};

figure('Name', 'Total subjects');
plot(sa_sb,perf(1,:),'b--o');
hold on;
plot(sa_sb,perf(2,:),'r--o');
hold on;
plot(sa_sb,perf_dif,'k--o');
hold on;
plot(x, Y_del1,'LineWidth',2,'Color','b'); 
hold on;
plot(x, Y_del2,'LineWidth',2,'Color','r'); 
hold on;
plot (x , Y_dif ,'LineWidth',2,'Color','k');
title('Total subjects','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);
xlabel('Sa-Sb','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);
ylabel('Performance (%)','FontSize',12,...
    'FontWeight','bold','Color',[0.4940 0.1840 0.5560]);    
legend(labels_fit_curve,'Location','best');
xticks(-12:2:12) ;
axis([-12 12 0 1]);