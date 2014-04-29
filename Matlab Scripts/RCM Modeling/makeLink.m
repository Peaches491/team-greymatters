function [X, Y, Z] = makeLink(L,H,N, addend)

% global depth
% global width
% global endLength 


global endLength;
endLength = .0254; %the length of the end of a link determines spacing for parallel links 
global width;
width = .006; % the width of all links (should get from CADD Model)
global depth;
depth = .006; % the z depth for all links (material thickness)
global spacing;
spacing = .02; % the space between the two sets of four-bars  
bore = 0.6;

if(H < .00000001)
    H = .00000001;
end
% r = (H^2 + (L/2)^2)/(2*H);

a = [0, -depth/2];
b = [-L, -depth/2];
c = [-L/2, -depth/2+H];

[C, R] = calcCircle(a,b,c);

rout = R + width/2;
rin  = R - width/2;

theta = asin(L/(2*R));
delta = (2*theta)/N; 
angles = real((pi/2)-theta) : real(delta) : real((pi/2)+theta);
% if ~(isscalar((pi/2)-theta) && isscalar(delta) && isscalar((pi/2)+theta))
%     (pi/2)-theta
%     delta
%     (pi/2)+theta
% end

 X = zeros(4,4*N+6);
 Y = zeros(4,4*N+6);
 Z = zeros(4,4*N+6);

for i = 1 : N
    
    X(:,4*i-3:4*i) = [C(1) + rout*cos(angles(i)),     C(1) + rout*cos(angles(i)),  C(1) + rout*cos(angles(i)),   C(1) + rin*cos(angles(i));
         C(1) + rout*cos(angles(i+1)),   C(1) + rout*cos(angles(i+1)),  C(1) + rout*cos(angles(i+1)), C(1) + rin*cos(angles(i+1));
         C(1) + rin*cos(angles(i+1)),    C(1) + rin*cos(angles(i+1)),   C(1) + rout*cos(angles(i+1)), C(1) + rin*cos(angles(i+1));
         C(1) + rin*cos(angles(i)),      C(1) + rin*cos(angles(i)),   C(1) + rout*cos(angles(i)),   C(1) + rin*cos(angles(i))
              ];

    Y(:,4*i-3:4*i) = [C(2) + rout*sin(angles(i)),     C(2) + rout*sin(angles(i)),  C(2) + rout*sin(angles(i)),   C(2) + rin*sin(angles(i));
         C(2) + rout*sin(angles(i+1)),   C(2) + rout*sin(angles(i+1)),  C(2) + rout*sin(angles(i+1)), C(2) + rin*sin(angles(i+1));
         C(2) + rin*sin(angles(i+1)),    C(2) + rin*sin(angles(i+1)),   C(2) + rout*sin(angles(i+1)), C(2) + rin*sin(angles(i+1));
         C(2) + rin*sin(angles(i)),      C(2) + rin*sin(angles(i)),   C(2) + rout*sin(angles(i)),   C(2) + rin*sin(angles(i));
         ];
         
    Z(:,4*i-3:4*i) =      [depth,0 0,    0;
                           depth,0,0,    0;
                           depth,0,depth,depth;
                           depth,0,depth,depth];
                       
end;

if(addend == 1)
    X(:,5*N+1:5*N+5) = [C(1) + rin*cos(angles(1)),    C(1) + rin*cos(angles(1)),    C(1) + rin*cos(angles(1))+endLength, C(1) + rin*cos(angles(1))+endLength, C(1) + rin*cos(angles(1))+endLength;
              C(1) + rin*cos(angles(1)),              C(1) + rin*cos(angles(1)),    C(1) + rin*cos(angles(1))+endLength, C(1) + rin*cos(angles(1))+endLength, C(1) + rin*cos(angles(1))+endLength;
              C(1) + rin*cos(angles(1))+endLength,            C(1) + rin*cos(angles(1))+endLength,  C(1) + rin*cos(angles(1))+endLength, C(1) + rin*cos(angles(1)),   C(1) + rin*cos(angles(1));
              C(1) + rin*cos(angles(1))+endLength,            C(1) + rin*cos(angles(1))+endLength,  C(1) + rin*cos(angles(1))+endLength, C(1) + rin*cos(angles(1)),   C(1) + rin*cos(angles(1));
              ];
          
    Y(:,5*N+1:5*N+5) = [C(2) + rin*sin(angles(1)),  C(2) + rin*sin(angles(1)),          C(2) + rin*sin(angles(1)),       C(2) + rin*sin(angles(1)), C(2) + rin*sin(angles(1)) + width;
                C(2) + rin*sin(angles(1)) + width,    C(2) + rin*sin(angles(1)) + width,    C(2) + rin*sin(angles(1)),       C(2) + rin*sin(angles(1)), C(2) + rin*sin(angles(1)) + width;
                C(2) + rin*sin(angles(1)) + width,    C(2) + rin*sin(angles(1)) + width,    C(2) + rin*sin(angles(1)) + width, C(2) + rin*sin(angles(1)), C(2) + rin*sin(angles(1)) + width;
                C(2) + rin*sin(angles(1)),          C(2) + rin*sin(angles(1)),          C(2) + rin*sin(angles(1)) + width, C(2) + rin*sin(angles(1)), C(2) + rin*sin(angles(1)) + width
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
%For Debug                    
% clf;
% fill3(X, Y, Z, 'y');
% axis([-5, 1, -5, 5, 0, 2]);
% axis equal

end