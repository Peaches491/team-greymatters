function [R] = getRotation(axis, angle)
if axis == 'X'
    R = [   1  0           0; 
            0  cos(angle) -sin(angle);
            0  sin(angle)  cos(angle);
        ];
elseif axis == 'Y'
    R = [ cos(angle)  0  sin(angle); 
          0           1  0;
         -sin(angle)  0  cos(angle);
        ];
elseif axis == 'Z'
    R = [   cos(angle) -sin(angle)  0; 
            sin(angle)  cos(angle)  0;
            0           0           1;
        ];
end

