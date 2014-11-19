w = 0.1;
N = 300;
order = 2;
y = sin((0:299)*0.1); 

t = ar(y,order);
r = roots(t.a)
angle(r)

%%
w = 0.1;
N = 300;
order = 2;
y2 = y +0.01*randn(size(y)); 

t2 = ar(y2,order);
r2 = roots(t2.a)
angle(r2)

bode(t2)

%%
%6.7 
load('/Users/Jens/Programmering/Courses/TSRT78/CourseLib/sig30.mat')

N = 100;
order = 2;
t = ar(y,10*order)
bode(t)
angle(roots(t.a))
%compare bode and angle. Find two dominating angles.

%%

load('/Users/Jens/Programmering/Courses/TSRT78/CourseLib/sig60.mat')

y1 = y(1:500);
y2 = y(501:1000);
Ne = 500;

order = 2;

t1 = ar(y1,1);
t2 = ar(y1,2);
t3 = ar(y1,3);

le(1) =sum(pe(y1,t1).^2)/Ne; %loss functions
le(2) =sum(pe(y1,t2).^2)/Ne;
le(3) =sum(pe(y1,t3).^2)/Ne;

epv1 = pe(y2,t1);
epv2 = pe(y2,t2); %residuals
epv3 = pe(y2,t3);

lv(1) = sum(epv1.^2)/Ne;
lv(2) = sum(epv2.^2)/Ne;
lv(3) = sum(epv3.^2)/Ne;

plot(1:3,le','-',1:3,lv,'--');

%%
te = etfe(y,30)
bode(t1,'-',t2,'--',t3,'-.',te,':')

r1 = covf(epv1,21);
r2 = covf(epv2,21);
r3 = covf(epv3,21);
k = 0:20;

plot(k,r2/r2(1))



