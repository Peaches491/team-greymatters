
clf();
clc; clear all;


sphere_vec = dlmread('Models/brain.spheres');

sizeval = 0.14;
plotSetup(sizeval);
axis([-sizeval, sizeval, -sizeval, sizeval, -sizeval*0.2, sizeval]);
view(0, 8);
light('Position',[1 3 2]); light('Position',[-3 -1 3]); material shiny;

% for x = 1:size(a, 1)
for x = 1:1
%    Untitled(a(x, :));
end




TS = eye(4);
TS(3, 4) = 0.0;

show_model_trans('Models/brain_low.bod', TS, [1 0.75 0.65], 0.4, 'none');


point = (rand(500, 3).*1.2 + -0.5).*0.2;
% point = a(:, 1:3)


in_color = zeros(1, size(point, 1));

X = point(:, 1);
Y = point(:, 2);
Z = point(:, 3);




[p,q] = meshgrid(1:size(point,1), 1:size(sphere_vec,1));
% keyboard
this = sqrt(sum((point(p(:),:) - sphere_vec( q(:),1:3)).^2, 2)) < ...
    repmat(sphere_vec(:,4),size(point,1),1);
% this is the number of point/sphere intersections

% Prototype for above
% % xdist
% [p,q] = meshgrid(X, a(:,1));
% xdist = (p(:)-q(:)).^2;
% 
% % ydist
% [p,q] = meshgrid(Y, a(:,2));
% ydist = (p(:)-q(:)).^2;
% 
% % zdist
% [p,q] = meshgrid(Z, a(:,3));
% zdist = (p(:)-q(:)).^2;
% 
% that = sum(sqrt(xdist+ydist+zdist)< repmat(a(:,4),length(X),1));
% keyboard

bar = sum(reshape(this, size(sphere_vec,1), size(point,1)))' > 0;
scatter3(X, Y, Z, 100, bar, 'filled')

