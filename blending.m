function Y=blending(SX,SY,EX,EY,target,source,slope)
% % Target
% target = double(imread('Data/test1.jpg'));
% 
% % Source
% source = double(imread('Data/text1.jpg'));
% girl=double(source);
target=double(target);
girl=source;
[Lh, Lv] = imgrad(target);


X = target;
Fh = Lh;
Fv = Lv;

LY=SX;
LX=SY;
% h=EX-SX;
% w=EY-SY;
h=size(girl,1)-1;
w=size(girl,2)-1;

be = X(LY:LY+h,LX:LX+w,:);
MD=mode(be);
mn=uint8(mean(MD));
% disp(mn);
for i=1:size(girl,1)
    for j=1:size(girl,2)
        if girl(i,j,1)~=0 && girl(i,j,2)~=0 && girl(i,j,3)~=0
            girl(i,j,:)=mn;
        else
            girl(i,j,:)=max(0,mn-50);
        end
    end
end
% figure,imshow(girl,[]);
girl=double(girl);
[Gh, Gv] = imgrad(girl);

X(LY:LY+h,LX:LX+w,:) = girl(:,:,:);

Fh(LY:LY+h,LX:LX+w,:) = Gh(:,:,:);
Fv(LY:LY+h,LX:LX+w,:) = Gv(:,:,:);

msk = zeros(size(X));
msk(LY:LY+h,LX:LX+w,:) = 1;

X=imrotate(X,slope);
Fh=imrotate(Fh,slope);
Fv=imrotate(Fv,slope);
msk=imrotate(msk,slope);


% Removing boundary

[a,b]=ndgrid(1:size(X,1),1:size(X,2));
temp=rgb2gray(X);
ind=find(temp>0);
start_x=a(ind(1));
start_y=b(ind(1));
end_x=a(ind(end));
end_y=b(ind(end));
X=X(start_x:end_x,start_y:end_y,:);
Fh=Fh(start_x:end_x,start_y:end_y,:);
Fv=Fv(start_x:end_x,start_y:end_y,:);
msk=msk(start_x:end_x,start_y:end_y,:);




imwrite(uint8(X),'X.png');
tic;
Y = PoissonJacobi( X, Fh, Fv, msk );
toc
imwrite(uint8(Y),'Yjc.png');
tic;
Y = PoissonGaussSeidel( X, Fh, Fv, msk );
toc
imwrite(uint8(Y),'Ygs.png');




end