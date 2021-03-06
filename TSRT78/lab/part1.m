close all;
addpath 'lab1Files/';
addpath '../CourseLib/';

run 'readwhistle.m';
%The script readwhistle.m simply reads a wav file into whist.


%%
close all;

fs = fSamp; %8kHz
Ts  = 2; %the whole signal is 2 seconds long.
T = 1/fs;

N = length(whist);
n = [0:N-1];

W = fft(whist);
w=1/(N*T)*(0:N-1);

figure;
plot(w,abs(W));


[b1, a1] = butter(10,[1000*2*T 1300*2*T],'bandpass');

wfilt = filtfilt(b1,a1,whist);
Wfilt = zeros(1,N);
Wfilt(2275:2605) = W(2275:2605);
Wfilt(13000:14000) = W(13000:14000);


w=1/(N*T)*(0:N-1);
ws=w*2*pi/8000;


figure;
plot(ws,abs(Wfilt)); %peak at 0.96
xlabel('Frequency (rad/s)');ylabel('Amplitude');
print -dpng Report/Wfilt.png

%This is power. We want energy. Drop a N, mayhaps?
wpow = sum(whist.^2)
wfiltpow = sum(wfilt.^2)

purity = 1 - wfiltpow/wpow

%%

Wpow = sum(abs(W).^2)/N
WpowBand = sum(abs(Wfilt).^2)/N

purity = 1 - WpowBand/Wpow


%%

whist_d = detrend(whist,'constant');

whist_filt_d = detrend(wfilt,'constant');

arModel = ar(whist_d,2); %Ej klart. ?? Harmonic dist.
arModelFilt = ar(whist_filt_d,2);

%%
close all;
%parametric.
s_nonpar=etfe(whist_d,1000);
figure;
bode(arModelFilt,s_nonpar) %peak of 0.96;
legend('AR-model','Detrended Whistle');
print -dpng Report/WAR.png

%%
1- abs(roots(arModel.a))

%%
%non parametric
[H,W]=freqz(1,arModelFilt.a,16000);
figure(5); plot(W,abs(H),'r'); hold on;


arModelFilt.NoiseVariance/arModel.NoiseVariance

%%




