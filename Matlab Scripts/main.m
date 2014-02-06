clc; clear all; close all; 

%% Add relevant function paths
addpath('Graphing');
plotSetup(10)

%% Define all symbolic constants
syms x y z l1 l2 theta1 theta2 theta3 ;

%% Build basic transformation matricies
t01 = [cos(theta1) -sin(theta1)  0   0;
       sin(theta1)  cos(theta1)  0   0;
            0            0       1  l1;
            0            0       0   1];

t12 = [1     0    0   0;
       0     1    0  l2;
       0     0    1   0;
       0     0    0   1];

t02 = t01*t12;

a = subs(t02, [l1 l2 theta1], [5, 0, 0.0]);
b = subs(t02, [l1 l2 theta1], [5, 0, .25]);
c = subs(t02, [l1 l2 theta1], [5, 0, .50]);

plotCoordTrans(a, '');
plotCoordTrans(b, '');
plotCoordTrans(c, '');