%% Find the best (K,B) in center time of the most important gait phases
% Using RMS
function [Kt,Bt]=variable_impedanceRMS(qh,qk,rangeK,rangeB,t,cycle_duration)

    % Percentage of gait cycle phases
    perc = [0 10 30 50 60 73 87 100]*0.01;
    n_phase=length(perc);

    sample=length(t); % fixed number of points

    nk=length(rangeK);
    nb=length(rangeB);

    % Output vectors
    Kt=zeros(sample,1);
    Bt=zeros(sample,1);

    % Intermediate storage for adaptive impedance
    Ki=[];
    Bi=[];

    for l=1:n_phase-1
        matrix_qh=cell(nb,nk);
        matrix_qk=cell(nb,nk);

        % Phase interval indices
        Start=round(perc(l)*sample)+1;
        End=round(perc(l+1)*sample);

        for k=1:nk
            for b=1:nb
                % Interpolation on fixed time grid
                qh_interp=interp1(linspace(0,cycle_duration,length(qh{b,k})),qh{b,k},t,'linear','extrap');
                qk_interp=interp1(linspace(0,cycle_duration,length(qk{b,k})),qk{b,k},t,'linear','extrap');

                % Extract phase segment
                matrix_qh{b,k}=qh_interp(Start:End);
                matrix_qk{b,k}=qk_interp(Start:End);
            end
        end
        t_phase=[perc(l),perc(l+1)].*cycle_duration;
        % Analyze phase to find best (K,B)
        best=signalRMS_analyzer(matrix_qh,matrix_qk,rangeK,rangeB,t_phase,cycle_duration);

        % Store result
        Ki=[Ki,best.K];
        Bi=[Bi,best.B];
    end

    % Compute center times of gait phases
    center_times=round(((perc(1:end-1)+perc(2:end))/2)*sample);

    % Interpolate impedance values across the full cycle
    Kt=interp1(center_times,Ki,1:sample,'linear','extrap')';
    Bt=interp1(center_times,Bi,1:sample,'linear','extrap')';

end
