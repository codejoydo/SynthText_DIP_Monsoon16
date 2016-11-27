I = imread('Data/test17.jpg');
M = int32(1000*(double(size(I,1))/double(size(I,2))));
I = imresize(I,[M,1000]);
imwrite(I,'Data/test17.jpg');
figure,imshow(I);
O = imgseg(I,3);
% O = imclose(O,strel('disk',4));
figure,imshow(O,[]);
save('Results/test17.mat','O');
% Irgb = rgb2gray(I);
% E = entropyfilt(Irgb);
% Eim = mat2gray(E);
% figure,imshow(Eim);
% BW1 = im2bw(Eim, .8);
% % imshow(BW1);
 
