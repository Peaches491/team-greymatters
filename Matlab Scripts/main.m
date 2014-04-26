%% Generate Meshes and Plot

clc; clear all; 
% close all; 
clf();

% Add relevant function paths
addpath('Collision');
addpath('Graphing');
addpath('Models');
addpath('RCM Modeling');
plotSetup(0.3)
% view(-90, 42)
view(0, 0)
% view(3);

% L1 = 5;
% L2 = 5;
% r1 = 0;
% r2 = 0;
% L3 = 5;
% 
% p1 = [5,5,5]; %entry location 
% p2 = [0,5,0]; %workspace location 
% 
% 
% [theta1, theta2, Tx, Ty, Tz] = RCMInvKin(L1, L2, L3, p1, p2);
% 
% 
% 
% [L1X L1Y L1Z L2X L2Y L2Z] = makeRCM(L1, L2, L3, r1, r2, Tz, Ty, Tx, theta1, theta2);
% plotModel(L1X, L1Y, L1Z, L2X, L2Y, L2Z);
% hold on;
% plotModel(L1X, L1Y, L1Z, L2X, L2Y, L2Z);



RCM
plotCoordTrans(TB, '', 0.06);
plotCoordTrans(TB*T1*T2*T3*T4*T5*T6*T7, '', 0.1);

TS = eye(4);
% TS(1:3, 1:3) = compose_rotation(0, -0.6*pi/2, 0);
TS(1:3, 1:3) = compose_rotation(0, pi/4, 0);

light('Position',[1 3 2]); 
light('Position',[-3 -1 3]); 
material shiny; 

spheres = dlmread('Models/head.spheres');
sphere_vec = tfSpheres(spheres, TS);

% for x = 1:size(sphere_vec, 1)
%    plotSpheres(sphere_vec(x, :));
% end


show_model_trans_stl('Models/newMeshes/brain_low.stl', TS, [1 0.75 0.65], 0.4, 'none')
show_model_trans_stl('Models/newMeshes/skin_tilt_low.stl', TS, 'white', 0.4, 'none')
% show_model_trans_stl('Models/newMeshes/skull.stl', TS, 'white', 0.4, 'none')

res = 0.01;
point = ([-1:res:1; -1:res:1; -1:res:1]' ).*0.1;
point = bsxfun(@plus,point,[0, 0, 0.06]);

X = point(:, 1);
Y = point(:, 2);
Z = point(:, 3);

scatter3(X, Y, Z, 50, checkPoints(sphere_vec, point), 'filled')





