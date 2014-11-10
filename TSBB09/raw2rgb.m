function [ im_rgb] = raw2rgb(raw)
%RAW2RGB Summary of this function goes here
%   Detailed explanation goes here
raw = im2double(raw);
[rows,cols] = size(raw);
mask1=zeros(rows,cols);
mask1(2:2:end,2:2:end)=1;
mask2=zeros(rows,cols);
mask2(2:2:end,1:2:end)=1;
mask2(1:2:end,2:2:end)=1;
mask3=zeros(rows,cols);
mask3(1:2:end,1:2:end)=1;


f =[1 2 1]/4;


img1 = conv2(f,f,raw.*mask1,'same')./conv2(f,f,mask1,'same'); %should be f' for both directions?
img2 = conv2(f,f,raw.*mask2,'same')./conv2(f,f,mask2,'same'); %should be f' for both directions?
img3 = conv2(f,f,raw.*mask3,'same')./conv2(f,f,mask3,'same'); %should be f' for both directions?



im_rgb =reshape([img1 img2 img3],[size(raw) 3]);



end

