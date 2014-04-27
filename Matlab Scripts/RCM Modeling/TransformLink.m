function [Rx Ry Rz] = TransformLink(X, Y, Z, H)

[Xr, Yr, Zr] = pointsFromPatches(X, Y, Z);

s = size(X);
length = s(2);

P = H*[Xr; Yr; Zr; (zeros(1,4*length)+1)];


Rx = [P(1,1:length); P(1,length+1:2*length); P(1,2*length+1:3*length); P(1,3*length+1:4*length)];
Ry = [P(2,1:length); P(2,length+1:2*length); P(2,2*length+1:3*length); P(2,3*length+1:4*length)];
Rz = [P(3,1:length); P(3,length+1:2*length); P(3,2*length+1:3*length); P(3,3*length+1:4*length)];


end

