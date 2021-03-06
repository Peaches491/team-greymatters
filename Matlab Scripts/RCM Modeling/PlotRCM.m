function [] = PlotRCM(X, Y, Z, theta1, theta2, L1, L2, r, X0,Y0,Z0)

    if nargin < 9 
        X0 = 0;
        Y0 = 0;
        Z0 = 0;
    end

    R1 = L1;
    R2 = L2;
    
    T1 = DHTransform(Z,0,0,-pi/2);
    T2 = DHTransform(Y,sym(pi/2),0,pi/2);
    T3 = DHTransform(X,sym(pi),0,pi/2);
    T4 = DHTransform(0,theta1,0,pi/2);
    T5 = DHTransform(0,theta2,R1,0);
    T6 = DHTransform(0,(pi/2)-theta2,R2,0);
    T7 = DHTransform(0,pi/2+theta2,r,-pi/2);  

    
    plot3([X0,X0], [Y0,Y0], [Z0,Z],'blue');
    scatter3(X0,Y0,Z,'fill','blue');
    
    p2 = T1*T2*[0,0,0,1]';
    plot3([X0,p2(1)], [Y0,p2(2)], [Z,p2(3)],'green');
    scatter3(p2(1),p2(2),p2(3),'fill','green');
   
    p3 = T1*T2*T3*[0,0,0,1]';
    plot3([p2(1),p3(1)], [p2(2),p3(2)], [p2(3),p3(3)],'red');
    scatter3(p3(1),p3(2),p3(3),'fill','red');
    
    p4 = T1*T2*T3*T4*[0,0,0,1]';
%     plot3([p3(1),p4(1)], [p3(2),p4(2)], [p3(3),p4(3)],'black');
%     scatter3(p4(1),p4(2),p4(3),'fill','black');
    
    p5 = T1*T2*T3*T4*T5*[0,0,0,1]';
    plot3([p4(1),p5(1)], [p4(2),p5(2)], [p4(3),p5(3)],'black');
    scatter3(p5(1),p5(2),p5(3),'fill','black');
    
    p6 = T1*T2*T3*T4*T5*T6*[0,0,0,1]';
    plot3([p5(1),p6(1)], [p5(2),p6(2)], [p5(3),p6(3)],'black');
    scatter3(p6(1),p6(2),p6(3),'fill','black');
    
    p7 = T1*T2*T3*T4*T5*T6*T7*[0,0,0,1]';
    plot3([p6(1),p7(1)], [p6(2),p7(2)], [p6(3),p7(3)],'black');
    scatter3(p7(1),p7(2),p7(3),'fill','black');
    
end
    


