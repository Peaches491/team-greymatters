function plotCoord (pos, R, label)
scale = 0.8;

unit_x = R*[1;0;0];
unit_y = R*[0;1;0];
unit_z = R*[0;0;1];

plot3(pos(1) + scale*[0, unit_x(1), 0], ...
      pos(2) + scale*[0, unit_x(2), 0], ...
      pos(3) + scale*[0, unit_x(3), 0], 'red', 'linewidth', 3, 'LineSmoothing','on');

plot3(pos(1) + scale*[0, unit_y(1), 0], ...
      pos(2) + scale*[0, unit_y(2), 0], ...
      pos(3) + scale*[0, unit_y(3), 0], 'green', 'linewidth', 3, 'LineSmoothing','on');
  
plot3(pos(1) + scale*[0, unit_z(1), 0], ...
      pos(2) + scale*[0, unit_z(2), 0], ...
      pos(3) + scale*[0, unit_z(3), 0], 'blue', 'linewidth', 3, 'LineSmoothing','on');

delta = -0.010;
text(pos(1)+delta, pos(2)+delta, pos(3)+delta, label);
end