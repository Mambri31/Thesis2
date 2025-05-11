%% Find q1dotdot e q2dotdot from inverse kinematics of the exo

function [q1dotdot, q2dotdot]=inverse_dynamics(coef,torque,q1,q2,q1dot,q2dot)

%tau=M*q''+C*q'+g  q''=M^-1*(tau-C*q'-g)

matrici=matrix_MCG(coef,q1,q2,q1dot,q2dot);

invM=inv(matrici{1});

qdotdot=invM*(torque-matrici{2}*[q1dot ;q2dot]-matrici{3});

q1dotdot=qdotdot(1);
q2dotdot=qdotdot(2);

end