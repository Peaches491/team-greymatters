function [ bar ] = checkPoints( sphere_vec, point, r, Tc)
%CHECKPOINTS Summary of this function goes here
%   Detailed explanation goes here

    [p,q] = meshgrid(1:size(point,1), 1:size(sphere_vec,1));
    this = sqrt(sum((point(p(:),:) - sphere_vec( q(:),1:3)).^2, 2)) < ...
        repmat(sphere_vec(:,4),size(point,1),1);
    
    bar = sum(reshape(this, size(sphere_vec,1), size(point,1)))' > 0;
    
    if nargin > 2
        bar = max(bar, hypot(point(:, 2), point(:, 3)) > r);
    end
    
    
end

