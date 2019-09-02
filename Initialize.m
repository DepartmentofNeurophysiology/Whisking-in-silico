function [waveform,adapt_flag,no_free_whisk,t_start,init_phase,f_free,ret_free,pro_free,no_whisk,midline_angle,adapt_factor,duty_factor,ampl_mod_factor,caudal_dist, whisker_length,single_touch_dur,locomotive_path]=Initialize(mode)
    
    
    %% suggested values for C2 whisker
    t_start=0; %starting time
    init_phase=0;
    f_free=10; %Hz  free whisking frequency
    ret_free=23; %maxium retraction anngle relative to midline in free whisking
    pro_free=23; %maxium protraction anngle relative to midline in free whisking
    no_whisk=8;  %total number of whisk
    midline_angle=15; %the angle between the midline the whisker swings around and the line perpendicular to the face at the whisker's base
    adapt_factor=3.5; %adaptation factor: angle increase in case of adaptation for each whisk
    duty_factor=0.15; %adaptation factor: the increse in duty cycle in case of adaptation
    ampl_mod_factor=0.055; %amplitude modulation factore
    caudal_dist=9; %the caudal distance between the nose and the base of the whisker
    whisker_length = 4;
    single_touch_dur = 30;
    
    load('D:\phd\Whisking-in-silico\nose5.mat') %loads representative body navigation pattern for adaptive and non-adaptive whisking
    
    if strcmp(mode,'uniform')
        locomotive_path = nose_non_adapt;
    end
    
    if strcmp(mode,'adaptive')
        locomotive_path = nose_adapt;
    end
    
    waveform(1,2)=0;
    adapt_flag=0;
    no_free_whisk=0;