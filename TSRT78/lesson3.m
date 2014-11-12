close all;
addpath CourseLib
%%

N = 60;
n = [0:N-1];

w0 = 2*pi/5;

x = sin(w0*n);

p = 2;
xd = x(1:p:end);

X = fft(x);
Xd = fft(xd);

figure;
subplot(121);
plot(2*pi/N *(0:N-1),abs(X));

subplot(122);
plot(2*pi/N*(0:N/p-1),abs(Xd));


%%
load('CourseLib/sig30.mat')

figure;
N = 100;
N = 10*N
Y = fft(y,N);


plot(2*pi/N*(0:N-1),abs(Y))


%%
load('CourseLib/sig40.mat')
figure;
subplot(221);
plot(abs(fft(s2)));

subplot(222);
plot(abs(fft(s1)));

%s should be able to be split into two by using a highpass filter and a
%lowpass filter with it's cutoff placed inbetween the peaks in s1 and s2

[b1, a1] = butter(10,(0.1+0.5)/2/pi,'high'); %normalized cutoff freq times 2. 
[b2, a2] = butter(10,(0.1+0.5)/2/pi,'low');

%%why does this with wf = 0.15 work so good?

%fvtool(b1,a1)

s3 = filtfilt(b1,a1,s); 
s4 = filtfilt(b2,a2,s);


subplot(223);
plot(abs(fft(s3)));

subplot(224);
plot(abs(fft(s4)));

%%
close all;
figure;
load('CourseLib/soderasen.mat')

fs = 1000;
T = 1/fs;
N = length(i4r);
n = [0:N-1];

I4r = fft(i4r);
w=1/(N*T)*(0:N-1);

plot(w,abs(I4r));


[b1, a1] = butter(2,[40*2*T 60*2*T]);
[b2, a2] = butter(2,[90*2*T 110*2*T]);
[b3, a3] = butter(2,[140*2*T 160*2*T]);

y50 = filtfilt(b1,a1,i4r);
y100 = filtfilt(b2,a2,i4r);
y150 = filtfilt(b3,a3,i4r);
hold on;
plot(w,abs(fft(y50)),'--g');
plot(w,abs(fft(y100)),'--r');
plot(w,abs(fft(y150)),'--m');

E50 = sum(y50.^2)/N
E = sum(i4r.^2)/N


%% 


