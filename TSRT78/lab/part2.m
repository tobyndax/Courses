close all;
addpath 'lab1Files/';

run 'reada.m'; %load 2seconds of data into asound


run 'reado.m'; %load 2seconds of data into osound

%%
close all; 

fs = fSamp;
Ts  = 2;
T = 1/fs;

N = length(osound);
n = 0:N-1;
figure;
subplot(211);
plot(osound);


osound_d = detrend(osound,'constant');


subplot(212);
plot(abs(fft(osound_d)));
Ne = floor(2*N/3);
Nv = N - Ne; 
osound_e = osound_d(1:floor(2*N/3));
osound_v = osound_d(floor(2*N/3)+1:end); 


x = [1 2 3 5 10 15 20 25]

t1  = ar(osound_e,1);
t2  = ar(osound_e,2);
t3  = ar(osound_e,3);
t5  = ar(osound_e,5);
t10 = ar(osound_e,10);
t15 = ar(osound_e,15);
t20 = ar(osound_e,20);
t25 = ar(osound_e,25);

le(1)= sum(pe(osound_e,t1).^2)/Ne;
le(2)= sum(pe(osound_e,t2).^2)/Ne;
le(3)= sum(pe(osound_e,t3).^2)/Ne;
le(4)= sum(pe(osound_e,t5).^2)/Ne;
le(5)= sum(pe(osound_e,t10).^2)/Ne;
le(6)= sum(pe(osound_e,t15).^2)/Ne;
le(7)= sum(pe(osound_e,t20).^2)/Ne;
le(8)= sum(pe(osound_e,t25).^2)/Ne;


% validation 
epv1  = pe(osound_v,t1);
epv2  = pe(osound_v,t2);
epv3  = pe(osound_v,t3);
epv5  = pe(osound_v,t5);
epv10 = pe(osound_v,t10);
epv15 = pe(osound_v,t15);
epv20 = pe(osound_v,t20);
epv25 =  pe(osound_v,t25);

lv(1) = sum(epv1.^2)/Nv;
lv(2) = sum(epv2.^2)/Nv;
lv(3) = sum(epv3.^2)/Nv;
lv(4) = sum(epv5.^2)/Nv;
lv(5) = sum(epv10.^2)/Nv;
lv(6) = sum(epv15.^2)/Nv;
lv(7) = sum(epv20.^2)/Nv;
lv(8) = sum(epv25.^2)/Nv;

figure;
plot(x,le,'-b',x,lv,'--r')
xlabel('Order of system');ylabel('Mean of squared predicted error');
legend('Estimation data','Validation data','Location','northeast');
print -dpng Report/oLeLv.png

figure;
te = etfe(osound_d,30);
bode(t10,':',t15,'--g',t3,'-.r',te,'-')
print -dpng oBode.png

figure;

r1 = covf(epv1,21);
r2 = covf(epv5,21);
r3 = covf(epv10,21);
k = 0:20;

plot(k,r1/r1(1),'--g',k,r2/r2(1),'-r',k,r3/r3(1),'-.b') 
xlabel('k');ylabel('Covariance of k ');
legend('Model order 1','Model order 5','Model order 10','Location','northeast');
print -dpng Report/oCov.png

%from this 2 seems to be required? 
%%
close all;
compare(osound_v,t2,'--g',t5,'-.r',t10,':b',t15,1);

disp('Need manual save of figure here');
pause;

%t2 above 90%, not much better for higher values seems good!!
%%
close all;

figure;
y = osound_e;
sys = t10;
e = filter(sys.a,1,osound_e);
r = covf(e,100);
[val idx] = max(r(19:end));
idx = idx+20;
P = idx;
N = 16000;
u = zeros(N,1); 
for k=0:N-1
    if(mod(k,P) == 0)
         u(k+1,1) = 1;
    end 
end
ehat = sqrt(val)*u;
yhato = filter(1,sys.a,ehat);


nSamp = size(osound_d,1); % number of samples
t = (0:nSamp-1)/fSamp; % time vector in seconds

subplot(212);
plot(t*pi,abs(fft(yhato)))
xlabel('w');ylabel('Amplitude');title('FFT of reconstructed sound');
subplot(211);
plot(t*pi,abs(fft(osound_d)));
xlabel('w');ylabel('Amplitude');title('FFT of detrended o-recording');
print -dpng Report/oFFT.png

%soundsc(yhato,fs)


%%
close all;
asound_d = detrend(asound,'constant');

asound_e = asound_d(1:Ne);
asound_v = asound_d(Ne+1:end); 

t1  = ar(asound_e,1);
t5  = ar(asound_e,5);
t10 = ar(asound_e,10);
t15 = ar(asound_e,15);
t20 = ar(asound_e,20);
t25 = ar(asound_e,25);

x =[1 5 10 15 20 25];
le = 0;
le(1)= sum(pe(asound_e,t1).^2)/Ne;
le(2)= sum(pe(asound_e,t5).^2)/Ne;
le(3)= sum(pe(asound_e,t10).^2)/Ne;
le(4)= sum(pe(asound_e,t15).^2)/Ne;
le(5)= sum(pe(asound_e,t20).^2)/Ne;
le(6)= sum(pe(asound_e,t25).^2)/Ne;


% validation 
epv1  = pe(asound_v,t1);
epv5  = pe(asound_v,t5);
epv10 = pe(asound_v,t10);
epv15 = pe(asound_v,t15);
epv20 = pe(asound_v,t20);
epv25 =  pe(asound_v,t25);


lv =0;
lv(1) = sum(epv1.^2)/Nv;
lv(2) = sum(epv5.^2)/Nv;
lv(3) = sum(epv10.^2)/Nv;
lv(4) = sum(epv15.^2)/Nv;
lv(5) = sum(epv20.^2)/Nv;
lv(6) = sum(epv25.^2)/Nv;

figure;
plot(x,le,'-',x,lv,'--')
xlabel('Order of system');ylabel('Mean of squared predicted error');
legend('Estimation data','Validation data','Location','northeast');
print -dpng Report/aLeLv.png

figure;
te = etfe(asound_d,30);
bode(t5,':',t10,'--g',t15,'-.r',te,'-')
print -dpng aBode.png
figure;

r1 = covf(epv10,21);
r2 = covf(epv15,21);
r3 = covf(epv20,21);
k = 0:20;

plot(k,r1/r1(1),'-',k,r2/r2(1),'--',k,r3/r3(1),'-.')
xlabel('k');ylabel('Covariance of k ');
legend('Model order 5','Model order 10','Model order 15','Location','northeast');
print -dpng Report/aCov.png

% t10 necessary

%%
close all;
compare(asound_v,t5,'--g',t10,'-.r',t15,':b',1);
pause;
%%

%Ar Simulation

y = asound_d;
figure;
sys = t10;
e = filter(sys.a,1,asound);
r = covf(e,100);
[val idx] = max(r(19:end));
idx = idx+20;
P = idx+20;
N = 16000;
u = zeros(N,1); 
for k=0:N-1
    if(mod(k,P) == 0)
         u(k+1,1) = 1;
    end 
end
ehat = sqrt(val)*u;
yhata = filter(1,sys.a,ehat);

subplot(212);
plot(t*pi,abs(fft(yhata)))
xlabel('w');ylabel('Amplitude');title('FFT of reconstructed sound');
subplot(211);
plot(t*pi,abs(fft(asound_d)));
xlabel('w');ylabel('Amplitude');title('FFT of detrended a-recording');
print -dpng Report/aFFT.png


