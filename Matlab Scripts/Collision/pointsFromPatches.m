function [ Xr, Yr, Zr ] = pointsFromPatches( X, Y, Z )
%POINTSFROMPATCHES Summary of this function goes here
%   Detailed explanation goes here
    Xr = [X(1,:), X(2,:), X(3,:), X(4,:)];
    Yr = [Y(1,:), Y(2,:), Y(3,:), Y(4,:)];
    Zr = [Z(1,:), Z(2,:), Z(3,:), Z(4,:)];

end

