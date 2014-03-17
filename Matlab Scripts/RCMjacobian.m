%% RCM Jacobian Calculations 

syms X Y Z theta1 theta2 theta3 r R1 R2;

 T1 = DHTransform(Z,0,0,-sym(pi)/2);
 T2 = DHTransform(Y,sym(pi/2),0,sym(pi)/2);
 T3 = DHTransform(X,sym(pi),0,sym(pi)/2);
 T4 = DHTransform(0,theta1,0,sym(pi)/2);
 T5 = DHTransform(0,theta2,R1,0);
 T6 = DHTransform(0,(sym(pi)/2)-theta2,R2,0);
 T7 = DHTransform(0,sym(pi)/2+theta2,r,-sym(pi)/2);
 
 H = T1*T2*T3*T4*T5*T6*T7;
 
 x = simple(H(1,4));
 
 J11 = diff(x, X);
 J12 = diff(x, Y);
 J13 = diff(x, Z);
 J14 = diff(x, theta1);
 J15 = diff(x, theta2);
 J16 = diff(x, r);
 J17 = diff(x, theta3);
 
 y = simple(H(2,4));
 
 J21 = diff(y, X);
 J22 = diff(y, Y);
 J23 = diff(y, Z);
 J24 = diff(y, theta1);
 J25 = diff(y, theta2);
 J26 = diff(y, r);
 J27 = diff(y, theta3);
 
 z = simple(H(3,4));
 
 J31 = diff(z, X);
 J32 = diff(z, Y);
 J33 = diff(z, Z);
 J34 = diff(z, theta1);
 J35 = diff(z, theta2);
 J36 = diff(z, r);
 J37 = diff(z, theta3);
 
%  R = simple(H(1:3,1:3));
 
%  Roll = atan2(R(3,1),R(3,2))
%  Pitch = acos(R(3,3))
%  Yaw = -atan2(R(1,3),R(2,3))

% Matlab 2011 cant hangle Atan2 for symbolics the parital derivatives of
% the above line should be the last 3 rows of the jocobian but I cannot
% calculate them symbolically to take the derivatices. Matlab 2014 could...
% is there another way to get orientation information??


% from inspecting the RCM I believe Roll = Theta2, Pitch = Theta1 
% and Yaw = 0 (actually Theta 3 the rotation of the needle that we have ignored so far)
% can ethier of you confirm that intuition? 

roll = theta2;

 J41 = diff(roll, X);
 J42 = diff(roll, Y);
 J43 = diff(roll, Z);
 J44 = diff(roll, theta1);
 J45 = diff(roll, theta2);
 J46 = diff(roll, r);
 J47 = diff(roll, theta3);
 
pitch = theta2;

 J51 = diff(pitch, X);
 J52 = diff(pitch, Y);
 J53 = diff(pitch, Z);
 J54 = diff(pitch, theta1);
 J55 = diff(pitch, theta2);
 J56 = diff(pitch, r);
 J57 = diff(pitch, theta3);
 
yaw = theta3;

 J61 = diff(yaw, X);
 J62 = diff(yaw, Y);
 J63 = diff(yaw, Z);
 J64 = diff(yaw, theta1);
 J65 = diff(yaw, theta2);
 J66 = diff(yaw, r);
 J67 = diff(yaw, theta3);
 
 Jacob = [J11 J12 J13 J14 J15 J16 J17;
          J21 J22 J23 J24 J25 J26 J27;
          J31 J32 J33 J34 J35 J36 J37;
          J41 J42 J43 J44 J45 J46 J47;
          J51 J52 J53 J54 J55 J56 J57;
          J61 J62 J63 J64 J65 J66 J67];

 
 


 
 
 
 
 
  
 