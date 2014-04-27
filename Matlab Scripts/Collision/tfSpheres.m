function [ new_sphere_vec ] = tfSpheres( sphere_vec, TF )
%TFSPHERES Summary of this function goes here
%   Detailed explanation goes here

    sizes = sphere_vec(:, 4);
    offset = TF(1:3, 4);
        
    sphere_vec(:, 4) = [];
    
    sphere_vec = sphere_vec*TF(1:3, 1:3)';
    
    sphere_vec = bsxfun(@plus,sphere_vec,offset');
    new_sphere_vec = horzcat(sphere_vec, sizes);
end

