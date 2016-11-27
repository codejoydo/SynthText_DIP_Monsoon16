function [out] = make_rect(im,rect_points)
    X = rect_points(:,1)';
    Y = rect_points(:,2)';
    mask = poly2mask(Y, X,size(im,1),size(im,2));
    R = im(:,:,1);
    R(mask) = 255;
    im(:,:,1) = R;
    out = im;
end