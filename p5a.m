% example - rotation
% im = imread('bell.jpg');
% theta = 10;
% theta = (pi*theta) / 180;
% t = [cos(theta),sin(theta),0;-sin(theta),cos(theta),0;0,0,1];
% [x,y] = ndgrid(1:size(im,1),1:size(im,2));
% [x1,y1] = ndgrid(1:size(im,1),1:size(im,2));
% inds = 1:size(im,1)*size(im,2);
% inds = inds';

% im - input image
% x,y - vector consisting of x,y coordinate of images
% inds - indices on which transform to be made
% adj_im - 0/1 if to adjust image to the center 
% is_pol - 0/1 if need to convert to polar coordinates for transform

function out = p5a(im,x,y,t,inds,adj_im,is_pol)
    x = reshape(x,1,size(x,1)*size(x,2));
    y = reshape(y,1,size(y,1)*size(y,2));
    if is_pol
        [x,y] = cart2pol(x,y); 
    end
    pt = t*[x(inds);y(inds);ones(1,size(inds,1))];
    x(inds) = pt(1,:);
    y(inds) = pt(2,:);
    if is_pol
        [x,y] = pol2cart(x,y);
    end
    x = reshape(x,size(im,1),size(im,2));
    y = reshape(y,size(im,1),size(im,2));
    if adj_im==1
        xmid = (min(x(:))+max(x(:)))/2;
        ymid = (min(y(:))+max(y(:)))/2;
        imxmid = (1+size(im,1))/2;
        imymid = (1+size(im,2))/2;
%         x1 = min(x(:)):max(x(:));
%         y1 = min(y(:)):max(y(:));
%         [x,y] = ndgrid(x1,y1);
        x = x + imxmid - xmid;
        y = y + imymid - ymid;
    end
    if adj_im==1
        out = zeros(size(x,1),size(x,2),size(im,3));
    else
        out = zeros(size(im,1),size(im,2),size(im,3));
    end
    out(:,:,1) = interp2(double(im(:,:,1)),y,x);
    out(:,:,2) = interp2(double(im(:,:,2)),y,x);
    out(:,:,3) = interp2(double(im(:,:,3)),y,x);
    out = uint8(out);
    imshow(out,[]);
end