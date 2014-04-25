function [X Y Z] = makeLink(L,H,N, addend)


depth = .25;
endLength = 1;


% r = (H^2 + (L/2)^2)/(2*H);

a = [0, -depth/2];
b = [-L, -depth/2];
c = [-L/2, depth/2+H];

[C R] = calcCircle(a,b,c);

rout = R + .125;
rin  = R - .125;

theta = asin(L/(2*R));
delta = (2*theta)/N; 
angles = [pi/2-theta : delta : pi/2+theta];

 X = zeros(4,5*N+6);
 Y = zeros(4,5*N+6);
 Z = zeros(4,5*N+6);

for i = 1 : N
    
    X(:,5*i-4:5*i) = [C(1) + rout*cos(angles(i)),     C(1) + rout*cos(angles(i)),     C(1) + rout*cos(angles(i)),  C(1) + rout*cos(angles(i)),   C(1) + rin*cos(angles(i));
         C(1) + rout*cos(angles(i+1)),   C(1) + rout*cos(angles(i+1)),   C(1) + rout*cos(angles(i)),  C(1) + rout*cos(angles(i+1)), C(1) + rin*cos(angles(i+1));
         C(1) + rin*cos(angles(i+1)),    C(1) + rin*cos(angles(i+1)),    C(1) + rin*cos(angles(i)),   C(1) + rout*cos(angles(i+1)), C(1) + rin*cos(angles(i+1));
         C(1) + rin*cos(angles(i)),      C(1) + rin*cos(angles(i)),      C(1) + rin*cos(angles(i)),   C(1) + rout*cos(angles(i)),   C(1) + rin*cos(angles(i))
              ];

    Y(:,5*i-4:5*i) = [C(2) + rout*sin(angles(i)),     C(2) + rout*sin(angles(i)),     C(2) + rout*sin(angles(i)),  C(2) + rout*sin(angles(i)),   C(2) + rin*sin(angles(i));
         C(2) + rout*sin(angles(i+1)),   C(2) + rout*sin(angles(i+1)),   C(2) + rout*sin(angles(i)),  C(2) + rout*sin(angles(i+1)), C(2) + rin*sin(angles(i+1));
         C(2) + rin*sin(angles(i+1)),    C(2) + rin*sin(angles(i+1)),    C(2) + rin*sin(angles(i)),   C(2) + rout*sin(angles(i+1)), C(2) + rin*sin(angles(i+1));
         C(2) + rin*sin(angles(i)),      C(2) + rin*sin(angles(i)),      C(2) + rin*sin(angles(i)),   C(2) + rout*sin(angles(i)),   C(2) + rin*sin(angles(i));
         ];
         
    Z(:,5*i-4:5*i) =      [depth,0,0,0,0;
                           depth,0,depth,0,0;
                           depth,0,depth,depth,depth;
                           depth,0,0,depth,depth];
                       
end;

if(addend == 1)
    X(:,5*N+1:5*N+5) = [C(1) + rin*cos(angles(1)),    C(1) + rin*cos(angles(1)),    C(1) + rin*cos(angles(1))+1, C(1) + rin*cos(angles(1))+1, C(1) + rin*cos(angles(1))+1;
              C(1) + rin*cos(angles(1)),              C(1) + rin*cos(angles(1)),    C(1) + rin*cos(angles(1))+1, C(1) + rin*cos(angles(1))+1, C(1) + rin*cos(angles(1))+1;
              C(1) + rin*cos(angles(1))+endLength,            C(1) + rin*cos(angles(1))+endLength,  C(1) + rin*cos(angles(1))+endLength, C(1) + rin*cos(angles(1)),   C(1) + rin*cos(angles(1));
              C(1) + rin*cos(angles(1))+endLength,            C(1) + rin*cos(angles(1))+endLength,  C(1) + rin*cos(angles(1))+endLength, C(1) + rin*cos(angles(1)),   C(1) + rin*cos(angles(1));
              ];
          
    Y(:,5*N+1:5*N+5) = [C(2) + rin*sin(angles(1)),  C(2) + rin*sin(angles(1)),          C(2) + rin*sin(angles(1)),       C(2) + rin*sin(angles(1)), C(2) + rin*sin(angles(1)) + depth;
                C(2) + rin*sin(angles(1)) + depth,    C(2) + rin*sin(angles(1)) + depth,    C(2) + rin*sin(angles(1)),       C(2) + rin*sin(angles(1)), C(2) + rin*sin(angles(1)) + depth;
                C(2) + rin*sin(angles(1)) + depth,    C(2) + rin*sin(angles(1)) + depth,    C(2) + rin*sin(angles(1)) + depth, C(2) + rin*sin(angles(1)), C(2) + rin*sin(angles(1)) + depth;
                C(2) + rin*sin(angles(1)),          C(2) + rin*sin(angles(1)),          C(2) + rin*sin(angles(1)) + depth, C(2) + rin*sin(angles(1)), C(2) + rin*sin(angles(1)) + depth
               ];
           
    Z(:,5*N+1:5*N+5) = [depth,0,0,     0,     0;
                        depth,0,depth, depth, depth;
                        depth,0,depth, depth, depth;
                        depth,0,0,     0,     0];
end

 R = getRotation('X', pi);
 p = [ 0; 0; 0];
 H = [ R, p; 0 0 0 1];
 [X Y Z] = TransformLink(X, Y, Z, H);
%%For Debug                    
% clf;
% fill3(X, Y, Z, 'y');
% axis([-5, 1, -5, 5, 0, 2]);
% axis equal

end