close all
clear all
format long


##############################
#Alinea 1
#############################

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
Vs = str2num(sprintf('%.11f', data(8)));
C = (str2num(sprintf('%.11f', data(9))))*(10^-6);
Kb = (str2num(sprintf('%.11f', data(10))))*(10^-3);
Kd = (str2num(sprintf('%.11f', data(11))))*(10^3);


% Data write NGspice
dir = '../sim';
dadosw=fopen(fullfile(dir,'sim1data.cir'),'w');
fprintf(dadosw, 'R1 n1 n2 %.11fk\n', data(1));
fprintf(dadosw, 'R2 n3 n2 %.11fk\n', data(2));
fprintf(dadosw, 'R3 n2 n5 %.11fk\n', data(3));
fprintf(dadosw, 'R4 n5 0 %.11fk\n', data(4));
fprintf(dadosw, 'R5 n5 n6 %.11fk\n', data(5));
fprintf(dadosw, 'R6 0 n7 %.11fk\n', data(6));
fprintf(dadosw, 'R7 n7 n8 %.11fk\n', data(7));
fprintf(dadosw, 'Vs n1 0 DC %.11f\n', data(8));
fprintf(dadosw, 'V0 n8 n9 DC 0\n');
fprintf(dadosw, 'C0 n6 n8 %.11fu\n', data(9));
fprintf(dadosw, 'G0 n6 n3 n2 n5 %.11fm\n', data(10));
fprintf(dadosw, 'H0 n5 n9 V0 %.11fk\n', data(11));
fclose(dadosw);

dadosw2=fopen(fullfile(dir,'sim2data.cir'),'w');
fprintf(dadosw2, 'R1 n1 n2 %.11fk\n', data(1));
fprintf(dadosw2, 'R2 n3 n2 %.11fk\n', data(2));
fprintf(dadosw2, 'R3 n2 n5 %.11fk\n', data(3));
fprintf(dadosw2, 'R4 n5 0 %.11fk\n', data(4));
fprintf(dadosw2, 'R5 n5 n6 %.11fk\n', data(5));
fprintf(dadosw2, 'R6 0 n7 %.11fk\n', data(6));
fprintf(dadosw2, 'R7 n9 n8 %.11fk\n', data(7));
fprintf(dadosw2, 'Vs n1 0 DC 0\n');
fprintf(dadosw2, 'V0 n7 n9 DC 0\n');
fprintf(dadosw2, 'Vx n8 n6 8.49302\n');
fprintf(dadosw2, 'G0 n6 n3 n2 n5 %.11fm\n', data(10));
fprintf(dadosw2, 'H0 n5 n8 V0 %.11fk\n', data(11));
fclose(dadosw2);

dadosw3=fopen(fullfile(dir,'sim3data.cir'),'w');
fprintf(dadosw3, 'R1 n1 n2 %fk\n', data(1));
fprintf(dadosw3, 'R2 n3 n2 %fk\n', data(2));
fprintf(dadosw3, 'R3 n2 n5 %fk\n', data(3));
fprintf(dadosw3, 'R4 n5 0 %fk\n', data(4));
fprintf(dadosw3, 'R5 n5 n6 %fk\n', data(5));
fprintf(dadosw3, 'R6 0 n7 %fk\n', data(6));
fprintf(dadosw3, 'R7 n9 n8 %fk\n', data(7));
fprintf(dadosw3, 'Vs n1 0 DC 0\n');
fprintf(dadosw3, 'V0 n7 n9 DC 0\n');
fprintf(dadosw3, 'C0 n6 n8 %fu\n', data(9));
fprintf(dadosw3, 'G0 n6 n3 n2 n5 %fm\n', data(10));
fprintf(dadosw3, 'H0 n5 n8 V0 %fk\n', data(11));
fprintf(dadosw3, '.ic v(n6) = 8.49302e00\n');
fprintf(dadosw3, '.ic v(n8) = 0\n');
fclose(dadosw3);

dadosw4=fopen(fullfile(dir,'sim45data.cir'),'w');
fprintf(dadosw4, 'R1 n1 n2 %fk\n', data(1));
fprintf(dadosw4, 'R2 n3 n2 %fk\n', data(2));
fprintf(dadosw4, 'R3 n2 n5 %fk\n', data(3));
fprintf(dadosw4, 'R4 n5 0 %fk\n', data(4));
fprintf(dadosw4, 'R5 n5 n6 %fk\n', data(5));
fprintf(dadosw4, 'R6 0 n7 %fk\n', data(6));
fprintf(dadosw4, 'R7 n9 n8 %fk\n', data(7));
fprintf(dadosw4, 'Vs n1 0 0.0 ac 1.0 sin(0 1 1k)\n');
fprintf(dadosw4, 'V0 n7 n9 DC 0\n');
fprintf(dadosw4, 'C0 n6 n8 %fu\n', data(9));
fprintf(dadosw4, 'G0 n6 n3 n2 n5 %fm\n', data(10));
fprintf(dadosw4, 'H0 n5 n8 V0 %fk\n', data(11));
fprintf(dadosw4, '.ic v(n6) = 8.49302e00\n');
fprintf(dadosw4, '.ic v(n8) = 0\n');
fclose(dadosw4);

