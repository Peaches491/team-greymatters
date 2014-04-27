%% Generate Meshes and Plot

clc; clear all; 
% close all; 
clf();

global endLength;
endLength = .0254; %the length of the end of a link determins spaceing for paralel links 
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
% view(-90, 42)
% view(0, 0);
view(90, 0);
% view(3);
camproj('orthographic');


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
goal = [0.07896, 0.02894, 0.014]; %workspace location
scatter3(goal(1), goal(2), goal(3), 100, 'r', 'filled');


[theta1, theta2, Tx, Ty, Tz] = RCMInvKin(L1, L2, L3, entry, goal);
[L1X, L1Y, L1Z, L2X, L2Y, L2Z] = makeRCM(L1, L2, L3, r1, r2, Tz, Ty, Tx, theta1, theta2);
plotModel(L1X, L1Y, L1Z, L2X, L2Y, L2Z);
PlotRCM(Tx, Ty, Tz, theta1, theta2 ,L1,L2,L3, 0, -0.12, -0.15);

[Xr, Yr, Zr] = pointsFromPatches(double([L1X, L2X]), double([L1Y, L2Y]), double([L1Z, L2Z]));
scatter3(Xr, Yr, Zr, 40, checkPoints(sphere_vec, [Xr; Yr; Zr]', bore/2, [0, 0, 0.03]), 'filled');


% plotCoordTrans(TB, '', 0.06);
% plotCoordTrans(TB*T1*T2*T3*T4*T5*T6*T7, '', 0.1);



light('Position',[1 3 2]); 
light('Position',[-3 -1 3]); 
material shiny; 

show_model_trans_stl('Models/newMeshes/brain_low.stl', TS, [1 0.75 0.65], 0.4, 'none');
show_model_trans_stl('Models/newMeshes/skin_tilt_low.stl', TS, 'white', 0.4, 'none');
% show_model_trans_stl('Models/newMeshes/skull.stl', TS, 'white', 0.4, 'none');


[Z, Y, X] = cylinder(bore/2)
Z = Z + 0.03;
X = (X - 0.5).*0.6;
surf(X, Y, Z, 'FaceColor', 'b', 'FaceAlpha', 0.1, 'SpecularStrength', 0);

% res = 0.01;
% point = ([-1:res:1; -1:res:1; -1:res:1]' ).*0.1;
% point = bsxfun(@plus,point,[0, 0, 0.06]);
% 
% X = point(:, 1);
% Y = point(:, 2);
% Z = point(:, 3);
% 
% scatter3(X, Y, Z, 50, checkPoints(sphere_vec, point), 'filled');


