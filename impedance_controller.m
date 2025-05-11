%% Low impedance controller


function torque=impedance_controller(Kh,Bh,Kk,Bk,eh,ek,ehdot,ekdot)

torque=[Kh.*eh+Bh.*ehdot;Kk.*ek+Bk.*ekdot];
end