% End data write

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
V6_a = solutionnodes(4)
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
I5 = (V6_a-V5)/R5
I6 = Id
I7 = Id
Is = I1

% Table

fid = fopen ("../doc/node1.tex", "w");
fprintf(fid, "$V_1$ & %e \\\\ \\hline \n", V1);
fprintf(fid, "$V_2$ & %e \\\\ \\hline \n", V2);
fprintf(fid, "$V_3$ & %e \\\\ \\hline \n", V3);
fprintf(fid, "$V_5$ & %e \\\\ \\hline \n", V5);
fprintf(fid, "$V_6$ & %e \\\\ \\hline \n", V6_a);
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
fprintf(fid, "$I_c$ & %e \\\\ \n", Ic);
fclose (fid);




########################################
# Alinea 2
########################################

% Data read
dados=fopen('data.txt','r');
data=fscanf(dados, '%f', [inf]);
data = data';
fclose(dados);

C = (str2num(sprintf('%.11f', data(9))))

Vs = 0

%da alinea anterior temos que 
Vx = V6_a-V8
V1 = Vs


G = [ -1/R1-1/R2-1/R3   , 1/R2    , 1/R3    , 0 , 0 , 0 , 0     , 0     , 0   ;...
      1/R3    , 0    , -1/R3-1/R5-1/R4   , 1/R5 ,0     , 0     , 1    , 0     , 0       ;...
      0   , 0    , 1/R5  , -1/R5    , 0       , 0     , 0     , -1     , -1    ;...
      0    , 0    , 0   ,    0       , 1/R7     , -1/R7    , -1  , 0     , 1  ;...
      0    , 0    , 1    , 0   , 0      , -1    , -Kd    , 0     , 0     ;...
      1/R1    , 0   , 1/R4   , 0   , 0       , 0     , -1     , 0     , 0       ;...
      1/R2    , -1/R2   , 0    , 0   , 0       , 0     , 0     , 1    , 0     ;...
      1   , 0    , -1    , 0   , 0       , 0     , 0     , -1/Kb     , 0      ;...
      0    , 0    , 0    , 0   ,  1/R6      , 0     , 1    , 0     , 0    ];
      
H = [ -V1/R1; 0; 0; 0; 0; V1/R1; 0; 0; 0];

solutionnodes = G\H;
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
I5 = (Vx-V5)/R5
Ix = I5
I6 = Id
I7 = Id
Is = I1
V6 = Vx
V8 = 0
Req = (Vx/Ix)*(10^-3)
tau = Req*C


% Table

fid = fopen ("../doc/node2.tex", "w");
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
fprintf(fid, "$Req (kOhm)$ & %e \\\\ \\hline \n", Req);
fprintf(fid, "$tau (ms)$ & %e \\\\ \n", tau);
fclose (fid);



########################################
# Alinea 3
########################################

A = Vx-V8

t = 0:0.1:20;
V6n = A*exp(-t/tau);

hf = figure ();
plot(t, V6n)
xlabel ("t (ms)")
ylabel ("V6n (V)")
title ("Natural Solution V6n(t)")
print (hf, "alinea3.eps", "-depsc");


########################################
# Alinea 4
########################################

% Data read
dados=fopen('data.txt','r');
data=fscanf(dados, '%f', [inf]);
data = data';
fclose(dados);

C = (str2num(sprintf('%.11f', data(9))))*(10^-6)
Req = Req*1000

#vc = -i/(1 + i*2*pi*1000*Req*C)

Z = 1/(i*2*pi*1000*C)

Vs = 1
v_s = -i

V1 = v_s

J = [ 1/R1+1/R2+1/R3   , -1/R2    , -1/R3    , 0 , 0 , 0 , 0    ;...
        0    , 0    , 0   ,   -1      , 0    , 1    , 1      ;...
        0    , 0    ,   0 , 0   , 1/R6+1/R7      , -1/R7    , 0     ;...
        -1/R1    , 0   , -1/R4   , 0   , -1/R6       , 0     , 0      ;...
        -1/R2-Kb    , 1/R2   , Kb   , 0   , 0       , 0     , 0      ;...
        Kb   , 0    , -Kb-1/R5    , 1/R5+1/Z  , 0       ,-1/Z     , 0   ;...
        0    , 0    , 1   , 0   , Kd/R6     , -1     , 0   ];
            
      
