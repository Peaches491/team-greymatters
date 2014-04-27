function [x, p] = iterIK(L1, L2, entry, goal, Xb, Yb, Zb, L1m, L1bm, L2m, L2bm, sphere_vec, bore, f)
resolution = .01;
L3max = L1;

dist = sqrt(sum((entry-goal).^2));
slope = (entry-goal)/dist;




p = ((0:resolution:L3max)'*slope)'
px = p(1,:);
py = p(2,:);
pz = p(3,:);
[theta1, theta2, Tx, Ty, Tz] = RCMInvKin(L1, L2, 0, entry, goal, Xb, Yb, Zb);
[L1X, L1Y, L1Z, L2X, L2Y, L2Z] = configRCM(L1, L2, 0, Tz, Ty, Tx, ...
    theta1, theta2, L1m, L1bm, L2m, L2bm, Xb, Yb, Zb);
[Xr, Yr, Zr] = pointsFromPatches(double([L1X, L2X]), ...
    double([L1Y, L2Y]), double([L1Z, L2Z]));


set(0, 'currentfigure', f);
scatter3(p(1, :), p(2, :), p(3, :), 20, 'filled')


test = @(px, py, pz) eval(px , py, pz, Xr, Yr, Zr,sphere_vec, bore, f);

x = arrayfun(test,px, py, pz);


end

function [x] = eval(px, py, pz, Xr, Yr, Zr, sphere_vec, bore, f)

Xp = Xr+px;
Yp = Yr+py;
Zp = Zr+pz;


x = max(checkPoints(sphere_vec, [Xp; Yp; Zp]', bore/2, [0, 0, 0.03]));
%scatter3(Xp, Yp, Zp, 40, checkPoints(sphere_vec, [Xp; Yp; Zp]', bore/2, [0, 0, 0.03]), 'filled');

% set(0, 'currentfigure', f); 
% scatter3(Xp, Yp, Zp, 20, 'filled');

end

