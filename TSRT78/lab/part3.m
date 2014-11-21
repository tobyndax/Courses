close all;
clear all; 
clc; 
addpath 'lab1Files/';

run 'readfox.m'; %load data
%%
order = 10
subplot(211);
plot(abs(fft(foxsound)))
fs = fSamp; %8kHz
Ts  = 2; %the whole signal is 2 seconds long.
T = 1/fs;


[b1, a1] = butter(5,70*T,'high');
[b2, a2] = butter(5,3500*T,'low');

%fox_filt = filtfilt(b1,a1,foxsound);
%fox_filt = filtfilt(b2,a2,fox_filt);
fox_filt = detrend(foxsound);
subplot(212);
plot(abs(fft(fox_filt)))

%%

for i = 0:149;
    
    %sound_seg(i+1,:) = detrend(fox_filt(i*160+1:160*(i+1)),'constant');
    sound_seg(i+1,:) = fox_filt(i*160+1:160*(i+1));
    sys = ar(sound_seg(i+1,:),order);
    ar_seg(i+1,:) = sys.a; 
    check= abs(roots(sys.a))>1;
    for k = 1:order
        if(check(k))
            disp('unstable');
            %needs to be handled in case it happens
        end
    end
end


%%        

sound_recon = []
for i = 0:149;
    e = filter(ar_seg(i+1,:),1,sound_seg(i+1,:));
    r = covf(e',160);
    [val idx] = max(r(19:end));
    idx = idx+20;
    P = idx;
    N = 160;
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
plot(r)
soundsc(sound_recon',fSamp);
subplot(212);
plot(sound_recon')
subplot(211);
plot(fox_filt);
