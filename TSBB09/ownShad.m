function [] = ownShad(darkimage,whiteimage,origimage)
%OWNSHAD Summary of this function goes here
%   Detailed explanation goes here

fa = mean(mean(darkimage));
fb = mean(mean(whiteimage));

figure;
c = (fa-fb)./(darkimage-whiteimage);
d = (fb*darkimage - fa*whiteimage)./(fa-fb);

f = c.*(origimage+d);

imagesc(f, [0 255]);
axis image;
axis off;
colormap(jet);

end

