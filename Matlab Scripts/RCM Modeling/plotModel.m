function [] = plotModel(L1X, L1Y, L1Z, L2X, L2Y, L2Z)
patch(L1X, L1Y, L1Z, 'b');
hold on;
patch(L2X, L2Y, L2Z, 'y');

end

