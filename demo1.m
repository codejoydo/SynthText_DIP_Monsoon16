
lena = double(imread('Data/test1.jpg'));
girl = double(imread('Data/text1.jpg'));

[Lh Lv] = imgrad(lena);
[Gh Gv] = imgrad(girl);

X = lena;
Fh = Lh;
Fv = Lv;

w = 187;
h = 131;
LX = 180;
LY = 122;
% GX = 1;
% GY = 1;





X(LY:LY+h,LX:LX+w,:) = girl(:,:,:);
Fh(LY:LY+h,LX:LX+w,:) = Gh(:,:,:);
Fv(LY:LY+h,LX:LX+w,:) = Gv(:,:,:);

msk = zeros(size(X));
msk(LY:LY+h,LX:LX+w,:) = 1;

imwrite(uint8(X),'X.png');
tic;
Y = PoissonJacobi( X, Fh, Fv, msk );
toc
imwrite(uint8(Y),'Yjc.png');
tic;
Y = PoissonGaussSeidel( X, Fh, Fv, msk );
toc
imwrite(uint8(Y),'Ygs.png');
