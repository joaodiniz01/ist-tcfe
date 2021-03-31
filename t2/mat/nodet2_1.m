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



%%equations
%(1/R1)*(V1-V2) + (1/R2)*(V3-V2) + (1/R3)*(V5-V2 = 0
%(1/R3)*(V2-V5) + (1/R5)*(V6-V5) + Ib + V5 = 0
%(1/R5)*(V0-V2) - Ib = -Id
%(1/R6)*(V6-V7) - Ic = 0

%V5-V6 = Va
% V0 - V1 - Vc = 0
% Vc - Kc*Ic = 0
% -V0 + V4 - Vb = 0
% V0 = 0
% (1/R7)*(V1-V7) + Ic = 0
% -Vb*Kb + Ib = 0
% (1/R4)*(V0-V6) + (1/R1)*(V4-V5) - Ic = 0


%%nodes

%%%%%%%%%%%%%%%%%
%Alinea 1

V1 = Vs


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
Ic = solutionnodes(9)


%Current in all branches
I1 = (V2-V1)/R1
I2 = Ib
I3 = (V5-V2)/R3
I4 = V5/R4
I5 = (V6-V5)/R5
I6 = Id
I7 = Id
Is = I1

##% Table
##
##fid = fopen ("nodaltable.tex", "w");
##fprintf(fid, "$V_b$ & %e \\\\ \\hline \n", V1);
##fprintf(fid, "$V_c$ & %e \\\\ \\hline \n", Vc);
##fprintf(fid, "$I_b$ & %e \\\\ \\hline \n", Ib);
##fprintf(fid, "$I_c$ & %e \\\\ \n", Ic);
##fclose (fid);

