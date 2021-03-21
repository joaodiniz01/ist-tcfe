close all
clear all

%%mesh method
R1 = 1.04765357286e3 
R2 = 2.06140068334e3 
R3 = 3.03459085363e3 
R4 = 4.00398818216e3 
R5 = 3.11499853456e3 
R6 = 2.04588646991e3 
R7 = 1.04390152967e3 
Va = 5.02522591213 
Id = 1.00982536324e-3 
Kb = 7.28209304852e-3 
Kc = 8.36641247715e3 

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

% Table

fid = fopen ("meshtable.tex", "w");
fprintf(fid, "$V_b$ & %e \\\\ \\hline \n", Vb);
fprintf(fid, "$V_c$ & %e \\\\ \\hline \n", Vc);
fprintf(fid, "$I_b$ & %e \\\\ \\hline \n", Ib);
fprintf(fid, "$I_c$ & %e \\\\ \n", Ic);
fclose (fid);



