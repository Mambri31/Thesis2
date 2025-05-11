%% Find the torque of a 2 Dof model(user or exo)

function torque=dynamic_robot(coef,q1,q2,q1dot,q2dot,q1dotdot,q2dotdot)

matrici=matrix_MCG(coef,q1,q2,q1dot,q2dot);

%% Torque

torque=matrici{1}*[q1dotdot ;q2dotdot]+matrici{2}*[q1dot ;q2dot]+matrici{3};

end