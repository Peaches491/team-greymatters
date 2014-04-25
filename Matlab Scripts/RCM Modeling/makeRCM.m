function [L1X L1Y L1Z L2X L2Y L2Z] = makeRCM(L1, L2, L3, r1, r2, Tz, Ty, Tx, theta1, theta2)


%% Link 1
[L1S1X L1S1Y L1S1Z] = makeLink(L1,.5,30,1);
[L1S2X L1S2Y L1S2Z] = makeLink(L1,.5,30,1);

%  R = getRotation('X', pi);
%  p = [ 0; 0; 0];
%  H = [ R, p; 0 0 0 1];
%  [L2bX L2bY L2bZ] = TransformLink(L2bX, L2bY, L2bZ, H);
 
 
 %% Link 1
[L1S1bX L1S1bY L1S1bZ] = makeLink(L1,r1,30,0);
[L1S2bX L1S2bY L1S2bZ] = makeLink(L1,r1,30,0);

%  R = getRotation('X', pi);
%  p = [ 0; 0; 0];
%  H = [ R, p; 0 0 0 1];
%  [L2bX L2bY L2bZ] = TransformLink(L2bX, L2bY, L2bZ, H);
 

%% Link 2;    
[L2S1X L2S1Y L2S1Z] = makeLink(L2,r2,30, 1);
[L2S2X L2S2Y L2S2Z] = makeLink(L2,r2,30, 1);

%  R = getRotation('X', pi);
%  p = [ 0; 0; 0];
%  H = [ R, p; 0 0 0 1];
%  [L2bX L2bY L2bZ] = TransformLink(L2bX, L2bY, L2bZ, H);
 
 R = getRotation('Y', pi);
 p = [ -5; 0; 0];
 H = [ R, p; 0 0 0 1];
 [L2S1X L2S1Y L2S1Z] = TransformLink(L2S1X, L2S1Y, L2S1Z, H);
 [L2S2X L2S2Y L2S2Z] = TransformLink(L2S2X, L2S2Y, L2S2Z, H);
 
%% Link 2b
[L2S1bX L2S1bY L2S1bZ] = makeLink(L2,r2,30, 0);
[L2S2bX L2S2bY L2S2bZ] = makeLink(L2,r2,30, 0);

  R = getRotation('Y', pi);
 p = [ -5; 0; 0];
 H = [ R, p; 0 0 0 1];
 [L2S1bX L2S1bY L2S1bZ] = TransformLink(L2S1bX, L2S1bY, L2S1bZ, H);
 [L2S2bX L2S2bY L2S2bZ] = TransformLink(L2S2bX, L2S2bY, L2S2bZ, H);

 
 %% Transfroms for RCM Position
 T1 = DHTransform(Tz,0,0,-sym(pi)/2);
 T2 = DHTransform(Ty,sym(pi/2),0,sym(pi)/2);
 T2b = DHTransform(Ty-1,sym(pi/2),0,sym(pi)/2);
 T3 = DHTransform(Tx,sym(pi),0,sym(pi)/2);
 T4 = DHTransform(0,theta1,0,sym(pi)/2);
 
 p = [ 0; 0; .75];
 T4b1 = [ [1,0,0;0,1,0;0,0,1], p; 0 0 0 1];
 p = [ 0; 0; -1];
 T4b2 = [ [1,0,0;0,1,0;0,0,1], p; 0 0 0 1]; 
 p = [ 0; 0; -.5];
 T4b3 = [ [1,0,0;0,1,0;0,0,1], p; 0 0 0 1];
 
 
 T5 = DHTransform(0,theta2,L1,0);
 T5b = DHTransform(0,theta2,L1+1,0);
 T6 = DHTransform(0,(sym(pi)/2)-theta2,L2,0);
 T7 = DHTransform(0,sym(pi)/2+theta2,L3,-sym(pi)/2); 

 %% Transform side 1 links 
 H = T1*T2*T3*T4*T4b1*T5;
 [L1S1X L1S1Y L1S1Z] = TransformLink(L1S1X, L1S1Y, L1S1Z, H);
 
 H = T1*T2b*T3*T4*T4b1*T5;
 [L1S1bX L1S1bY L1S1bZ] = TransformLink(L1S1bX, L1S1bY, L1S1bZ, H);
 
 H = T1*T2*T3*T4*T4b1*T5*T6;
 [L2S1X L2S1Y L2S1Z] = TransformLink(L2S1X, L2S1Y, L2S1Z, H);
 
 H = T1*T2*T3*T4*T4b1*T5b*T6;
 [L2S1bX L2S1bY L2S1bZ] = TransformLink(L2S1bX, L2S1bY, L2S1bZ, H);
 
 %% Transform side 2 links 
 
 H = T1*T2*T3*T4*T4b3*T5;
 [L1S2X L1S2Y L1S2Z] = TransformLink(L1S2X, L1S2Y, L1S2Z, H);
 
 H = T1*T2b*T3*T4*T4b3*T5;
 [L1S2bX L1S2bY L1S2bZ] = TransformLink(L1S2bX, L1S2bY, L1S2bZ, H);
 
 H = T1*T2*T3*T4*T4b2*T5*T6;
 [L2S2X L2S2Y L2S2Z] = TransformLink(L2S2X, L2S2Y, L2S2Z, H);
 
 H = T1*T2*T3*T4*T4b2*T5b*T6;
 [L2S2bX L2S2bY L2S2bZ] = TransformLink(L2S2bX, L2S2bY, L2S2bZ, H);
 
L1X = [L1S1X, L1S1bX, L1S2X, L1S2bX]; 
L1Y = [L1S1Y, L1S1bY, L1S2Y, L1S2bY];
L1Z = [L1S1Z, L1S1bZ, L1S2Z, L1S2bZ];

L2X = [L2S1X, L2S1bX, L2S2X, L2S2bX]; 
L2Y = [L2S1Y, L2S1bY, L2S2Y, L2S2bY];
L2Z = [L2S1Z, L2S1bZ, L2S2Z, L2S2bZ];


