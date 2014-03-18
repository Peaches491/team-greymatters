clf()

size = 10;
plotSetup(size)
axis([-size, size, -size, size, -size, size])
view(270, 30)
light('Position',[1 3 2]); light('Position',[-3 -1 3]); material shiny;

[x,y,z] = sphere();

d_x = 0;
d_y = 0;
d_z = -4;

c = [d_x, d_y, d_z];
r = 8

x = x*r + d_x;
y = y*r + d_y;
z = z*r + d_z;

surf2patch(surf(x, y, z, 'FaceColor', 'y', 'FaceAlpha', 0.4, 'EdgeColor', 'none'));


X = [0, 0, 3];
inside = sum((c-X).^2) <= r^2;

if inside
    scatter3(X(1), X(2), X(3), 'r');
else
    scatter3(X(1), X(2), X(3), 'k');
end

S= load('Models/brain_low.bod', '-mat');
    