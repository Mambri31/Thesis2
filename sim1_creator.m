%% Create and compute some model in defined range of K and B

function out=sim1_creator(model,rangeK,rangeB,coef,qh,qk,qhdot,qkdot)

nk=length(rangeK);
nb=length(rangeB);

%Create a vector of model

numSim=nk*nb;
simIn(numSim)=Simulink.SimulationInput(model);
indx=1;

%Modify the models in order to simulate them with specified caratheristics

for k=1:nk
    for b=1:nb
        
        Ki=rangeK(k);
        Bi=rangeB(b);
       
        %Setting the variable
        
        simIn(indx)=Simulink.SimulationInput(model);
        simIn(indx)=simIn(indx).setVariable('Khip', Ki);
        simIn(indx)=simIn(indx).setVariable('Bhip', Bi);
        simIn(indx)=simIn(indx).setVariable('Kknee', Ki);
        simIn(indx)=simIn(indx).setVariable('Bknee', Bi);
        simIn(indx)=simIn(indx).setVariable('coef', coef);
        simIn(indx)=simIn(indx).setVariable('qh', qh);
        simIn(indx)=simIn(indx).setVariable('qk', qk);
        simIn(indx)=simIn(indx).setVariable('qhdot', qhdot);
        simIn(indx)=simIn(indx).setVariable('qkdot', qkdot);
        simIn(indx)=simIn(indx).setModelParameter('StartTime', '0', 'StopTime', '10', 'Solver', 'ode45',  'SolverType', 'Variable-step', 'RelTol', '1e-3',   'AbsTol', '1e-6');      
        indx=indx+1;
       
    end
end

%Uses the parallel computer toolbox, in order to be faster

out=parsim(simIn, ...
             'ShowProgress', true,...
             'UseFastRestart', false);

save output out

end
