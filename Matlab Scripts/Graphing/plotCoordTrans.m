function plotCoordTrans (T, label)
scale = 0.02;

R = T(1:3, 1:3);
p = T(4, 1:3);

unit_x = R*[1;0;0];
unit_y = R*[0;1;0];
unit_z = R*[0;0;1];

plot3(p(1) + scale*[0, unit_x(1), 0], ...
      p(2) + scale*[0, unit_x(2), 0], ...
      p(3) + scale*[0, unit_x(3), 0], 'red', 'linewidth', 3);

plot3(p(1) + scale*[0, unit_y(1), 0], ...
      p(2) + scale*[0, unit_y(2), 0], ...
      p(3) + scale*[0, unit_y(3), 0], 'green', 'linewidth', 3);
  
plot3(p(1) + scale*[0, unit_z(1), 0], ...
      p(2) + scale*[0, unit_z(2), 0], ...
      p(3) + scale*[0, unit_z(3), 0], 'blue', 'linewidth', 3);

delta = -0.010;
text(p(1)+delta, p(2)+delta, p(3)+delta, label);
end