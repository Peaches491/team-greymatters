X =  0.04; 
Y =  0.06; 
Z =  0.06;

theta1 = 2*pi/6;
theta2 = pi/4;
r  = .05;

R1 = 0.18;
R2 = 0.12;

TB = eye(4);
TB(1:3, 4) = [0 -0.2 0];

T1 = DHTransform(Z,0,0,-sym(pi)/2);
T2 = DHTransform(Y,sym(pi/2),0,sym(pi)/2);
T3 = DHTransform(X,sym(pi),0,sym(pi)/2);
T4 = DHTransform(0,theta1,0,sym(pi)/2);
T5 = DHTransform(0,theta2,R1,0);
T6 = DHTransform(0,(sym(pi)/2)-theta2,R2,0);
T7 = DHTransform(0,sym(pi)/2+theta2,r,-sym(pi)/2);  
 
% T01 = DHToMatrix_vec(dh_params(1, :))
% T12 = DHToMatrix_vec(dh_params(2, :))
% T23 = DHToMatrix_vec(dh_params(3, :))
% T34 = DHToMatrix_vec(dh_params(4, :))
% T45 = DHToMatrix_vec(dh_params(5, :))
% T56 = DHToMatrix_vec(dh_params(6, :))

% Q_sym  = [    q1,     q2,     q3,     q4,     q5,     q6];
% T06_6 = subs(T06, Q_sym, Q)

hold on
p0 = TB*[0,0,0,1]';
p1 = TB*T1*[0,0,0,1]';
plot3([p0(1),p1(1)], [p0(2),p1(2)], [p0(3),p1(3)],'blue');
scatter3(p1(1),p1(2),p1(3),'fill','blue');

p1 = TB*T1*[0,0,0,1]';
p2 = TB*T1*T2*[0,0,0,1]';
plot3([p1(1),p2(1)], [p1(2),p2(2)], [p1(3),p2(3)],'green');
scatter3(p2(1),p2(2),p2(3),'fill','green');

p3 = TB*T1*T2*T3*[0,0,0,1]';
plot3([p2(1),p3(1)], [p2(2),p3(2)], [p2(3),p3(3)],'red');
scatter3(p3(1),p3(2),p3(3),'fill','red');

p4 = TB*T1*T2*T3*T4*[0,0,0,1]';
plot3([p3(1),p4(1)], [p3(2),p4(2)], [p3(3),p4(3)],'black');
scatter3(p4(1),p4(2),p4(3),'fill','black');

p5 = TB*T1*T2*T3*T4*T5*[0,0,0,1]';
plot3([p4(1),p5(1)], [p4(2),p5(2)], [p4(3),p5(3)],'black');
scatter3(p5(1),p5(2),p5(3),'fill','black');

p6 = TB*T1*T2*T3*T4*T5*T6*[0,0,0,1]';
plot3([p5(1),p6(1)], [p5(2),p6(2)], [p5(3),p6(3)],'black');
scatter3(p6(1),p6(2),p6(3),'fill','black');

p7 = TB*T1*T2*T3*T4*T5*T6*T7*[0,0,0,1]';
plot3([p6(1),p7(1)], [p6(2),p7(2)], [p6(3),p7(3)],'black');
scatter3(p7(1),p7(2),p7(3),'fill','black');



