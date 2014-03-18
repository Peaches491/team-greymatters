function plotCoordTrans (T, label, scale)
    R = T(1:3, 1:3);
    p = T(1:3, 4);
    plotCoord(p, R, label, scale);
end