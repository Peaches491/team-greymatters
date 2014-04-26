function plotSetup (size)
    axis equal
    grid on
    hold on
    axis([-size, size, -size, size, -size/2, size])
    view(40, 15)
    camproj('perspective')
end 