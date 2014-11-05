close all;
addpath CourseLib
%%
N=32;
w1 = 1;
T = 1;

n =[0:1:N];

x = cos(w1*n);
[Xp,w] = dtft(x,T);

plot(w,abs(Xp));


%%
load('/Users/Jens/Programmering/Courses/TSRT78/CourseLib/power.mat')

T = 3.9*10^(-4);

u3 = u2(1:3:end);

[Xp2 w2] = dtft(u2,T);
[Xp3 w3] = dtft(u3,3*T);
%we need to slow the sampling down since the samples are 3 times further
%apart.



figure;

subplot(223);
plot(u2);

subplot(224);
plot(u3);


subplot(221);
plot(w2,abs(Xp2));

subplot(222);
plot(w3,abs(Xp3));

%%
%b

u3 = decimate(u2,3);


[Xp2 w2] = dtft(u2,T);
[Xp3 w3] = dtft(u3,3*T);
%we need to slow the sampling down since the samples are 3 times further
%apart.

figure;

subplot(223);
plot(u2);

subplot(224);
plot(u3);


subplot(221);
plot(w2,abs(Xp2));

subplot(222);
plot(w3,abs(Xp3));

%%


n = [0:1:15];


x0 = cos(2*pi/8*n);
x1 = cos(2*pi/7*n);

Y0 = fft(x0);
Y1 = fft(x1);


figure;
subplot(221);
stem(2*pi/N*n,abs(Y0));

subplot(222);
stem(2*pi/N*n,abs(Y1));

p = 10;
N = 16;
k = N*(p-1);
pad = zeros(1,k);

x2 =[x0 pad];
x3 =[x1 pad];


Y2 = fft(x2);
Y3 = fft(x3);



subplot(223);
stem(2*pi/N/p*(0:N*p-1),abs(Y2))

subplot(224);
stem(2*pi/N/p*(0:N*p-1),abs(Y3));

%%
N = 16;
w0 = 2*pi/(sqrt(17));

n =[0:N-1];

x = sin(w0*n);

%16 point DFT of x.

X = fft(x,N);
X2 = fft(x,2*N);
X4 = fft(x,4*N);
X8 = fft(x,8*N);
figure;
subplot(221);
t = 2*pi/(N)*(0:2*N-1);
plot(2*pi/(N)*(0:N-1),abs(X));


subplot(222); 
plot(2*pi/(2*N)*(0:2*N-1),abs(X2));
hold on; stem(2*pi/(N)*(0:N-1),abs(X));


subplot(223); 
plot(2*pi/(4*N)*(0:4*N-1),abs(X4));
hold on; stem(2*pi/(N)*(0:N-1),abs(X));


subplot(224); 
plot(2*pi/(8*N)*(0:8*N-1),abs(X8));
hold on; stem(2*pi/(N)*(0:N-1),abs(X));

%%


