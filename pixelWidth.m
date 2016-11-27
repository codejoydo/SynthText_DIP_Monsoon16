function ret=pixelWidth(im)
ret=im;
imgray = rgb2gray(im);
imbw = 1-im2bw(imgray);
imbw = imdilate(imbw,strel('line',3,0));
imbw = imdilate(imbw,strel('line',3,90));
imbw = uint8(1-imbw);
imbw = 255*imbw;
ret(:,:,1) = imbw;
ret(:,:,2) = imbw;
ret(:,:,3) = imbw;
end