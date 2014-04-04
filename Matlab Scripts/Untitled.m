function x =  Untitled(a)
    d_x = a(1);
    d_y = a(2);
    d_z = a(3);
    r = a(4);

    [x,y,z] = sphere(12);

    x = x*r + d_x;
    y = y*r + d_y;
    z = z*r + d_z;

    surf2patch(surf(x, y, z, 'FaceColor', 'y', 'FaceAlpha', 1.0, 'EdgeColor', 'none'));


%     c = [d_x, d_y, d_z];
%     X = [0, 0, 3];
%     inside = sum((c-X).^2) <= r^2;
    x = 0;
end    