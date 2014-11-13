k = 0:1:100;
s = sin(k/10);
figure(1);plot(s);

x=(-3:3)';
b0=ones(7,1);
b1=x;
b2=x.^2;
figure(2);
subplot(4,1,1);plot(b0,'-o');
subplot(4,1,2);plot(b1,'-o');
subplot(4,1,3);plot(b2,'-o');

a = exp(-x.^2/4);
figure(2);
subplot(4,1,4);plot(a,'-o');

f0 = b0.*a; f0 = f0(end:-1:1);
f1 = b1.*a; f1 = f1(end:-1:1);
f2 = b2.*a; f2 = f2(end:-1:1);
figure(3);
subplot(3,1,1);plot(f0,'-o');
subplot(3,1,2);plot(f1,'-o');
subplot(3,1,3);plot(f2,'-o');

h0 = conv(s,f0,'same');
h1 = conv(s,f1,'same');
h2 = conv(s,f2,'same');

G0 = diag(a);
B = [b0 b1 b2];
G = B'*G0*B


c = inv(G)*[h0;h1;h2];
figure(4);
subplot(3,1,1);plot(c(1,:))
subplot(3,1,2);plot(c(2,:))
subplot(3,1,3);plot(c(3,:))

%% 4
cert = double(rand(1,101)>0.2);
scert = s.*cert;
figure(5);plot(scert);


h0 = conv(scert,f0,'same');
h1 = conv(scert,f1,'same');
h2 = conv(scert,f2,'same');

G0 = diag(a);
B = [b0 b1 b2];
G = B'*G0*B


c = inv(G)*[h0;h1;h2];
figure(4);
subplot(3,1,1);plot(c(1,:))
subplot(3,1,2);plot(c(2,:))
subplot(3,1,3);plot(c(3,:))