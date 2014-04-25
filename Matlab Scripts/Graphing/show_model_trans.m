function [X, Y, Z] =  show_model_trans( path, T, faceColor, alpha, edgeColor)
%SHOW_MODEL_TRANS Summary of this function goes here
%   Detailed explanation goes here

    S = load(path, '-mat');
    P = S.P; t = S.t;
    
    P = bsxfun(@plus, (P * T(1:3, 1:3)), T(1:3, 4)');
    
    X = reshape(P(t(:, 1:3)', 1)', [3, size(t, 1)]);
    Y = reshape(P(t(:, 1:3)', 2)', [3, size(t, 1)]);
    Z = reshape(P(t(:, 1:3)', 3)', [3, size(t, 1)]);
    
    patch(X, Y, Z, faceColor, 'EdgeColor', edgeColor, 'FaceAlpha', alpha);
    
    X = X';
    Y = Y';
    Z = Z';
end

