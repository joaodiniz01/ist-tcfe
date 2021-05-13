close all 
clear all
f=50;
w=2*pi*f;
C=21e-6

n=16
A = 230/n;

#Ngspice
Von = 12.00025/21
R3 = 27.3e3
rd = 65.7894736842105

%envelope detetor
t=linspace(0, 10e-3, 200);
A = A - 2*Von
vS=A*cos(w*t);
vret = abs(vS)

R = (R3 + 23*rd);

tOFF = (1/w) * atan(1/(w*R*C))
vOnexp = A*cos(w*tOFF)*exp(-((t-tOFF)/(R*C)));

figure
plot(t*1000, vret)

hold
for i=1:length(t)
  if t(i) < tOFF(1)
    vO(i) = vret(i);
  elseif vOnexp(i) > vret(i)
    vO(i) = vOnexp(i);
  else 
    vO(i) = vret(i);
  endif
endfor


plot(t*1000, vO)
title("Output voltage v_o(t)")
xlabel ("t[ms]")
ylabel ("V[volt]")
legend("rectified","envelope")
print ("retified.eps", "-depsc");

figure 
plot(t*1000, vO)
title("Output voltage v_o(t)")
xlabel ("t[ms]")
ylabel ("V[volt]")
legend("envelope")
print ("envelope.eps", "-depsc");

Vs = (max(vO)+min(vO))/2

%voltage regulator circuit
R3 = 27.3e3
vsr = vO - Vs;

##Ngspice
##Is = 9e-4
##Vd = 25e-3
##rd = Vd/(Is*exp(Von/Vd))
##rd_nd = 19*rd
rd_n = rd*21;
vOr = (rd_n/(rd_n + R3)).*vsr;

Vdc = 21*Von + vOr;
Vdc_m = (max(Vdc)+min(Vdc))/2;
Vdc_O = Vdc_m - 12

figure
plot(t*1000, Vdc)
hold
plot(t*1000, Vdc_m)
title("Output voltage VDC(t)")
xlabel ("t[ms]")
ylabel ("V[volt]")
legend("regulator","average")
print ("outputdc.eps", "-depsc");

figure 
plot(t*1000, Vdc-12)
title("Output voltage VDC(t)-12")
xlabel ("t[ms]")
ylabel ("V[volt]")
print ("v012.eps", "-depsc");

%voltage ripple

vripple = max(Vdc)-min(Vdc)
figure
plot(t*1000, vripple, 'g')
title("Voltage Ripple")
xlabel ("t[ms]")
ylabel ("V[volt]")
legend("ripple")
print ("ripple.eps", "-depsc");

%Merit
vripple_n = 5.616237e-03
Vdc_O_n = 2.280889e-04
cost_R = R3/1000;
cost_C = C/(1e-6);
cost_d = 0.1*25;
cost = cost_R + cost_C + cost_d;
M = 1/(cost*(vripple_n + Vdc_O_n + 1e-6));

%Tables
fid = fopen ("conclusion.tex", "w");
fprintf(fid, "Resistor Cost & %e \\\\ \\hline \n", cost_R);
fprintf(fid, "Capacitor Cost & %e \\\\ \\hline \n", cost_C);
fprintf(fid, "Diode Cost & %e \\\\ \\hline \n", cost_d);
fprintf(fid, "Total Cost & %e \\\\ \\hline \n", cost);
fprintf(fid, "Merit & %e \\\\ \n", M);
fclose (fid);

fid = fopen ("ripple_octave.tex", "w");
fprintf(fid, "Ripple & %e \\\\ \\hline \n", vripple);
fclose (fid);