L = [ V1/R1; 0; 0; -V1/R1; 0;0;0];

solutionnodes = J\L;

V2 = solutionnodes(1)
V3 = solutionnodes(2)
V5 = solutionnodes(3)
V6_ph = solutionnodes(4)
V7 = solutionnodes(5)
V8 = solutionnodes(6)
vc = solutionnodes(7)

% Table
fid = fopen ("../doc/node4.tex", "w");
fprintf(fid, "$V_1$ & %e \\\\ \\hline \n", V1);
fprintf(fid, "$V_2$ & %e \\\\ \\hline \n", V2);
fprintf(fid, "$V_3$ & %e \\\\ \\hline \n", V3);
fprintf(fid, "$V_5$ & %e \\\\ \\hline \n", V5);
fprintf(fid, "$V_6$ & %e \\\\ \\hline \n", V6_ph);
fprintf(fid, "$V_7$ & %e \\\\ \\hline \n", V7);
fprintf(fid, "$V_8$ & %e \\\\ \\hline \n", V8);
fprintf(fid, "$v_c$ & %e \\\\ \n", vc);
fclose (fid);

V6_modul = abs(V6_ph)
fase6 = 0 + atan(2*pi*1000*Req*C)

t =  0:0.1:20;
V6f = V6_modul*cos((t/1000)*2*1000*pi - fase6);

hf1 = figure ();
plot(t, -V6f)
xlabel ("t (ms)")
ylabel ("V6f (V)")
title ("Forced Solution V6f(t)")
print (hf1, "alinea4.eps", "-depsc");


########################################
# Alinea 5
########################################

% Data read
dados=fopen('data.txt','r');
data=fscanf(dados, '%f', [inf]);
data = data';
fclose(dados);

Vs = str2num(sprintf('%.11f', data(8)));


% t =[0,20]
t1 =  0:0.1:20;
vs_t1 = sin(2*pi*1000*(t1/1000));
V6_t1 = V6n + V6f;
% t<0
t2 = -5:0.1:0;
vs_t2 = Vs;
V6_t2 = V6_a;

hf2 = figure ();
plot(t1, V6_t1, 'b',t1 ,vs_t1, 'r', t2, V6_t2, 'b', t2, vs_t2, 'r')
xlabel ("t (ms)")
ylabel ("Voltage (V)")
print (hf2, "alinea5.eps", "-depsc");


########################################
# Alinea 6
########################################

f = logspace(-1, 6, 70)

Z = 1./(i*2*pi*f*C)

Vs = 1
vs_f = -i
##
V1 = vs_f

for k = 1:70

P = [ 1/R1+1/R2+1/R3   , -1/R2    , -1/R3    , 0 , 0 , 0 , 0    ;...
        0    , 0    , 0   ,   -1      , 0    , 1    , 1      ;...
        0    , 0    ,   0 , 0   , 1/R6+1/R7      , -1/R7    , 0     ;...
        -1/R1    , 0   , -1/R4   , 0   , -1/R6       , 0     , 0      ;...
        -1/R2-Kb    , 1/R2   , Kb   , 0   , 0       , 0     , 0      ;...
        Kb   , 0    , -Kb-1/R5    , 1/R5+1/Z(k)  , 0       ,-1/Z(k)     , 0   ;...
        0    , 0    , 1   , 0   , Kd/R6     , -1     , 0   ];
            
      
Q = [ V1/R1; 0; 0; -V1/R1; 0;0;0];

solutionnodes = P\Q;

V2 = solutionnodes(1)
V3 = solutionnodes(2)
V5 = solutionnodes(3)
V6_f(k) = solutionnodes(4)
V7 = solutionnodes(5)
V8 = solutionnodes(6)
vc_f(k) = solutionnodes(7)
endfor
##
##
##

figure; hold on
semilogx(f, 20*log10(abs(vc_f)), 'g');
semilogx(f, 20*log10(abs(vs_f)), 'b');
semilogx(f, 20*log10(abs(V6_f)), 'r');
xlabel ("f (Hz)");
ylabel ("Voltage dB");
ylim([-10 8])
title ("Frequency Response")
print ("alinea61.eps", "-depsc");

figure
semilogx(f, 180/pi*angle(vc_f), 'g', f, 180/pi*angle(vs_f), 'b', f, 180/pi*angle(V6_f), 'r');
xlabel ("f (Hz)");
ylabel ("Phase (degrees)");
title ("Frequency Response")
print ("alinea62.eps", "-depsc");
