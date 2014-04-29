function [num_coll, ik_vec] = iterIK(L1, L2, L3max, entry, goal, Xb, Yb, Zb, L1m, L1bm, L2m, L2bm, sphere_vec, bore)
    
    resolution = .01;
    
    Tmax = [.1, .1, .12];
    Tmin = [0, -.1, 0];

    dist = sqrt(sum((entry-goal).^2));
    slope = (entry-goal)/dist;

    p = ((dist:resolution:L3max)'*slope)';
    px = p(1,:);
    py = p(2,:);
    pz = p(3,:);
    [theta1, theta2, Tx, Ty, Tz] = RCMInvKin(L1, L2, 0, entry, goal, Xb, Yb, Zb);
    [L1X, L1Y, L1Z, L2X, L2Y, L2Z] = configRCM(L1, L2, 0, Tz, Ty, Tx, ...
        theta1, theta2, L1m, L1bm, L2m, L2bm, Xb, Yb, Zb);
    [Xr, Yr, Zr] = pointsFromPatches(double([L1X, L2X]), ...
        double([L1Y, L2Y]), double([L1Z, L2Z]));

    % set(0, 'currentfigure', f);
    % scatter3(p(1, :), p(2, :), p(3, :), 20, 'filled')



%     ik_vec(1:size(px, 2)) = rcmPose(theta1, theta2, Tx, Ty, Tz, 1, );
%     function [x] = eval(px, py, pz, i)
%         Xp = Xr+px;
%         Yp = Yr+py;
%         Zp = Zr+pz;
%         x = max(checkPoints(sphere_vec, [Xp; Yp; Zp]', bore/2, [0, 0, 0.03]));
%         ik_vec(i).Tx = ik_vec(i).Tx+px;
%         ik_vec(i).Ty = ik_vec(i).Ty+px;
%         ik_vec(i).Tz = ik_vec(i).Tz+px;

        %scatter3(Xp, Yp, Zp, 40, checkPoints(sphere_vec, [Xp; Yp; Zp]', bore/2, [0, 0, 0.03]), 'filled');
        % set(0, 'currentfigure', f); 
        % scatter3(Xp, Yp, Zp, 20, 'filled');
%     end

%     test = @(px, py, pz, i) eval(px , py, pz, i);
    
%     x = arrayfun(test, px, py, pz, 1:size(px, 2));
    
    x = zeros(1, size(px, 2));
    for i = 1:size(px, 2)
        Xp = Xr+px(i);
        Yp = Yr+py(i);
        Zp = Zr+pz(i);
        
        del = p(:, i);
        pt = [Tx, Ty, Tz] + del';
        
        if ~(any(Tmin < pt) || any(pt < Tmax))
%         if(Tz+pz(i) > Tzmax || Ty+py(i) > Tymax || Tx+px(i) > Txmax ||...
%                 Tz+pz(i) < Tzmin || Ty+py(i) < Tymin || Tx+px(i) < Txmin)
            disp('Bleh');
            x(i) = 1;
        else
            x(i) = max(checkPoints(sphere_vec, [Xp; Yp; Zp]', bore/2, [0, 0, 0.03]));
        end
%         if (~(exist('ik_vec','var'))) && x(i) == 0
%             r = sqrt(sum(p(:, i).^2));
%             ik_vec = [theta1, theta2, Tx+px(i), Ty+py(i), Tz+pz(i), r];
%         end
    end
    
    ik_vec = 0;
%     x
    num_coll = sum(abs(x-1))/size(px, 2);

end



