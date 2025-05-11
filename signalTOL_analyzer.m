%% Finds which vector as more points whitin a given tolerance range

function best=signalTOL_analyzer(qh,qk,rangeK,rangeB,tolerance,t_phase,cycle_duration)

error_matrix_qh=cell_error_maker(qh,qk,rangeK,rangeB,1,t_phase,cycle_duration);
error_matrix_qk=cell_error_maker(qh,qk,rangeK,rangeB,0,t_phase,cycle_duration);

points=zeros(size(error_matrix_qh,1),size(error_matrix_qh,2));

error_matrix_qh=cellfun(@rad2deg,error_matrix_qh,'UniformOutput',false);
error_matrix_qk=cellfun(@rad2deg,error_matrix_qk,'UniformOutput',false);



for k=1:size(error_matrix_qk,2)
    for b=1:size(error_matrix_qh,1)
        vec1=error_matrix_qh{b,k};
        vec2=error_matrix_qk{b,k};
        indx1=find(vec1(:)<=max(tolerance) & vec1(:)>=min(tolerance));
        indx2=find(vec2(:)<=max(tolerance) & vec2(:)>=min(tolerance));
        points(b,k)=(length(indx1)/length(vec1))*100;%+length(indx2))/(+length(vec2)))*100;
    end
end


% Find the best combination
[~,idx]=max(points(:));


[bestB, bestK] = ind2sub(size(points), idx);
best=struct();

% Gives back the best result
best.B = rangeB(bestB);
best.K = rangeK(bestK);



end