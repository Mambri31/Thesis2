%% Returns (K,B) combination with max cross-correlation


function best=signalCROSS_analyzer(qh,qk,rangeK,rangeB,t_phase,cycle_duration)

nb=length(rangeB);
nk=length(rangeK);

CROSS=zeros(nb,nk);


h_offset=29.1;
k_offset=24.127;
gen_Traj=mov_exo(cycle_duration,h_offset,k_offset);


for k=1:nk
for b=1:nb     
      % This part is to avoid error related to the variable step size
      qhi=qh{b,k};
      qki=qk{b,k};
      t=linspace(t_phase(1),t_phase(2),length(qhi));
      
      qh_ref=gen_Traj.get_hip_angle(t)';
      qk_ref=gen_Traj.get_knee_angle(t)';
      
      % Cross-correlation
      [c1,~]=xcorr(qh_ref,qhi,'coeff');     
      [c2,~]=xcorr(qk_ref,qki,'coeff');
      points1=max(c1);
      points2=max(c2);
      CROSS(b,k)=points1;%+points2;
end

end

[~,idx]=max(CROSS(:));
[bestB,bestK]=ind2sub(size(CROSS),idx);

best=struct();

% Returns the best combination
best.B = rangeB(bestB);
best.K = rangeK(bestK);

end