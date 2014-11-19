close all;
addpath 'lab1Files/';
addpath '../CourseLib/';

run 'reada.m'; %load 2seconds of data into whist
run 'reado.m'; %load 2seconds of data into whist

%%

fs = fSamp;
Ts  = 2;
T = 1/fs;

N = length(osound);
n = [0:N-1];

osound_e = osound(1:N/2);
osound_v = osound(N/2+1:end); 

t1  = ar(osound_e,1);
t5  = ar(osound_e,5);
t10 = ar(osound_e,10);
t15 = ar(osound_e,15);
t20 = ar(osound_e,20);
t25 = ar(osound_e,25);

le(1)= sum(pe(osound_e,t1).^2)/(N/2);
le(2)= sum(pe(osound_e,t5).^2)/(N/2);
le(3)= sum(pe(osound_e,t10).^2)/(N/2);
le(4)= sum(pe(osound_e,t15).^2)/(N/2);
le(5)= sum(pe(osound_e,t20).^2)/(N/2);
le(6)= sum(pe(osound_e,t25).^2)/(N/2);


% validation 
epv1  = pe(osound_v,t1);
epv5  = pe(osound_v,t5);
epv10 = pe(osound_v,t10);
epv15 = pe(osound_v,t15);
epv20 = pe(osound_v,t20);
epv25 =  pe(osound_v,t25);

lv(1) = sum(epv1.^2)/(N/2);
lv(2) = sum(epv5.^2)/(N/2);
lv(3) = sum(epv10.^2)/(N/2);
lv(4) = sum(epv15.^2)/(N/2);
lv(5) = sum(epv20.^2)/(N/2);
lv(6) = sum(epv25.^2)/(N/2);

figure;
plot(0:5:25,le,'-',0:5:25,lv,'--')


te = etfe(osound,30)
bode(t10,':',t15,'--g',t20,'-.r',te,'-')

figure;

r1 = covf(epv10,21);
r2 = covf(epv15,21);
r3 = covf(epv20,21);
k = 0:20;

plot(k,r1/r1(1),'-',k,r2/r2(1),'--',k,r3/r3(1),'-.') 


y = osound;

P = 75; %10 peaks average period in samples. 
N = 16000;
L = round(N/P);
u = kron(ones(L,1),[1;zeros(P-1, 1)]);
lambda = sum(osound.^2);
scale = sqrt(lambda*L)
u = u*scale;

sign = idsim(u,t10); %check which tn necessary

Pyy = pwelch(y);

plot(sign)
%how should we scale. 
sound(sign)


%%

%order 5 is enough. 

asound_e = asound(1:N/2);
asound_v = asound(N/2+1:end); 

t1  = ar(asound_e,1);
t5  = ar(asound_e,5);
t10 = ar(asound_e,10);
t15 = ar(asound_e,15);
t20 = ar(asound_e,20);
t25 = ar(asound_e,25);

le(1)= sum(pe(asound_e,t1).^2)/(N/2);
le(2)= sum(pe(asound_e,t5).^2)/(N/2);
le(3)= sum(pe(asound_e,t10).^2)/(N/2);
le(4)= sum(pe(asound_e,t15).^2)/(N/2);
le(5)= sum(pe(asound_e,t20).^2)/(N/2);
le(6)= sum(pe(asound_e,t25).^2)/(N/2);


% validation 
epv1  = pe(asound_v,t1);
epv5  = pe(asound_v,t5);
epv10 = pe(asound_v,t10);
epv15 = pe(asound_v,t15);
epv20 = pe(asound_v,t20);
epv25 =  pe(asound_v,t25);

lv(1) = sum(epv1.^2)/(N/2);
lv(2) = sum(epv5.^2)/(N/2);
lv(3) = sum(epv10.^2)/(N/2);
lv(4) = sum(epv15.^2)/(N/2);
lv(5) = sum(epv20.^2)/(N/2);
lv(6) = sum(epv25.^2)/(N/2);

figure;
plot(0:5:25,le,'-',0:5:25,lv,'--')


te = etfe(asound,30)
bode(t1,':',t5,'--g',t10,'-.r',te,'-')

figure;

r1 = covf(epv10,21);
r2 = covf(epv15,21);
r3 = covf(epv20,21);
k = 0:20;

plot(k,r1/r1(1),'-',k,r2/r2(1),'--',k,r3/r3(1),'-.')

% t10 necessary

%%
bode(t10,'-.')

figure;
plot(2*pi/16000*n,abs(fft(asound)))

%%

%Ar Simulation

y = asound;

P = 80; %10 peaks average period in samples. 
N = 16000;
L = N/P;
u = 20*kron(ones(L,1),[1;zeros(P-1, 1)]);

lambda = 1;

sign = idsim(u,t10)

Pyy = pwelch(y);

plot(sign)
%how should we scale. 
%sound(sign) 
max(asound)
max(sign)
