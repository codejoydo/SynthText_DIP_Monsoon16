% im - input image
% x,y - vector consisting of x,y coordinate of images
% inds - indices on which transform to be made

function out = tform(im,x,y,t,inds)

x = reshape(x,1,size(x,1)*size(x,2));
y = reshape(y,1,size(y,1)*size(y,2));
pt = t*[x(:)';y(:)';ones(1,size(x,1)*size(x,2))];
x(inds) = pt(1,:);
y(inds) = pt(2,:);
x = reshape(x,size(im,1),size(im,2));
y = reshape(y,size(im,1),size(im,2));
x1 = min(x(:)):1:max(x(:));
y1 = min(y(:)):1:max(y(:));
[x,y] = ndgrid(x1,y1);

s1 = size(x,1);
s2 = size(x,2);
x = reshape(x,1,size(x,1)*size(x,2));
y = reshape(y,1,size(y,1)*size(y,2));
pt1 = inv(t)*[x(:)';y(:)';ones(1,size(x,1)*size(x,2))];
x(:) = pt1(1,:);
y(:) = pt1(2,:);
x = reshape(x,s1,s2);
y = reshape(y,s1,s2);
disp(x);
disp(y);
out = zeros(size(x,1),size(x,2),size(im,3));

out(:,:,1) = interp2(double(im(:,:,1)),y,x);
out(:,:,2) = interp2(double(im(:,:,2)),y,x);
out(:,:,3) = interp2(double(im(:,:,3)),y,x);
out = uint8(out);
imshow(out,[]);
end