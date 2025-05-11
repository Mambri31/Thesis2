%% This function finds the M(q), C(q,q') ,g(q) matrix 

% Create a cell structure where 1=M, 2=C, G=3
function matrici=matrix_MCG(coef,q1,q2,q1dot,q2dot)

g=9.81;

m1=coef(1,1); %mass link exo+actuator+user or only mass thigh user
m2=coef(1,2);%mass link exo+actuator+user or only mass shank user
a1=coef(2,1);%length link(thigh) exo
a2=coef(2,2);%length link(shank) exo

l1=a1/2;
l2=a2/2;

I1=(1/12)*m1*a1^2;
I2=(1/12)*m2*a2^2;

%% Inertia matrix

M_11=m1*(l1)^2+I1+m2*a1^2+m2*l2^2+2*m2*a1*l2*cos(q2)+I2;
M_12=m2*l2^2+m2*a1*l2*cos(q2)+I2;
M_21=m2*l2^2+m2*a1*l2*cos(q2)+I2;
M_22=m2*l2^2+I2;
M=[M_11 M_12; M_21 M_22];

%% Coriolis matrix
C_11=-2*m2*a1*l2*sin(q2)*q2dot;
C_12=-m2*a1*l2*sin(q2)*q2dot;
C_21=m2*a1*l2*sin(q2)*q1dot;
C_22=0;

C=[C_11 C_12; C_21 C_22];

%% Gravity matrix

g_11=(m1*l1+m2*a1)*g*cos(q1)+m2*g*l2*cos(q1+q2);
g_21=m2*g*l2*cos(q1+q2);
G=[g_11;g_21];

matrici={M;C;G};

end