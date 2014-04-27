function drawSpheres(sphere_vec, varargin)

    if nargin == 1
        varargin = ['FaceColor', 'y', 'FaceAlpha', 1.0, 'EdgeColor', 'none'];
    end
    
    d_x = sphere_vec(1);
    d_y = sphere_vec(2);
    d_z = sphere_vec(3);
    r = sphere_vec(4);

    [x,y,z] = sphere(12);

    x = x*r + d_x;
    y = y*r + d_y;
    z = z*r + d_z;

    surf2patch(surf(x, y, z, varargin));    
end    