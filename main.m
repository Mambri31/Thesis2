%% Create all the variable for simulink

clear all
close all
clc

H_K=load('H_K') ;% Load the best costant gain combination

Kt=load('Kt'); % Load the best variable impedance(K(t))
Bt=load('Bt'); % Load the variable impedance(B(t))


% Patient caratheristics
height=1.8;
weight=85;

%Settings for the class
cycle_duration=10;
h_offset=29.1;
k_offset=24.127;

gen_Traj=mov_exo(cycle_duration,h_offset,k_offset);

% Time vector
t=linspace(0,cycle_duration,1000);

%% Coefficients for the exoskeleton and for the user

coef_exo=[2.013 2+1.344; 0.245*height 0.285*height];

coef_user=[0.1*weight 0.061*weight; 0.245*height 0.285*height];

coef=[2.013+0.1*weight 2+1.344+0.061*weight;0.245*height 0.285*height];

%% Call the functions of the class

qh1=gen_Traj.get_hip_angle(t);
qk1=gen_Traj.get_knee_angle(t);
qh1dot=gen_Traj.get_hip_velocity(t);
qk1dot=gen_Traj.get_knee_velocity(t);
qh1dotdot=gen_Traj.get_hip_acceleration(t);
qk1dotdot=gen_Traj.get_knee_acceleration(t);

% Create the timeseries for simulink

qh=timeseries(qh1',t);
qk=timeseries(qk1',t);
qhdot=timeseries(qh1dot',t);
qkdot=timeseries(qk1dot',t);
qhdotdot=timeseries(qh1dotdot',t);
qkdotdot=timeseries(qk1dotdot',t);


%% Define (K,B) for simulink simulations

Kt=timeseries(Kt,t);
Bt=timeseries(Bt,t);

Khip=K_B.K;Bhip=K_B.B;Kknee=K_B.B;Bknee=K_B;


