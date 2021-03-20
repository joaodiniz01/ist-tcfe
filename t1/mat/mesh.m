close all
clear all

%%mesh method

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

%Va = Ia*(R1+R4)-Ic*R4 + Vb
%Ia*R4 - Ic*(R4+R6+R7) + Vc == 0
%Vc = Ic*Kc
%Ib = Vb*Kb
%Vb = R3*(Ia+Ib)

%%matrix based on five equations system

A = [ R1+R4 , 0 , -R4      , 1   , 0   ;...
      R4   , 0 , -R4-R6-R7 , 0   , 1  ;...
      0     , 0 , -Kc        , 0   , 1 ;...
      0     , 1 , 0        , -Kb , 0 ;...
      R3   , R3, 0       , -1   , 0  ]

B = [ Va; 0; 0; 0; 0]

solutionmesh = A\B;

Ia = solutionmesh(1)
Ib = solutionmesh(2)
Ic = solutionmesh(3)
Vb = solutionmesh(4)
Vc = solutionmesh(5)
Id




