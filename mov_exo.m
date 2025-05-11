%% Classe per il calcolo delle traiettorie dell'esoscheletro
classdef mov_exo  
    properties
        cycle_duration
        w
        c
        f
        h_offset
        k_offset
    end
    
    methods
        %% Settaggi della classe
        function obj = mov_exo(cycle_duration, h_offset, k_offset)
            obj.cycle_duration = cycle_duration;
            obj.w = [0, 2, 4, 6] / cycle_duration;
            obj.c = [0.208, 0.362, -0.066, 0.001, 0.766, -0.099, -0.219, 0.008];%coef. Fourier coseno
            obj.f = [NaN, -0.103, -0.010, 0.029, -0.342, 0.168, 0.084];%coef.Fourier seno
            obj.h_offset = deg2rad(h_offset); % Convert to radians
            obj.k_offset = deg2rad(k_offset); % Convert to radians
        end
        %% Vettori posizione angolari
        function qh = get_hip_angle(obj, t)
            qh = obj.c(1)*cos(obj.w(1)*pi*t) + obj.c(2)*cos(obj.w(2)*pi*t) + obj.f(2)*sin(obj.w(2)*pi*t) + ...
                 obj.c(3)*cos(obj.w(3)*pi*t) + obj.f(3)*sin(obj.w(3)*pi*t) + obj.c(4)*cos(obj.w(4)*pi*t) + ...
                 obj.f(4)*sin(obj.w(4)*pi*t) - obj.h_offset;
        end
        
        function qk = get_knee_angle(obj, t)
            qk = obj.c(5)*cos(obj.w(1)*pi*t) + obj.c(6)*cos(obj.w(2)*pi*t) + obj.f(5)*sin(obj.w(2)*pi*t) + ...
                 obj.c(7)*cos(obj.w(3)*pi*t) + obj.f(6)*sin(obj.w(3)*pi*t) + obj.c(8)*cos(obj.w(4)*pi*t) + ...
                 obj.f(7)*sin(obj.w(4)*pi*t) - obj.k_offset;
        end
        %% Vettori velocità angolari
        function qdoth = get_hip_velocity(obj, t)
            qdoth = - obj.c(1)*sin(obj.w(1)*pi*t) - obj.c(2)*sin(obj.w(2)*pi*t) + obj.f(2)*cos(obj.w(2)*pi*t) - ...
                     obj.c(3)*sin(obj.w(3)*pi*t) + obj.f(3)*cos(obj.w(3)*pi*t) - obj.c(4)*sin(obj.w(4)*pi*t) + ...
                     obj.f(4)*cos(obj.w(4)*pi*t);
        end
        
        function qdotk = get_knee_velocity(obj, t)
            qdotk = - obj.c(5)*sin(obj.w(1)*pi*t) - obj.c(6)*sin(obj.w(2)*pi*t) + obj.f(5)*cos(obj.w(2)*pi*t) - ...
                     obj.c(7)*sin(obj.w(3)*pi*t) + obj.f(6)*cos(obj.w(3)*pi*t) - obj.c(8)*sin(obj.w(4)*pi*t) + ...
                     obj.f(7)*cos(obj.w(4)*pi*t);
        end
        %% Vettori accelerazioni angolari                
        function qddoth = get_hip_acceleration(obj, t)
            qddoth = - obj.c(1)*cos(obj.w(1)*pi*t) - obj.c(2)*cos(obj.w(2)*pi*t) - obj.f(2)*sin(obj.w(2)*pi*t) - ...
                     obj.c(3)*cos(obj.w(3)*pi*t) - obj.f(3)*sin(obj.w(3)*pi*t) - obj.c(4)*cos(obj.w(4)*pi*t) - ...
                     obj.f(4)*sin(obj.w(4)*pi*t);
        end
        
        function qddotk = get_knee_acceleration(obj, t)
            qddotk = - obj.c(5)*cos(obj.w(1)*pi*t) - obj.c(6)*cos(obj.w(2)*pi*t) - obj.f(5)*sin(obj.w(2)*pi*t) - ...
                     obj.c(7)*cos(obj.w(3)*pi*t) - obj.f(6)*sin(obj.w(3)*pi*t) - obj.c(8)*cos(obj.w(4)*pi*t) - ...
                     obj.f(7)*sin(obj.w(4)*pi*t);
        end
    
    
    
    end
end
