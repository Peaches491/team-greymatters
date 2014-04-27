function [theta1, theta2, Tx, Ty, Tz] = RCMInvKin(L1, L2, L3, p1, p2)
p2p1 = p1-p2;

dist = sqrt((p1(1)-p2(1))^2 + (p1(2)-p2(2))^2 + (p1(3)-p2(3))^2);

r = (L1-L3)/dist;

Tx = p2(1)- p2p1(1)*r; 
Ty = p2(2)- p2p1(2)*r - L2; 
Tz = p2(3)- p2p1(3)*r; 

theta2 = atan2((p1(2)-p2(2)),(p1(3)-p2(3)));
theta1 = atan2((p1(1)-p2(1)),(p1(3)-p2(3)));





