close all;
clear all; 
clc; 
addpath 'lab1Files/';

run 'readfox.m';

%The script readfox.m simply reads a wav file into foxsound.

N=160;

%%
order = 8;
subplot(211);
plot(abs(fft(foxsound)))
fs = fSamp; %8kHz
Ts  = 2; %the whole signal is 2 seconds long.
T = 1/fs;

fox_filt = foxsound;
subplot(212);
plot(abs(fft(fox_filt)))

%%
for i = 0:24000/N-1;
    sound_seg(i+1,:) = detrend(fox_filt(i*N+1:N*(i+1)),'constant');
    sys = ar(sound_seg(i+1,:),order);
    r2 = sys.a;
    if max(abs(roots(sys.a))) >= 1
        % Print warning.
        disp('Unstable roots!');
        r2 = polystab(sys.a);
        abs(roots(r2))
    end
    ar_seg(i+1,:) =r2;
end


%%        

sound_recon = []
sound_recon_1 = []

for i = 0:24000/N-1;
    e = filter(ar_seg(i+1,:),1,sound_seg(i+1,:));
    r = covf(e',100);
    [val idx] = max(r(19:end));
    idx = idx+20;
    P = idx;
    u = zeros(N,1); 
    for k=0:N-1
        if(mod(k,P) == 0)
            u(k+1,1) = 1;
        end 
    end
    ehat = u;
    yhat = filter(1,ar_seg(i+1,:),ehat);
    sound_recon_1 =[sound_recon_1 yhat'];
end




for i = 0:24000/N-1;
    e = filter(ar_seg(i+1,:),1,sound_seg(i+1,:));
    r = covf(e',100);
    [val idx] = max(r(19:end));
    idx = idx+20;
    P = idx;
    u = zeros(N,1); 
    for k=0:N-1
        if(mod(k,P) == 0)
            u(k+1,1) = 1;
        end 
    end
    ehat = sqrt(val)*u;
    yhat = filter(1,ar_seg(i+1,:),ehat);
    sound_recon =[sound_recon yhat'];
end


nSamp = size(fox_filt,1); % number of samples
t = (0:nSamp-1)/fSamp; % time vector in seconds

subplot(312);
plot(t,sound_recon')
title('Reconstructed sound');xlabel('t');
subplot(311);
plot(t,fox_filt);
title('Recorded sound');xlabel('t');
subplot(313);
plot(t,sound_recon_1(1:24000)');
title('Constant amplitude reconstructed sound')
xlabel('Time (s)')

print -dpng Report/recon.png
