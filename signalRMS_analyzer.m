function best=signalRMS_analyzer(qh, qk,rangeK,rangeB,t_phase,cycle_duration)

nb=length(rangeB);
nk=length(rangeK);
RMS=zeros(nb,nk);


h_offset=29.1;
k_offset=24.127;
gen_Traj=mov_exo(cycle_duration,h_offset,k_offset);


for k=1:nk
    for b=1:nb
        
        qhi=qh{b,k};
        qki=qk{b,k};
        t=linspace(t_phase(1),t_phase(2),length(qhi));
      
        qh_ref=gen_Traj.get_hip_angle(t)';
        qk_ref=gen_Traj.get_knee_angle(t)';
        
        
        % Find the RMS
        rms_qh=sqrt(mean((qh_ref(:)-qhi(:)).^2));
        rms_qk=sqrt(mean((qk_ref(:)-qki(:)).^2));
        
        RMS(b,k)=rms_qh;%+rms_qk;
    end
end

% Find the best combination 
[~,idx]=min(RMS(:));
[bestB,bestK]=ind2sub(size(RMS),idx);

best=struct();
best.B=rangeB(bestB);
best.K=rangeK(bestK);

end