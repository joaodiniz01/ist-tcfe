close all
clear all
%data

R1 = 1.0331307462823254e3

R2 = 2.058959312128689e3

R3 = 3.0574731757898794e3

R4 = 4.1598240158631485e3 

R5 = 3.0790247479735586e3 

R6 = 2.071585908343431e3 

R7 = 1.0200157363975357e3 

Va = 5.04611069501311 

Id = 1.0397027739760396e-3 

Kb = 7.175215229391312e-3 

Kc = 8.394963923537722e3

%%equations
%(1/R2)*(V3-V4) + (1/R1)*(V3-V4) - Vb*(1/R3) = 0
%(1/R2)*(V4-V3) + Ib = 0
%(1/R5)*(V0-V2) - Ib = -Id
%(1/R6)*(V6-V7) - Ic = 0

%V5-V6 = Va
% V0 - V1 - Vc = 0
% Vb - Kc = 0
% -V0 + V4 - Vb = 0
% V0 = 0
% (1/R7)*(V1-V7) + Ic = 0
% -Vb*Kb + Ib = 0
% (1/R4)*(V0-V6) + (1/R1)*(V4-V5) - Ic = 0


%%nodes

C = [ 0    , 0    , 0    , 1/R2  , -1/R2-1/R1  , 1/R1    , 0     , 0     , -1/R3   , 0  , 0 , 0   ;...
      0    , 0    , 0    , -1/R2 , 1/R2      , 0     , 0     , 0     , 0     , 0  , 1 , 0   ;...
      1/R5   , 0    , -1/R5  , 0   , 0       , 0     , 0     , 0     , 0     , 0  , -1, 0   ;...
      0    , 0    , 0    , 0   , 0       , 0     , 1/R6    , -1/R6   , 0     , 0  , 0 , -1  ;...
      0    , 0    , 0    , 0   , 0       , 1     , -1    , 0     , 0     , 0  , 0 , 0   ;...
      1    , -1   , 0    , 0   , 0       , 0     , 0     , 0     , 0     , -1 , 0 , 0   ;...
      0    , 0    , 0    , 0   , 0       , 0     , 0     , 0     , 0     , 1  , 0 , -Kc ;...
      -1   , 0    , 0    , 0   , 1       , 0     , 0     , 0     , -1    , 0  , 0 , 0   ;...
      1    , 0    , 0    , 0   , 0       , 0     , 0     , 0     , 0     , 0  , 0 , 0   ;...
      0    , 1/R7   , 0    , 0   , 0       , 0     , 0     , -1/R7   , 0     , 0  , 0 , 1   ;...
      0    , 0    , 0    , 0   , 0       , 0     , 0     , 0     , -Kb   , 0  , 1 , 0   ;... 
      1/R4   , 0    , 0    , 0   , 1/R1      ,-1/R1    , -1/R4   , 0     , 0     , 0  , 0 , -1  ];
      
D = [ 0; 0; -Id; 0; Va; 0; 0; 0; 0; 0; 0; 0];

solutionnodes = C\D;

V0 = solutionnodes(1)
V1 = solutionnodes(2)
V2 = solutionnodes(3)
V3 = solutionnodes(4)
V4 = solutionnodes(5)
V5 = solutionnodes(6)
V6 = solutionnodes(7)
V7 = solutionnodes(8)
Vb = solutionnodes(9)
Vc = solutionnodes(10)
Ib = solutionnodes(11)
Ic = solutionnodes(12)

% Table

fid = fopen ("nodaltable.tex", "w");
fprintf(fid, "$V_b$ & %e \\\\ \\hline \n", Vb);
fprintf(fid, "$V_c$ & %e \\\\ \\hline \n", Vc);
fprintf(fid, "$I_b$ & %e \\\\ \\hline \n", Ib);
fprintf(fid, "$I_c$ & %e \\\\ \n", Ic);
fclose (fid);
