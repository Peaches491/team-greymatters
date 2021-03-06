clc; close all; clear all; 

addpath('Collision');
addpath('Graphing');
addpath('Models');
addpath('RCM Modeling');

global endLength  
endLength = .0254; %the length of the end of a link determins spaceing for paralel links 
global width
width = .006; % the width of all links (should get from CADD Model)
global depth, 
depth = .006; % the z depth for all links (material thickness)
global spacing 
spacing = .02; % the space between the two sets of four-bars  

L1 = .12;
L2 = .2;
L3 = .15;
r1 = .01;
r2 = .01;

 p1 = [0,.1,.1]; %entry location 
 p2 = [.05,.05,0]; %workspace location 
% 
% 
[theta1, theta2, Tx, Ty, Tz] = RCMInvKin(L1, L2, L3, p1, p2);

%makeLink(.1, .01, 30, 1);

[L1m L1bm L2m L2bm] = makeRCM(L1, L2, r1, r2);
[L1X,L1Y,L1Z,L2X,L2Y,L2Z] = configRCM(L1, L2, L3, Tz, Ty, Tx, theta1, theta2, L1m, L1bm, L2m, L2bm);

clf;
view(3);
PlotRCM(Tx,Ty,Tz,theta1,theta2,L1,L2,L3);
hold on;
scatter3(p1(1),p1(2),p1(3), 100,'fill', 'g');
scatter3(p2(1),p2(2),p2(3), 100,'fill', 'r');

plotModel(L1X, L1Y, L1Z, L2X, L2Y, L2Z);


axis([-.2, .2, -.2, .2, -.2, .2]);
%axis equal