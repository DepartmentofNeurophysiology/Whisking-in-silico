function [waveform,locomotive_path,tip_dist]=map_whisker_parabola(waveform,midline_angle,whisker_length,ret_free,locomotive_path,caudal_dist)
    
    % maps the sinosoid of CPG and adaptation of M1 into whisker movement
    %% Learned map
    map_ret(1,:)=1:1:45; %45=~maximum deflection angle %map guide to sine (retraction angle to midline)
    map_ret(2,:)=-(1/45)*0.075:-(1/45)*0.075:-0.075; % alpha in parabola for C2
    map_ret(3,:)=4:-(1/45)*0.45:3.55+(1/45)*0.45; % x of parabola mapped and calculated based on length =4
    
    map_pro(1,:)=-1:-1:-45;
    map_pro(2,:)=(1/45)*0.075:(1/45)*0.075:0.075;
    map_pro(3,:)=4:-(1/45)*0.45:3.55+(1/45)*0.45;
    
    map=[map_ret,map_pro];
    
    %% Form whisker points
    for k=1:length(waveform(:,1))
        
        tmp = abs(map(1,:)-waveform(k,2));
        [M ind] = min(tmp);
        waveform(k,3)=map(2,ind); %alpha of parabola
        waveform(k,4)=map(3,ind); %x
        waveform(k,5)=map(2,ind)*map(3,ind)^2*cosd(midline_angle)+whisker_length*sind(midline_angle-waveform(k,2)+ret_free); %y (tand(15)*4 is the end of the midline the whisker swings around.
    end
    
    locomotive_path=[locomotive_path(:,1);zeros(1500-length(locomotive_path),1)];
    tip_dist=-smooth(waveform(:,5))*10+locomotive_path(1:length(waveform(:,5)))+caudal_dist;
    
    
