%% Returns (K,B) combination that minimize the mean absolut error

function best=signalMAE_analyzer(qh,qk,rangeK,rangeB,t_phase,cycle_duration)

nb=length(rangeB);
nk=length(rangeK);

error_matrix_qh=cell_error_maker(qh,qk,rangeK,rangeB,1,t_phase,cycle_duration);
error_matrix_qk=cell_error_maker(qh,qk,rangeK,rangeB,0,t_phase,cycle_duration);


error_matrix_qh=cellfun(@rad2deg,error_matrix_qh,'UniformOutput',false);
error_matrix_qk=cellfun(@rad2deg,error_matrix_qk,'UniformOutput',false);

meanError=zeros(nb,nk);

for k=1:nk
for b=1:nb
      meanError_qh=mean(abs(error_matrix_qh{b,k}));
      meanError_qk=mean(abs(error_matrix_qk{b,k}));
      meanError(b,k)=meanError_qh;%+meanError_qk;
end
end

[~,idx]=min(meanError(:));
[bestB,bestK]=ind2sub(size(meanError),idx);


best=struct();

% Returns the best combination
best.B=rangeB(bestB);
best.K=rangeK(bestK);



end