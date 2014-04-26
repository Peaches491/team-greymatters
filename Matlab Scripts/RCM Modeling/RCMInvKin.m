function [theta1, theta2, Tx, Ty, Tz] = RCMInvKin(L1, L2, L3, entry, workspace)
p2p1 = entry-workspace;

Tx = workspace(1)- p2p1(1)*(L1-L3); 
Ty = workspace(2)- p2p1(2)*(L1-L3) - L2; 
Tz = workspace(3)- p2p1(3)*(L1-L3); 

% [Tx Ty Tz];

theta2 = atan2((entry(2)-workspace(2)),(entry(1)-workspace(1)));
theta1 = atan2((entry(1)-workspace(1)),(entry(3)-workspace(3)));




