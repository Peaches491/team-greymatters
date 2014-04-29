function [ fitness ] = evaluateConfig( cfg, ws, entry, sphere_vec, bore, p)
%EVALUATECONFIG Summary of this function goes here
%   Detailed explanation goes here

    Xb = cfg.offset(1);
    Yb = cfg.offset(2);
    Zb = cfg.offset(3);
    L1 = cfg.L1;
    L2 = cfg.L2;
    L3 = cfg.L3;
    r1 = cfg.r1;
    r2 = cfg.r2;
    
    
    [L1m, L1bm, L2m, L2bm] = makeRCM(L1, L2, r1, r2);
    
    collision_ratios = zeros(1, size(ws, 1));
    Tcollision_ratios = zeros(1, size(ws, 1));
    ikvals = zeros(1, size(ws, 1));
    
%     ik_soltns = rcmPose.empty();
    for x = 1:size(ws, 1)
        g = ws(x, :);
%         [theta1, theta2, Tx, Ty, Tz] = RCMInvKin(L1, L2, L3, entry, g, Xb, Yb, Zb);
%         [L1X, L1Y, L1Z, L2X, L2Y, L2Z] = configRCM(L1, L2, L3, Tz, Ty, Tx, theta1, theta2, L1m, L1bm, L2m, L2bm, Xb, Yb, Zb);
%         plotModel(L1X, L1Y, L1Z, L2X, L2Y, L2Z);
%         PlotRCM(Tx, Ty, Tz, theta1, theta2 ,L1,L2,L3, Xb, Yb, Zb);
        [collision_ratios(x),Tcollision_ratios(x), ikvals(x)] = iterIK(L1, L2, L3, entry, g, Xb, Yb, Zb, L1m, L1bm, L2m, L2bm, sphere_vec, bore);
%         ik_soltns(x) = rcmPose(ik(1), ik(2), ik(3), ik(4), ik(5), ik(6), cfg);
    end
    
    p= [.35  .15 .35 .15];
    
    PercentCollisions = (sum(collision_ratios ~= 0)/size(ws, 1) );
    meanCollisions = mean(collision_ratios);
    PercentTablCol = (sum(Tcollision_ratios ~= 0)/size(ws, 1) );
    NeedleDist = -1*(abs(mean((L3/2) - ikvals)))/(L3/2);
    

    fitness = p(1)*PercentCollisions + p(2)*meanCollisions +p(3)*PercentTablCol+...
        p(4)*NeedleDist;
    
%     fitness = (p)*((sum(collision_ratios ~= 0)/size(ws, 1) )) ...
%         + (1-p)*(mean(collision_ratios));
    
%     if (sum(collision_ratios ~= 0)/size(ws, 1) ) >= 1
%         fitness = fitness + norm([L1, L2]);
%     end
end

