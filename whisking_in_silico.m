function [tip_dist,waveform,locomotive_path] = whisking_in_silico(varargin)

%% This function simulates whisking in rodents. 
%This computational model provides a platform to adjust different parameters
%of whisking and explore their influence on whisker movements. Moreover,
%this simulator enables to explore between adaptive versus uniform whisking
%paradigms. In addition, user can explore the effect of comliant versus
%reactive retraction. %For further explanation please refere to 
%"Development of adaptive motor control for tactile navigation" by 
%Azarfar et.al

%% Run the model
% To run the model please select the whisking mode between 'adaptive' or 
%'uniform', and choose whether you want the model to run under 'reactive' or
% 'compliant' retraction. User can selcet to plot the results or not 
%(0: do not plot, 1: plot).
%Example 1:[tip_nose,waveform,nose_adapt] = whisking_in_silico('mode','adaptive','retraction','reactive','plotting',1)
%Example 2: [tip_nose,waveform,nose_adapt] = whisking_in_silico('mode','uniform','retraction','compliant','plotting',1)

%% Settings
% User can modify the whisking parameters in the "initialize" file. Two
% instance of  locomotive path for adaptive vs non adaptive whisking is provided.

%% Output: 
%tip_dist: is the distance from the tip of whisker to the target platform
% waveform: first column keeps the time, the second column keeps the angular
% position in relation to midline of whisker, the third and fourth columns
% contain the alpha of the fitted parabola and x position of the whisker's tip
% respectively, and finally the fifth column keeps the whisker's tip
% position in respect to animal's nose
% locomotive_path: is the locomotive path of animal twoards target. It is
% represented as the nose distance to the target.


for k = 1:length(varargin)
    if strcmpi(varargin{k},'mode')
        mode = varargin{k+1}; 
    end
    if strcmpi(varargin{k},'retraction')
        retraction = varargin{k+1}; 
    end
    if strcmpi(varargin{k},'plotting')
        plotting = varargin{k+1}; 
    end
end


[waveform,adapt_flag,no_free_whisk,t_start,init_phase,f_free,ret_free,pro_free,no_whisk,midline_angle,adapt_factor,duty_factor,ampl_mod_factor,caudal_dist, whisker_length,single_touch_dur,locomotive_path]=Initialize(mode);

% please change the directory in this file to the directory of the
% directory where you have cloned this project

%whisking
for it=1:no_whisk
    
    %% Retraction from midpoint
    
    [f,no_free_whisk,t_start,t_cont,t,angle_ret]=periodic_retraction(mode,t_start,init_phase,no_free_whisk,adapt_flag,adapt_factor,it,ampl_mod_factor,f_free,ret_free);
    
    last=length(waveform(:,1)); % save waveforms
    waveform([last+1:last+length(t)],1)=t_cont;% save waveforms
    waveform([last+1:last+length(t)],2)=angle_ret;% save waveforms
    t_start=t_start+(1/(2*f));% save waveforms
    
    %% Protraction from midpoint
    
    [f,no_free_whisk,t_start,t_cont,t,angle_pro]=periodic_protraction(mode,t_start,init_phase,adapt_flag,it,no_free_whisk,adapt_factor,ampl_mod_factor,duty_factor,f_free,pro_free);
    
    last=length(waveform(:,1));% save waveforms
    waveform([last+1:last+length(t)],1)=t_cont;% save waveforms
    waveform([last+1:last+length(t)],2)=smooth(angle_pro,20);% save waveforms
    t_start=t_start+(1/(2*f));% save waveforms
    
    %% Map generated protraction and retraction phase into whisker movement
    
    [waveform,nose_adapt,tip_dist]=map_whisker_parabola(waveform,midline_angle,whisker_length,ret_free,locomotive_path,caudal_dist);
    
    %% sensation and adaptive whisker retraction
    
    [adapt_flag,waveform,t_start]=sensation_retraction(mode,retraction,tip_dist,single_touch_dur,waveform,t_start,f,adapt_flag);
    
end

%% waeforms ready to plot
clear tip_dist
tip_dist=-smooth(waveform(:,5))*10+nose_adapt(1:length(waveform(:,5)))+caudal_dist;

waveform(:,2)=smooth(waveform(:,2),20);
waveform(:,6)=nose_adapt(1:length(waveform(:,1)),1);

%% plots
if (plotting ==1)
    figure;
    waveform(:,2)=smooth(waveform(:,2));
    
    hold on
    plot(waveform(:,1),waveform(:,2),'b') % angular
    title('angular position');xlabel('Time(s)');ylabel('Deflection angle (deg)');
    waveform(:,5)=smooth(waveform(:,5));
    
    figure
    hold on
    plot(waveform(:,1),waveform(:,5),'b'); % tip position
    title('Tip position from base');xlabel('Time(s)');ylabel('position (cm)');
    tip_dist=-smooth(waveform(:,5))*10+waveform(:,6)+caudal_dist; % 9 for caudal distance between the nose and the whisker
    
    figure
    plot(waveform(:,1),tip_dist,'b'); % tip position
    title('Tip position to target');xlabel('Time(s)');ylabel('Distance to target (mm)');
    hold on
    plot (waveform(:,1),waveform(1:length(waveform(:,5)),6),'r')
    plot (waveform(:,1),zeros(1,length(waveform(:,5))),'k')
end
