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
cert = double(rand(1,101)>0.40);
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


f12 = b0.*a.*b1; f12 = f12(end:-1:1);
f11 = b0.*a.*b0; f11 = f11(end:-1:1);
f22 = b1.*a.*b1; f22 = f22(end:-1:1);
G11 = conv(cert,f11,'same');% <- f(a,c,b0,b0) what?!
G12 = conv(cert,f12,'same');% <- f(a,c,b1,b0)
G22 = conv(cert,f22,'same');%;conv(...); <- f(a,c,b1,b1)


detG = G11.*G22-G12.^2;
c0 = (G22.*h0-G12.*h1)./detG;
c1 = (-G12.*h0+G11.*h1)./detG; figure(6);
subplot(2,1,1);plot(c0)
subplot(2,1,2);plot(c1)

%%

im = double(imread('Scalespace0.png'));
figure(7);colormap(gray);imagesc(im);

cert = double(rand(size(im)) > 0.97); imcert = im.*cert;
figure(8);colormap(gray);imagesc(imcert);

x = ones(23,1)*(-11:11)
y = x'
a = exp(-(x.^2+y.^2)/4);
figure(9);mesh(a);


imlp = conv2(imcert, a, 'same');
figure(10);colormap(gray);imagesc(imlp);

G = conv2(cert,a,'same');

c = imlp./G;
minG = min(min(G))
figure(12);colormap(gray);imagesc(c);