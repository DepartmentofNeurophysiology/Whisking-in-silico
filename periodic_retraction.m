function [f,no_free_whisk,t_start,t_cont,t,angle_ret]=periodic_retraction(mode,t_start,init_phase,no_free_whisk,adapt_flag,adapt_factor,it,ampl_mod_factor,f_free,ret_free);
    
    if strcmp(mode,'uniform')
        adapt=0; %no adaptation
        f=f_free; % frequency of free whisking
        amp_mod=1; %no amplitude modulation
        no_free_whisk=no_free_whisk+1;
    end
    
    if strcmp(mode,'adaptive')
        if (adapt_flag==0) % If S1 has not sensed contact yet
            adapt=0; %no adaptation
            f=f_free; % frequency of free whisking
            amp_mod=1; %no amplitude modulation
            no_free_whisk=no_free_whisk+1;
        else
            adapt=-((it-no_free_whisk)*adapt_factor);
            amp_mod=1-((it-no_free_whisk)*ampl_mod_factor); %amplitude modulation
            f=f_free; %no frequency modulation, could be changed accordingly
        end
    end
    
    t_cont = (t_start:0.001:t_start+(1/(2*f)))'; %time update
    t = (0:0.001:0+(1/(2*f)))';
    angle_ret = amp_mod*ret_free* sin(2*pi*f*t+init_phase)+adapt; %Modulated whisking pattern