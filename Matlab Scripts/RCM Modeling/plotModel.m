function [] = plotModel(L1X, L1Y, L1Z, L2X, L2Y, L2Z)
    

    if nargin < 8
        L1_col = 'b';
        if nargin < 7
            L2_col = 'y';
        end
    end

    hold on;
    patch(L1X, L1Y, L1Z, L1_col);
    patch(L2X, L2Y, L2Z, L2_col);

end

