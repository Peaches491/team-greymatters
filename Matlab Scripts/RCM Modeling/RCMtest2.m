clc; close all; clear all; 

L1 = 5;
L2 = 5;
r1 = .5;
r2 = .5;
L3 = 5;

p1 = [5,5,5]; %entry location 
p2 = [0,5,0]; %workspace location 


[theta1, theta2, Tx, Ty, Tz] = RCMInvKin(L1, L2, L3, p1, p2);



[L1X L1Y L1Z L2X L2Y L2Z] = makeRCM(L1, L2, L3, r1, r2, Tz, Ty, Tx, theta1, theta2);

clf;
view(3);
PlotRCM(Tx,Ty,Tz,theta1,theta2,L3,L1,L2);
hold on;
plotModel(L1X, L1Y, L1Z, L2X, L2Y, L2Z);


axis([-10, 10, -10, 10, -10, 10]);
axis equal