function [adapt_flag,waveform,t_start] = sensation_retraction (mode,retraction,tip_dist,single_touch_dur,waveform,t_start,f,adapt_flag)
    
    if strcmp(mode,'adaptive')
        if(find(tip_dist<0)) % If whisker contacted object
            adapt_flag=1;
        end
    end
    
    motor_eff_copy_touch_dur=length(find(tip_dist(end-1000/(2*f):end)<0));
    
    if strcmp(retraction,'reactive')
        if (motor_eff_copy_touch_dur>single_touch_dur)
            cut=motor_eff_copy_touch_dur-single_touch_dur;
            waveform(end-cut:end,:)=[];
            t_start=t_start-cut/1000;
        end
    end
    
    if strcmp(retraction,'compliant')
        if (motor_eff_copy_touch_dur>single_touch_dur)
            % 
        end
    end