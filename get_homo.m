function v = get_homo(pin, pout)
    pin = pin';
    pout = pout';
    n = size(pin, 2);
    x = pout(1, :); y = pout(2,:); X = pin(1,:); Y = pin(2,:);
    rows0 = zeros(3, n);
    rowsXY = -[X; Y; ones(1,n)];
    hx = [rowsXY; rows0; x.*X; x.*Y; x];
    hy = [rows0; rowsXY; y.*X; y.*Y; y];
    h = [hx hy];
    [U, ~, ~] = svd(h);
    v = (reshape(U(:,9), 3, 3)).';
end
