function result=corner_map(img)
    Gx = [-1 0 1; -2 0 2; -1 0 1];
    Gy = Gx';
    
    Ix = conv2(double(img), Gx, 'same');
    Iy = conv2(double(img), Gy, 'same');
    
    Ix2 = Ix.^2;
    Iy2 = Iy.^2;
    Ixy = Ix .* Iy;
    
    h = fspecial('gaussian', [7 7], 1.5);
    Ix2 = conv2(Ix2, h, 'same');
    Iy2 = conv2(Iy2, h, 'same');
    Ixy = conv2(Ixy, h, 'same');
    
    k = 0.04;
    R = (Ix2 .* Iy2 - Ixy.^2) - k * (Ix2 + Iy2).^2;
    
    threshold = 0.05 * max(R(:));
    corner_map = R > threshold;
    result = imregionalmax(R) & corner_map;
end