clc; clear all; close all;

name = 'outer_low';
S = load(strcat('Models/', name, '.bod'), '-mat');
P = S.P; t = S.t;

T = eye(4);
faceColor = 'y';
edgeColor = 'none';
alpha = 1;

P = bsxfun(@plus, (P * T(1:3, 1:3)), T(1:3, 4)');

X = reshape(P(t(:, 1:3)', 1)', [3, size(t, 1)]);
Y = reshape(P(t(:, 1:3)', 2)', [3, size(t, 1)]);
Z = reshape(P(t(:, 1:3)', 3)', [3, size(t, 1)]);

% patch(X, Y, Z, faceColor, 'EdgeColor', edgeColor, 'FaceAlpha', alpha);

X = X';
Y = Y';
Z = Z';


Q.vertices = S.P;
Q.faces = S.t;


tmpvol = zeros(20,20,20); % Empty voxel volume 
tmpvol(8:12,8:12,5:15) = 1; % Turn some voxels on 
fv = isosurface(tmpvol, 0.99); % Create the patch object 
stlwrite(strcat('Models/', name, '.stl'), Q) % Save to binary .stl
