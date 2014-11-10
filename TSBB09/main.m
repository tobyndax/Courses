addpath A-DigitalCamera
addpath A-DigitalCamera/bayer
addpath A-DigitalCamera/shadingcorr

%%

run shadcorr.m

fa = mean(mean(darkimage))
fb = mean(mean(whiteimage))

max(max(origimage));
min(min(origimage));

%%
%Shading correction
ownShad(darkimage,whiteimage,origimage)

%%

faBlack = mean(mean(blackimage))
ownShad(blackimage,whiteimage,origimage)

figure;
imagesc(origimage, [0 255]);
axis image;
axis off;
colormap(jet);

%%
%Interlaced images.

im = imread('A-DigitalCamera/interlaced_image.png');
im = im2double(im);

imshow(im)

%%
[rows, cols, ndim] = size(im);
mask1 = zeros(rows,cols);
mask1(1:2:end,:) = 1;
mask2 = zeros(rows,cols);
mask2(2:2:end,:) = 1;

imshow(im.*repmat(mask1,[1 1 3]));
figure;
imshow(im.*repmat(mask2,[1 1 3]));

%%

kern = [1 2 1]'/2;

im1 = zeros(size(im));
im2 = zeros(size(im));

for k =1:3
    bk = im(:,:,k);
    im1(:,:,k) = conv2(bk.*mask1,kern,'same');
    im2(:,:,k) = conv2(bk.*mask2,kern,'same');
end

imshow(im1);
figure;
imshow(im2);

%%

im=imread('bayer/raw0001.png');
im=im2double(im);
imshow(im);

[rows,cols] = size(im);

%GBRG
mask1=zeros(rows,cols);
mask1(2:2:end,1:2:end)=1;
mask2=zeros(rows,cols);
mask2(1:2:end,1:2:end)=1;
mask2(2:2:end,2:2:end)=1;
mask3=zeros(rows,cols);
mask3(1:2:end,2:2:end)=1;


im_rgb =reshape([im.*mask1 im.*mask2 im.*mask3],[size(im) 3]);

imshow(im_rgb)


%%
%RGGB
mask1=zeros(rows,cols);
mask1(2:2:end,2:2:end)=1;
mask2=zeros(rows,cols);
mask2(2:2:end,1:2:end)=1;
mask2(1:2:end,2:2:end)=1;
mask3=zeros(rows,cols);
mask3(1:2:end,1:2:end)=1;


im_rgb =reshape([im.*mask1 im.*mask2 im.*mask3],[size(im) 3]);

imshow(im_rgb)

%%
%BGGR
mask1=zeros(rows,cols);
mask1(1:2:end,1:2:end)=1;
mask2=zeros(rows,cols);
mask2(1:2:end,2:2:end)=1;
mask2(2:2:end,1:2:end)=1;
mask3=zeros(rows,cols);
mask3(2:2:end,2:2:end)=1;


im_rgb =reshape([im.*mask1 im.*mask2 im.*mask3],[size(im) 3]);

imshow(im_rgb)

%%
%GRBG
mask1=zeros(rows,cols);
mask1(2:2:end,1:2:end)=1;
mask2=zeros(rows,cols);
mask2(1:2:end,1:2:end)=1;
mask2(2:2:end,2:2:end)=1;
mask3=zeros(rows,cols);
mask3(1:2:end,2:2:end)=1;


im_rgb =reshape([im.*mask1 im.*mask2 im.*mask3],[size(im) 3]);

imshow(im_rgb)

%%

f =[1 2 1]/4;

img1 = conv2(f,f,im.*mask1,'same')./conv2(f,f,mask1,'same'); %should be f' for both directions?



img2 = conv2(f,f,im.*mask2,'same')./conv2(f,f,mask2,'same'); %should be f' for both directions?


img3 = conv2(f,f,im.*mask3,'same')./conv2(f,f,mask3,'same'); %should be f' for both directions?

im_rgb =reshape([img1 img2 img3],[size(im) 3]);

imshow(im_rgb)

%%
imraw = im2double(imread('A-digitalCamera/bayer/raw0002.png'));
imshow(raw2rgb(imraw));

%%

%Noise meas

fpath = 'bayer/';
im=cell(100,1);
for k = 1:100
    fname = sprintf('raw%04d.png',k); %leading zeros  digits insert.
    im{k}=imread([fpath fname]);
end


for k=1:100;
    imshow(raw2rgb(im{k})); %Film!!!
    axis([871 980 401 480]);
    drawnow;
end


%%
imm = zeros(size(im{1}));
imv = zeros(size(im{1}));
for k=1:100;
    imm = im2double(im{k}) + imm;
    imv = imv + im2double(im{k}).^2;
end
imv = imv/100;
imm = imm/100;
imv = imv - imm.*imm;
imp = imm.*imm;


imshow(raw2rgb(im{2}));
figure;
imshow(raw2rgb(imm));

%%
figure;
imshow(raw2rgb(imv)*10000);

S = imp;
N = imv;

SNR = N./S;
imshow(SNR*1000);

%%

indim=uint8(imm*255);
rhist=zeros(256,1);
ghist=zeros(256,1);
bhist=zeros(256,1);

for k=0:255;
    k
    redk=find(mask1);
    indk=redk(find(indim(redk)==k));
    rhist(k+1) = sum(imv(indk))/(length(indk)+eps);
    
    greenk=find(mask2);
    indk=greenk(find(indim(greenk)==k));
    ghist(k+1) = sum(imv(indk))/(length(indk)+eps);
    
    bluek=find(mask3);
    indk=bluek(find(indim(bluek)==k));
    bhist(k+1) = sum(imv(indk))/(length(indk)+eps);
end

plot([0:255],[bhist ghist rhist]*255^2)
axis([0 255 0 10])
grid on; 
