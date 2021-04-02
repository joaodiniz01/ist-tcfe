
%Alinea 3

V8o =0
Vx = 8.493

tau = 3.145604526654119
A = Vx-V8o

t = 0:0.1:20
V6n = A*exp(-t/tau)

##plot(t, V6n)
##xlabel ("t (ms)")
##ylabel ("V6n (V)")
##title ("Natural Solution V6n(t)")



%Alinea 4
%data

R1 = 1.04765357286e3 
R2 = 2.06140068334e3 
R3 = 3.03459085363e3 
R4 = 4.00398818216e3 
R5 = 3.11499853456e3 
R6 = 2.04588646991e3 
R7 = 1.04390152967e3 
Vs = 5.02522591213 
C = 1.00982536324e-6 
Kb = 7.28209304852e-3 
Kd = 8.36641247715e3


Vs = 1
Vs = exp(-i*(pi/2))


V1 = Vs


E = [ -1/R1-1/R2-1/R3   , 1/R2    , 1/R3    , 0 , 0 , 0 , 0     , 0     , 0   ;...
      1/R3    , 0    , -1/R3-1/R5-1/R4   , 1/R5 ,0     , 0     , 1    , 0     , 0       ;...
      0   , 0    , 1/R5  , -1/R5    , 0       , 0     , 0     , -1     , -1    ;...
      0    , 0    , 0   ,    0       , 1/R7     , -1/R7    , -1  , 0     , 1  ;...
      0    , 0    , 1    , 0   , 0      , -1    , -Kd    , 0     , 0     ;...
      1/R1    , 0   , 1/R4   , 0   , 0       , 0     , -1     , 0     , 0       ;...
      1/R2    , -1/R2   , 0    , 0   , 0       , 0     , 0     , 1    , 0     ;...
      1   , 0    , -1    , 0   , 0       , 0     , 0     , -1/Kb     , 0      ;...
      0    , 0    , 0    , 0   ,  1/R6      , 0     , 1    , 0     , 0    ];
      
D = [ -V1/R1; 0; 0; 0; 0; V1/R1; 0; 0; 0];

solutionnodes = E\D;
V1
V2 = solutionnodes(1)
V3 = solutionnodes(2)
V5 = solutionnodes(3)
V6_ph = solutionnodes(4)
V7 = solutionnodes(5)
V8 = solutionnodes(6)
Id = solutionnodes(7)
Ib = solutionnodes(8)
Ic = solutionnodes(9)

V6 = abs(V6_ph)
C = 1.00982536324e-6
Req =  3114.998534560000
fase6 = 0 + atan(2*pi*1000*Req*C)

t =  0:0.1:20;
V6f = V6*cos((t/1000)*2*1000*pi - fase6);

##plot(t, V6f)
##xlabel ("t (ms)")
##ylabel ("V6f (V)")
##title ("Forced Solution V6f(t)")


%Alinea 5

Vs = 5.02522591213 

% t =[0,20]
t1 =  0:0.1:20;
vs_t1 = sin(2*pi*1000*(t1/1000))
V6_t1 = V6n + V6f
% t<0
V6 = 5.702372676500307
t2 = -5:0.1:0
vs_t2 = Vs
V6_t2 = V6
plot(t1, V6_t1, 'b',t1 ,vs_t1, 'r', t2, V6_t2, 'b', t2, vs_t2, 'r')





