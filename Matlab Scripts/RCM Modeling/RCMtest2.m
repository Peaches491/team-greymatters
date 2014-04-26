clc; close all; clear all; 
 
global endLength  
endLength = .0254; %the length of the end of a link determins spaceing for paralel links 
global width
width = .006; % the width of all links (should get from CADD Model)
global depth, 
depth = .006; % the z depth for all links (material thickness)
global spacing 
spacing = .02; % the space between the two sets of four-bars  

L1 = .1;
L2 = .1;
L3 = .1;
r1 = 0;
r2 = 0;

% p1 = [5,5,5]; %entry location 
% p2 = [0,5,0]; %workspace location 
% 
% 
% [theta1, theta2, Tx, Ty, Tz] = RCMInvKin(L1, L2, L3, p1, p2);

%makeLink(.1, .01, 30, 1);

[L1X L1Y L1Z L2X L2Y L2Z] = makeRCM(L1, L2, L3, r1, r2, 0, 0, 0, 0, 0);

clf;
view(3);
PlotRCM(0,0,0,0,0,L3,L1,L2);
hold on;
plotModel(L1X, L1Y, L1Z, L2X, L2Y, L2Z);


axis([-.5, .5, -.5, .5, -.5, .5]);
axis equal