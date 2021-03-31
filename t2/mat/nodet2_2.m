
%%%%%%%%%%%%%%%%%%%%%%%%%
%Alinea 2


close all
clear all
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

Vs = 0
V1 = Vs

V6 =  0.61484
V8 =  0.14161
Vx = V6-V8

C = [ -1/R1-1/R2+1/R3   , 1/R2    , -1/R3    , 0 , 0 , 0 , 0     , 0     , 0   ;...
      1/R3    , 0    , -1/R3+1/R5-1/R4   , -1/R5 ,0     , 0     , -1    , 0     , 0       ;...
      0   , 0    , -1/R5  , 1/R5    , 0       , 0     , 0     , 1     , 1    ;...
      0    , 0    , 0   ,    0       , -1/R7     , 1/R7    , 1  , 0     , -1   ;...
      0    , 0    , 0    , 0   , -1/R7      , 1/R7     , -1    , 0     , 0     ;...
      1/R1    , 0   , 1/R4   , 0   , 0       , 0     , 1     , 0     , 0       ;...
      1/R2    , -1/R2   , 0    , 0   , 0       , 0     , 0     , -1    , 0     ;...
      -1   , 0    , 1    , 0   , 0       , 0     , 0     , -1/Kb     , 0      ;...
      0    , 0    , 0    , 0   ,  1/R6      , 0     , -1    , 0     , 0    ];
      
D = [ -V1/R1; 0; 0; 0; 0; V1/R1; 0; 0; 0];

solutionnodes = C\D;

V2 = solutionnodes(1)
V3 = solutionnodes(2)
V5 = solutionnodes(3)
V6 = solutionnodes(4)
V7 = solutionnodes(5)
V8 = solutionnodes(6)
Id = solutionnodes(7)
Ib = solutionnodes(8)
Ix = solutionnodes(9)

Req = Vx/Ix