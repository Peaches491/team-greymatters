function [ x_out, y_out, z_out ] = entryFromPolar( az, el, sphere_vec, r, step)
%ENTRYFROMPOLAR Convert polar entry location to euclidian
%   Models the entry location of the RCM end effector as two polar
%   coordinates. Will return the point on the surface of the head along the
%   specified axis less than a distance r from the center of the brain.
%   Will return the max distance specified by r
    
    conv = @(az, el, r) sph2cart(az*pi/180, el*pi/180, r);

    if nargin < 5
        step = 0.002;
        if nargin < 4
            r = 0.5;
        end
    end
    
    for rr = fliplr(0.0:step:r)
        [x, y, z] = conv(az,el,rr);
        p = [x, y, z] + [0.03, 0.00, 0.03];
        if(checkPoints(sphere_vec, p))
            x_out = p(1);
            y_out = p(2);
            z_out = p(3);
            return
        end    
    end
    [x, y, z] = conv(az,el,r);
    p = [x, y, z] + [0.03, 0.00, 0.03];
    x_out = p(1);
    y_out = p(2);
    z_out = p(3);
end

