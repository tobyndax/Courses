close all;
addpath 'lab1Files/';
addpath '../CourseLib/';

run 'readwhistle.m'; %load 2seconds of data into whist

%%
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

Wfilt = fft(wfilt);
w=1/(N*T)*(0:N-1);

figure;
plot(w,abs(Wfilt));
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

arModel = ar(whist,2) %Ej klart. ?? Harmonic dist.
arModelFilt = ar(wfilt,2)

%%
%parametric.
figure;
bode(arModel,arModelFilt) %peak of 0.532; 

%non parametric
figure;
plot(n,abs(W),'--r');
hold on;
plot(n,abs(Wfilt),'-.');

