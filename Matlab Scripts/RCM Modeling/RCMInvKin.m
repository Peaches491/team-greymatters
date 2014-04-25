function [theta1, theta2, Tx, Ty, Tz] = RCMInvKin(L1, L2, L3, p1, p2)
p2p1 = p1-p2;

Tx = p2(1)- p2p1(1)*(L1-L3); 
Ty = p2(2)- p2p1(2)*(L1-L3) - L2; 
Tz = p2(3)- p2p1(3)*(L1-L3); 

[Tx Ty Tz];

theta2 = atan2((p1(2)-p2(2)),(p1(3)-p2(3)));
theta1 = atan2((p1(1)-p2(1)),(p1(3)-p2(3)));

[theta1 theta2]



