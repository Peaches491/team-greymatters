%% Generate Meshes and Plot

clc; clear all; 
% close all; 
clf();

global endLength;
endLength = .0254; %the length of the end of a link determines spacing for parallel links 
global width;
width = .006; % the width of all links (should get from CADD Model)
global depth;
depth = .006; % the z depth for all links (material thickness)
global spacing;
spacing = .02; % the space between the two sets of four-bars  
bore = 0.6;

% Add relevant function paths
addpath('Collision');
addpath('Graphing');
addpath('Models');
addpath('RCM Modeling');
plotSetup((bore/2)*1.2);
% plotSetup((bore/2)*0.8);
% view(-90, 42)
% view(0, 0);
view(0, 0);
% view(236, 16);
% camproj('orthographic');


L1 = .2;
L2 = .2;
r1 = 0.025;
r2 = 0.025;
L3 = .15;

TS = eye(4);
TS(1:3, 1:3) = compose_rotation(0, pi/4, 0);
spheres = dlmread('Models/head.spheres');
sphere_vec = tfSpheres(spheres, TS);
% for x = 1:size(sphere_vec, 1)
%    plotSpheres(sphere_vec(x, :));
% end



[x, y, z] = entryFromPolar(-40, 15, sphere_vec);
entry = [x, y, z];
scatter3(entry(1), entry(2), entry(3), 120, 'filled');
goal = [0.05896, 0.02894, 0.064]; %workspace location

ws = makeWorkspace(goal, 0.025, 2);
scatter3(ws(:, 1), ws(:, 2), ws(:, 3), 20, 'r', 'filled');



Xb = 0;
Yb = -0.12;
Zb = -0.15;

[L1m, L1bm, L2m, L2bm] = makeRCM(L1, L2, r1, r2);
for x = 1:size(ws, 1)
    [theta1, theta2, Tx, Ty, Tz] = RCMInvKin(L1, L2, L3, entry, ws(x, :), Xb, Yb, Zb);
    [L1m, L1bm, L2m, L2bm] = makeRCM(L1, L2, r1, r2);
    [L1X, L1Y, L1Z, L2X, L2Y, L2Z] = configRCM(L1, L2, L3, Tz, Ty, Tx, theta1, theta2, L1m, L1bm, L2m, L2bm, Xb, Yb, Zb);
    plotModel(L1X, L1Y, L1Z, L2X, L2Y, L2Z);
    PlotRCM(Tx, Ty, Tz, theta1, theta2 ,L1,L2,L3, Xb, Yb, Zb);
end

% [Xr, Yr, Zr] = pointsFromPatches(double([L1X, L2X]), double([L1Y, L2Y]), double([L1Z, L2Z]));
% scatter3(Xr, Yr, Zr, 40, checkPoints(sphere_vec, [Xr; Yr; Zr]', bore/2, [0, 0, 0.03]), 'filled');

TB = eye(4);
TB(1, 4) = Xb;
TB(2, 4) = Yb;
TB(3, 4) = Zb;
plotCoordTrans(TB, '', 0.06);

light('Position',[1 3 2]); 
light('Position',[-3 -1 3]); 
material shiny; 

show_model_trans_stl('Models/newMeshes/brain_low.stl', TS, [1 0.75 0.65], 0.4, 'none');
show_model_trans_stl('Models/newMeshes/skin_tilt_low.stl', TS, 'white', 0.4, 'none');
% show_model_trans_stl('Models/newMeshes/skull.stl', TS, 'white', 0.4, 'none');

[Z, Y, X] = cylinder(bore/2);
Z = Z + 0.03;
X = (X - 0.5).*0.6;
% surf(X, Y, Z, 'FaceColor', 'b', 'FaceAlpha', 0.1, 'SpecularStrength', 0);


%%
%

disp('Running IK Iterations over Workspace');
for x = 1:size(ws, 1)
    iterIK(L1, L2, entry, goal, Xb, Yb, Zb, L1m, L1bm, L2m, L2bm, sphere_vec, bore)
end










