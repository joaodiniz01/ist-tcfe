%gain stage

VT=25e-3 %nao mexer ?
BFN=178.7 %nao mexer, modelos
VAFN=69.7 %nao mexer, modelos
RE1=100 %Re
RC1=1000 %Rc
RB1=72000 %R1
RB2=20000 %R2
VBEON=0.7 %nao mexer?
VCC=12 
RS=100 %Rin
CE = 500e-6 %Bypass CE

RB=1/(1/RB1+1/RB2);
VEQ=RB2/(RB1+RB2)*VCC;
IB1=(VEQ-VBEON)/(RB+(1+BFN)*RE1);
IC1=BFN*IB1;
IE1=(1+BFN)*IB1;
VE1=RE1*IE1;
VO1=VCC-RC1*IC1;
VCE=VO1-VE1;

%Table1

fid = fopen ("OP1.tex", "w");
fprintf(fid, "$IB1$ & %e \\\\ \\hline \n", IB1);
fprintf(fid, "$IC11$ & %e \\\\ \\hline \n", IC1);
fprintf(fid, "$IE1$ & %e \\\\ \\hline \n", IE1);
fprintf(fid, "$VO1$ & %e \\\\ \\hline \n", VO1);
fprintf(fid, "$VThevenin$ & %e \\\\ \\hline \n", VEQ);
fprintf(fid, "$VE$ & %e \\\\ \n", VE1);
fclose (fid);

gm1=IC1/VT;
rpi1=BFN/gm1;
ro1=VAFN/IC1;

RSB=RB*RS/(RB+RS);

f = logspace(1, 8, 90);
ZC = 1./(2*pi*i*f*CE);
ZE = (RE1*ZC)./(RE1+ZC);

AV1 = RSB./RS .* RC1.*(ZE-gm1*rpi1*ro1)./((ro1+RC1+ZE).*(RSB+rpi1+ZE)+gm1.*ZE.*ro1.*rpi1 - ZE.^2);
AVI_DB = 20*log10(abs(AV1));
AV1simple = RB./(RB+RS) .* gm1*RC1./(1+gm1.*ZE);
AVIsimple_DB = 20*log10(abs(AV1simple));

figure; hold on
semilogx(f, AVI_DB, 'g');
%semilogx(f, AVIsimple_DB, 'b');
xlabel ("f (Hz)");
ylabel ("Voltage dB");
title ("Voltage Gain (Gain stage)")
print ("vgain1.eps");

##RE1=0
##AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)
##AVI_DB = 20*log10(abs(AV1))
##AV1simple =  - RSB/RS * gm1*RC1/(1+gm1*RE1)
##AVIsimple_DB = 20*log10(abs(AV1simple))

##ZI1 = 1./(1./RB+1./(((ro1+RC1+ZE).*(rpi1+ZE)+gm1.*ZE.*ro1.*rpi1 - ZE.^2)./(ro1+RC1+ZE)));
##ZX = ro1.*((RSB+rpi1).*ZE./(RSB+rpi1+ZE))./(1./(1./ro1+1./(rpi1+RSB)+1./ZE+gm1.*rpi1./(rpi1+RSB)));
##ZX = ro1.*(1./ZE+1./(rpi1+RSB)+1./ro1+gm1.*rpi1./(rpi1+RSB))./(1./ZE+1./(rpi1+RSB)); 
##ZO1 = 1./(1./ZX+1./RC1);


RE1=0
ZI1 = 1/(1/RB+1/(((ro1+RC1+RE1)*(rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)))
ZO1 = 1/(1/ro1+1/RC1)
RE1 = 100

%ouput stage
BFP = 227.3; % nao mexer, modelos
VAFP = 37.2; %nao mexer, modelos
RE2 = 400; %Rout
VEBON = 0.7; %nao mexer?
VI2 = VO1;
IE2 = (VCC-VEBON-VI2)./RE2;
IC2 = BFP./(BFP+1).*IE2;
VO2 = VCC - RE2.*IE2;


%Table2

fid = fopen ("OP2.tex", "w");
fprintf(fid, "$IC2$ & %e \\\\ \\hline \n", IC2);
fprintf(fid, "$IE2$ & %e \\\\ \\hline \n", IE2);
fprintf(fid, "$VI2$ & %e \\\\ \\hline \n", VI2);
fprintf(fid, "$VO2$ & %e \\\\ \n", VO2);
fclose (fid);


gm2 = IC2/VT;
go2 = IC2/VAFP;
gpi2 = gm2/BFP;
ge2 = 1/RE2;

AV2 = gm2/(gm2+gpi2+go2+ge2);
ZI2 = (gm2+gpi2+go2+ge2)/gpi2/(gpi2+go2+ge2);
ZO2 = 1/(gm2+gpi2+go2+ge2);

figure; hold on
semilogx(f, 20*log(abs(AV2)), 'g');
xlabel ("f (Hz)");
ylabel ("Voltage dB");
title ("Voltage Gain (Output stage)")
print ("vgain2.eps");


%total
gB = 1./(1./gpi2+ZO1);
AV = (gB+gm2./gpi2.*gB)./(gB+ge2+go2+gm2./gpi2.*gB).*AV1;
AV_DB = 20*log10(abs(AV));
ZI=ZI1;
ZO=1./(go2+gm2./gpi2.*gB+ge2+gB);

figure; hold on
semilogx(f, AV_DB, 'g');
xlabel ("f (Hz)");
ylabel ("Voltage dB");
title ("Frequency Response")
print ("fresponse.eps");


%Table IMP

fid = fopen ("docImp.tex", "w");
fprintf(fid, "Input Impedance Gain Stage & %e \\\\ \\hline \n", ZI1);
fprintf(fid, "Output Impedance Gain Stage & %e \\\\ \\hline \n", ZO1);
fprintf(fid, "Input Impedance Output Stage & %e \\\\ \\hline \n", ZI2);
fprintf(fid, "Output Impedance Output Stage & %e \\\\ \\hline \n", ZO2);
fprintf(fid, "Total Input Impedance & %e \\\\ \\hline \n", ZI);
fprintf(fid, "Total Output Impedance & %e \\\\ \n", ZO);
fclose (fid);
