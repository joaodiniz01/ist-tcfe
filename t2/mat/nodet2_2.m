close all
clear all
format long

% Data read
dados=fopen('data.txt','r');
data=fscanf(dados, '%f', [inf]);
data = data';
fclose(dados);

R1 = (str2num(sprintf('%.11f', data(1))))*(10^3);
R2 = (str2num(sprintf('%.11f', data(2))))*(10^3);
R3 = (str2num(sprintf('%.11f', data(3))))*(10^3);
R4 = (str2num(sprintf('%.11f', data(4))))*(10^3);
R5 = (str2num(sprintf('%.11f', data(5))))*(10^3);
R6 = (str2num(sprintf('%.11f', data(6))))*(10^3);
R7 = (str2num(sprintf('%.11f', data(7))))*(10^3);
Vs = 0
C = (str2num(sprintf('%.11f', data(9))));
Kb = (str2num(sprintf('%.11f', data(10))))*(10^-3);
Kd = (str2num(sprintf('%.11f', data(11))))*(10^3);


%da alinea anterior temos que 
V6 = 5.702372676500307
V8 = -2.790648785671866
Vx = V6 - V8
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
      
F = [ -V1/R1; 0; 0; 0; 0; V1/R1; 0; 0; 0];

solutionnodes = E\F;
V1
V2 = solutionnodes(1)
V3 = solutionnodes(2)
V5 = solutionnodes(3)
V7 = solutionnodes(5)
Id = solutionnodes(7)
Ib = solutionnodes(8)
Ic = solutionnodes(9)
%Current in all branches
I1 = (V2-V1)/R1
I2 = Ib
I3 = (V5-V2)/R3
I4 = V5/R4
Ix = (Vx-V5)/R5
I6 = Id
I7 = Id
Is = I1
V6 = Vx
V8 = 0
Req = (Vx/Ix)*(10^-3)
tau = Req*C


% Table

fid = fopen ("node2.tex", "w");
fprintf(fid, "$V_x$ & %e \\\\ \\hline \n", Vx);
fprintf(fid, "$V_1$ & %e \\\\ \\hline \n", V1);
fprintf(fid, "$V_2$ & %e \\\\ \\hline \n", V2);
fprintf(fid, "$V_3$ & %e \\\\ \\hline \n", V3);
fprintf(fid, "$V_5$ & %e \\\\ \\hline \n", V5);
fprintf(fid, "$V_6$ & %e \\\\ \\hline \n", V6);
fprintf(fid, "$V_7$ & %e \\\\ \\hline \n", V7);
fprintf(fid, "$V_8$ & %e \\\\ \\hline \n", V8);
fprintf(fid, "$I_1$ & %e \\\\ \\hline \n", I1);
fprintf(fid, "$I_2$ & %e \\\\ \\hline \n", I2);
fprintf(fid, "$I_3$ & %e \\\\ \\hline \n", I3);
fprintf(fid, "$I_4$ & %e \\\\ \\hline \n", I4);
fprintf(fid, "$I_5$ & %e \\\\ \\hline \n", I5);
fprintf(fid, "$I_6$ & %e \\\\ \\hline \n", I6);
fprintf(fid, "$I_7$ & %e \\\\ \\hline \n", I7);
fprintf(fid, "$I_s$ & %e \\\\ \\hline \n", Is);
fprintf(fid, "$I_d$ & %e \\\\ \\hline \n", Id);
fprintf(fid, "$I_b$ & %e \\\\ \\hline \n", Ib);
fprintf(fid, "$I_x$ & %e \\\\ \\hline \n", Ix);
fprintf(fid, "$Req$ & %e \\\\ \\hline \n", Req);
fprintf(fid, "$tau$ & %e \\\\ \n", tau);
fclose (fid);
