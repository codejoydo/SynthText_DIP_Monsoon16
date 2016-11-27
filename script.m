clc
clear
close all
im = imread('Data/test12.jpg');
text_image=imread('Data/text4.tif');
load('SuppressionResults/test12.mat');
im=imresize(im,size(FI.O));
[segim,bound] = getboundary(FI.O,1);
% imshow(segim,[]);
rect = bana_Rect(bound);
aaa = rect.bounding_points;
aa = [];
aa = [aa;aaa(1,:)];
aa = [aa;aaa(3,:)];
aa = [aa;aaa(4,:)];
aa = [aa;aaa(2,:)];
if norm(aa(1,:)-aa(2,:)) < norm(aa(2,:)-aa(3,:))
    slop = atan((aa(2,2)-aa(1,2))/(aa(2,1)-aa(1,1)));
else
    slop = atan((aa(3,2)-aa(2,2))/(aa(3,1)-aa(2,1)));
end
slop = (slop*180)/pi;
out = make_rect(im,aa);
% figure,imshow(out);

CC = bwconncomp(segim);

orient = regionprops(CC,'Orientation');
segim = imrotate(segim,-slop);
segim = imclose(segim,strel('diamond',4));
[SX,SY,EX,EY]=max_areaRect(segim);
EX = int32((SX+EX)/2);
EY = int32((SY+EY)/2);
% EX = int32((SX+EX)/2);
% EY = int32((SY+EY)/2);
% EX = int32((SX+EX)/2);
% EY = int32((SY+EY)/2);
segim(SX:EX,SY:EY) = 0;
% figure,imshow(segim);
segim = imrotate(segim,slop);


im=imrotate(im,-slop);
% Blending the target and source.
blended=merger(SX,SY,EX,EY,im,text_image,slop);


%blended = imrotate(blended,slop);
% figure,imshow(blended,[]);
% rect = fit_rectangle(bound);
% aaa = rect.bounding_points;
% aa = [];
% aa = [aa;aaa(1,:)];
% aa = [aa;aaa(3,:)];
% aa = [aa;aaa(4,:)];
% aa = [aa;aaa(2,:)];
% out = make_rect(im,aa);
% figure,imshow(out);