function [A] = imgseg(im, nseg)
    run('../../../cvitstuff/vlfeat-0.9.20/toolbox/vl_setup.m');
    esp = 0.001;
    eps = 1;
    J = rgb2hsv(im);
    H = J(:,:,1);
    Igray = rgb2gray(im);
    M = size(im,1);
    N = size(im,2);
    R = im(:,:,1);
    G = im(:,:,2);
    B = im(:,:,3);
    E = entropyfilt(Igray);
    [X,Y] = ndgrid(1:M,1:N);
    X = esp*X;
    Y = esp*Y;
    R = R*eps;
    B = B*eps;
    G = G*eps;
    H = H*255;
    E = (1+5*esp)*E;
    H = H(:)';R = R(:)';G = G(:)';B = B(:)';E = E(:)';X = X(:)';Y = Y(:)';
    vec = double([R;G;B;X;Y;E]);
    disp(size(vec));
    [~,A] = vl_kmeans(vec,nseg,'Initialization', 'plusplus');
    disp(size(A));
    A = reshape(A,[M,N]);
end