function [T] = plotarmmodel(Q, faceColor, alpha, edgeColor )
    
    generateTransforms;

    light('Position', [-0.5,  0.5,  0.3]);
    light('Position', [   0, -0.7, -0.1]);
    camlight('right');    

    show_model_trans('Models/STL/base.stl', TB, faceColor, alpha, edgeColor);
    show_model_trans('Models/STL/axis1.stl', subs(T01, Q_sym, Q), faceColor, alpha, edgeColor);
    show_model_trans('Models/STL/axis2.stl', subs(T01*T12, Q_sym, Q), faceColor, alpha, edgeColor);
    show_model_trans('Models/STL/axis3.stl', subs(T01*T12*T23, Q_sym, Q), faceColor, alpha, edgeColor);
    show_model_trans('Models/STL/axis4.stl', subs(T01*T12*T23*T34, Q_sym, Q), faceColor, alpha, edgeColor);
    show_model_trans('Models/STL/axis5.stl', subs(T01*T12*T23*T34*T45, Q_sym, Q), faceColor, alpha, edgeColor);
%    show_model_trans('Models/STL/axis6.stl', subs(T01*T12*T23*T34*T45*T56, Q_sym, Q), faceColor, alpha, edgeColor);
    
    T = subs(T01*T12*T23*T34*T45*T56, Q_sym, Q);
    
end

