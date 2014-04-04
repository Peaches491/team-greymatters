a = dlmread('Models/brain.spheres');

clf();
clc ;

sizeval = 0.15;
plotSetup(sizeval);
axis([-sizeval, sizeval, -sizeval, sizeval, -sizeval, sizeval]);
view(270, 30);
light('Position',[1 3 2]); light('Position',[-3 -1 3]); material shiny;

for x = 1:size(a, 1)
    Untitled(a(x, :));
end

TS = eye(4);
TS(3, 4) = -0.1;

%show_model_trans('Models/brain_low.bod', TS, [1 0.75 0.65],1.0, 'none');
