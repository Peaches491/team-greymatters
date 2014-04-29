function plotSolution( x, L3, entry, ws, bore, sphere_vec)
clf();
plotSetup((bore/2)*1.2);
view(-70, 20);

Xb = 0;
Yb = -0.12;
Zb = -0.15;

L1 = x(1);
L2 = x(2);
r1 = x(3);
r2 = x(4);
[L1m, L1bm, L2m, L2bm] = makeRCM(L1, L2, r1, r2);

% tees = zeros(size(ws, 1), 3);
% for x = 1:size(ws, 1)
for x = 1:1
    g = ws(x, :);
    [theta1, theta2, Tx, Ty, Tz] = RCMInvKin(L1, L2, L3, entry, g, Xb, Yb, Zb);
    [L1X, L1Y, L1Z, L2X, L2Y, L2Z] = configRCM(L1, L2, L3, Tz, Ty, Tx, theta1, theta2, L1m, L1bm, L2m, L2bm, Xb, Yb, Zb);
    plotModel(L1X, L1Y, L1Z, L2X, L2Y, L2Z);
%     tees(x, :) = [Tx, Ty, Tz] - [Xb, Yb, Zb];
    PlotRCM(Tx, Ty, Tz, theta1, theta2 ,L1,L2,L3, Xb, Yb, Zb);
    [Xr, Yr, Zr] = pointsFromPatches(double([L1X, L2X]), double([L1Y, L2Y]), double([L1Z, L2Z]));
    scatter3(Xr, Yr, Zr, 30, checkPoints(sphere_vec, [Xr; Yr; Zr]', bore/2, [0, 0, 0.03]), 'filled');
end

scatter3(entry(1), entry(2), entry(3), 80, 'b', 'filled');
% scatter3(ws(1, 1), ws(1, 2), ws(1, 3), 95, 'r', 'filled');
scatter3(ws(:, 1), ws(:, 2), ws(:, 3), 30, 'r', 'filled');




TB = eye(4);
TB(1, 4) = Xb;
TB(2, 4) = Yb;
TB(3, 4) = Zb;
plotCoordTrans(TB, '', 0.06);

TS = eye(4);
TS(1:3, 1:3) = compose_rotation(0, pi/4, 0);

light('Position',[1 3 2]); 
light('Position',[-3 -1 3]); 
material shiny; 

show_model_trans_stl('Models/newMeshes/brain_low.stl', TS, [1 0.75 0.65], 0.4, 'none');
show_model_trans_stl('Models/newMeshes/skin_tilt_low.stl', TS, 'white', 0.4, 'none');
% show_model_trans_stl('Models/newMeshes/skull.stl', TS, 'white', 0.4, 'none');

[Z, Y, X] = cylinder(bore/2);
Z = Z + 0.03;
X = (X - 0.5).*0.6;
surf(X, Y, Z, 'FaceColor', 'b', 'FaceAlpha', 0.1, 'SpecularStrength', 0);
end

