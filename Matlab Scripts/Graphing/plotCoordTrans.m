function plotCoordTrans (T, label)
    scale = 0.005;

    R = T(1:3, 1:3);
    p = T(1:3, 4);

    plotCoord(p, R, label);
end