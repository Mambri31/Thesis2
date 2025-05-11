%% Starting from the outputs of some models, it creates a cell of error vectors

function cells=cell_error_maker(qh,qk,rangeK,rangeB,H_K,t_phase,cycle_duration)

nk=length(rangeK);
nb=length(rangeB);
cells=cell(nb,nk);

% Class costant

h_offset=29.1;
k_offset=24.127;
gen_Traj=mov_exo(cycle_duration,h_offset,k_offset);



if H_K==1 %Hip
   for k=1:nk
       for b=1:nb
           
           qhi=qh{b,k};
           t=linspace(t_phase(1),t_phase(2),length(qhi));
      
           qh_ref=gen_Traj.get_hip_angle(t)';
           
           error=qh_ref(:)-qhi(:);
           cells{b,k}=error;
       end
   end


elseif H_K==0 %Knee
   for k=1:nk
       for b=1:nb
           qki=qk{b,k};
           
           t=linspace(t_phase(1),t_phase(2),length(qki));
      
           qk_ref=gen_Traj.get_knee_angle(t)';
           error=qk_ref(:)-qki(:);
           cells{b,k}=error;
       end
   end
else
    
    disp('Error H_K has to be 1(Hip) or 0(Knee)')

end
      


end