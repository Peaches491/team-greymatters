%% Generate Meshes and Plot

clc; clear all; 
% close all; 
clf();

% Add relevant function paths
addpath('Graphing');
addpath('Models');
plotSetup(0.3)
view(270, 30)

% RCM
RCM
plotCoordTrans(TB, '', 0.06);
plotCoordTrans(TB*T1*T2*T3*T4*T5*T6*T7, '', 0.1);

TS = eye(4);
TS(1:3, 1:3) = compose_rotation(0, -0.6*pi/2, 0);

light('Position',[1 3 2]); light('Position',[-3 -1 3]); material shiny; 
show_model_trans('Models/brain_low.bod', TS, [1 0.75 0.65], 0.6, 'none');
show_model_trans('Models/skull_low.bod', TS, 'white', 0.4, 'none');
show_model_trans('Models/jaw_low.bod', TS, 'white', 0.4, 'none');
show_model_trans('Models/teeth_low.bod', TS, 'white', 0.4, 'none');
show_model_trans('Models/tongue_low.bod', TS, 'white', 0.4, 'none');
show_model_trans('Models/outer_low.bod', TS, 'white', 0.25, 'none');