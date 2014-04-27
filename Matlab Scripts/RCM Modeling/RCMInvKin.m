function [theta1, theta2, Tx, Ty, Tz] = RCMInvKin(L1, L2, L3, entry, workspace)
p2p1 = entry-workspace;

dist = sqrt((entry(1)-workspace(1))^2 + (entry(2)-workspace(2))^2 + (entry(3)-workspace(3))^2);

r = (L1-L3)/dist;

Tx = workspace(1)- p2p1(1)*r; 
Ty = workspace(2)- p2p1(2)*r - L2; 
Tz = workspace(3)- p2p1(3)*r; 

theta2 = atan2((entry(2)-workspace(2)),(entry(3)-workspace(3)));
theta1 = atan2((entry(1)-workspace(1)),(entry(3)-workspace(3)));


