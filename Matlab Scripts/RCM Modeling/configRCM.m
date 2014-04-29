function [L1X,L1Y,L1Z,L2X,L2Y,L2Z] = configRCM(L1, L2, L3, Tz, Ty, Tx, theta1, theta2, L1m, L1bm, L2m, L2bm, X0,Y0,Z0)
 %% Transfroms for RCM Position
global endLength 
global depth
global spacing


if nargin <= 12
    X0 = 0;
    Y0 = 0;
    Z0 = 0;
end

Tz = Tz+Z0;
Ty = Ty+Y0;
Tx = Tx+X0;


L1X = L1m(1:4, :);
L1Y = L1m(5:8, :);
L1Z = L1m(9:12, :);

L1bX = L1bm(1:4, :);
L1bY = L1bm(5:8, :);
L1bZ = L1bm(9:12, :);

L2X = L2m(1:4, :);
L2Y = L2m(5:8, :);
L2Z = L2m(9:12, :);

L2bX = L2bm(1:4, :);
L2bY = L2bm(5:8, :);
L2bZ = L2bm(9:12, :);

%% Transfroms for RCM Position
 T1 = DHTransform(Tz,0,0,-pi/2);
 T2 = DHTransform(Ty,pi/2,0,pi/2);
 T2b = DHTransform(Ty-endLength,pi/2,0,pi/2);
 T3 = DHTransform(Tx,pi,0,pi/2);
 T4 = DHTransform(0,theta1,0,pi/2);
 
 p = [ 0; 0; spacing];
 T4b1 = [ [1,0,0;0,1,0;0,0,1], p; 0 0 0 1];
 p = [ 0; 0; -spacing-depth];
 T4b2 = [ [1,0,0;0,1,0;0,0,1], p; 0 0 0 1]; 
 p = [ 0; 0; -spacing+depth];
 T4b3 = [ [1,0,0;0,1,0;0,0,1], p; 0 0 0 1];
 
 
 T5 = DHTransform(0,theta2,L1,0);
 T5b = DHTransform(0,theta2,L1+endLength,0);
 T6 = DHTransform(0,(pi/2)-theta2,L2,0);
 T7 = DHTransform(0,(pi/2)+theta2,L3,-pi/2); 

 %% Transform side 1 links 
 H = T1*T2*T3*T4*T4b1*T5;
 [L1S1X L1S1Y L1S1Z] = TransformLink(L1X, L1Y, L1Z, H);
 
 H = T1*T2b*T3*T4*T4b1*T5;
 [L1S1bX L1S1bY L1S1bZ] = TransformLink(L1bX, L1bY, L1bZ, H);
 
 H = T1*T2*T3*T4*T4b1*T5*T6;
 [L2S1X L2S1Y L2S1Z] = TransformLink(L2X, L2Y, L2Z, H);
 
 H = T1*T2*T3*T4*T4b1*T5b*T6;
 [L2S1bX L2S1bY L2S1bZ] = TransformLink(L2bX, L2bY, L2bZ, H);
 
 %% Transform side 2 links 
 
 H = T1*T2*T3*T4*T4b3*T5;
 [L1S2X L1S2Y L1S2Z] = TransformLink(L1X, L1Y, L1Z, H);
 
 H = T1*T2b*T3*T4*T4b3*T5;
 [L1S2bX L1S2bY L1S2bZ] = TransformLink(L1bX, L1bY, L1bZ, H);
 
 H = T1*T2*T3*T4*T4b2*T5*T6;
 [L2S2X L2S2Y L2S2Z] = TransformLink(L2X, L2Y, L2Z, H);
 
 H = T1*T2*T3*T4*T4b2*T5b*T6;
 [L2S2bX L2S2bY L2S2bZ] = TransformLink(L2bX, L2bY, L2bZ, H);
 
L1X = [L1S1X, L1S1bX, L1S2X, L1S2bX]; 
L1Y = [L1S1Y, L1S1bY, L1S2Y, L1S2bY];
L1Z = [L1S1Z, L1S1bZ, L1S2Z, L1S2bZ];

L2X = [L2S1X, L2S1bX, L2S2X, L2S2bX]; 
L2Y = [L2S1Y, L2S1bY, L2S2Y, L2S2bY];
L2Z = [L2S1Z, L2S1bZ, L2S2Z, L2S2bZ];
end

