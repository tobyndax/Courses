close all;
clear all; 
clc; 
addpath 'lab1Files/';

run 'readfox.m'; %load data
close all;
N = 160;
p = 10;
Fs = 8000;


for k = 1:24000/N
    n = (k-1)*N+[1:N];
    frame =detrend(foxsound(n));
    a(k,:) = lpc(frame,p);
end


sound_recon = []
for i = 0:(24000/N-1);
    n = (i)*N+[1:N];
    e = filter(a(i+1,:),1,foxsound(n));
    r = covf(e,100);
    [val idx] = max(r(19:end));
    idx = idx+19;
    P=idx;
    N = 160;
    u = zeros(N,1);
    for k=0:N-1
        if(mod(k,P) == 0)
            u(k+1,1) = 1;
        end 
    end
    ehat = u*sqrt(val);
    yhat = filter(1,a(i+1,:),ehat);
    sound_recon =[sound_recon yhat'];
end
plot(r)
soundsc(sound_recon',fSamp);
subplot(212);
plot(sound_recon')
subplot(211);
plot(foxsound);
