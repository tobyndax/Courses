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


[b1, a1] = butter(4,[800*2*T 1400*2*T],'bandpass');

wfilt = filtfilt(b1,a1,whist);

Wfilt = fft(wfilt);
w=1/(N*T)*(0:N-1);

figure;
plot(w,abs(Wfilt));

wpow = sum(whist.^2)/N
wfiltpow = sum(wfilt.^2)/N

purity = 1 - wfiltpow/wpow

%%

Wpow = sum(abs(W).^2)/N^2
WpowBand = sum(abs(Wfilt).^2)/N^2

%%

figure;
plot(wfilt)