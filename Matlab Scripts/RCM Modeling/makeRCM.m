function [L1m, L1bm, L2m, L2bm] = makeRCM(L1, L2, r1, r2)
div = 10;

%% Link 1
[L1X, L1Y, L1Z] = makeLink(L1,r1,div,1);
[L1bX, L1bY, L1bZ] = makeLink(L1,r1,div,0);

%% Link 2;    
[L2X, L2Y, L2Z] = makeLink(L2,r2,div, 1);
[L2bX, L2bY, L2bZ] = makeLink(L2,r2,div, 0);

 R = getRotation('Y', pi);
 p = [ -L2; 0; 0];
 H = [ R, p; 0 0 0 1];
[L2X, L2Y, L2Z] = TransformLink(L2X, L2Y, L2Z, H);
[L2bX, L2bY, L2bZ] = TransformLink(L2bX, L2bY, L2bZ, H);
 

L1m = [L1X; L1Y; L1Z]; 
L1bm =[L1bX; L1bY; L1bZ];

L2m = [L2X; L2Y; L2Z]; 
L2bm =[L2bX; L2bY; L2bZ];

end


