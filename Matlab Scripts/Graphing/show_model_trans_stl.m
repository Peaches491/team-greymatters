function [h] = show_model_trans_stl( path, T, faceColor, alpha, edgeColor)
%SHOW_MODEL_TRANS Summary of this function goes here
%   Detailed explanation goes here

    s = stlread(path);
    
    paren = @(x, varargin) x(varargin{:});
    trans = @(x, R, p) paren( (x*R)+p, (1:3) );

    for x = 1:size(s.vertices, 1)
        s.vertices(x, :) = trans(s.vertices(x, :), T(1:3, 1:3)', T(1:3, 4)');
    end

    h = show_model(s,  'FaceColor', faceColor, ...
        'EdgeColor', edgeColor, 'SpecularStrength', 0.6, ...
        'FaceAlpha', alpha, 'EdgeAlpha', alpha);
end

