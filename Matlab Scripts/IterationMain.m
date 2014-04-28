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

[x, y, z] = entryFromPolar(-40, 15, sphere_vec);
entry = [x, y, z];

goal = [0.07896, 0.02894, 0.014]; %workspace location

Xb = 0;
Yb = -0.12;
Zb = -0.15;

[L1m, L1bm, L2m, L2bm] = makeRCM(L1, L2, r1, r2);

x = iterIK(L1, L2, entry, goal, Xb, Yb, Zb, L1m, L1bm, L2m, L2bm, sphere_vec, bore)




