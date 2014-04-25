function Untitled(a)
    d_x = a(1);
    d_y = a(2);
    d_z = a(3);
    r = a(4);

    [x,y,z] = sphere(12);

    x = x*r + d_x;
    y = y*r + d_y;
    z = z*r + d_z;

    surf2patch(surf(x, y, z, 'FaceColor', 'y', 'FaceAlpha', 0.2, 'EdgeColor', 'none'));    
end    