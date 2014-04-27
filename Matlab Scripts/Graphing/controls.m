function varargout = controls(varargin)
% Last Modified by GUIDE v2.5 27-Apr-2014 02:12:37
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @controls_OpeningFcn, ...
                   'gui_OutputFcn',  @controls_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% End initialization code - DO NOT EDIT



% --- Executes just before controls is made visible.
function controls_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for controls
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global L1;
global L2;
global L3;
global entry az el;
az = 0;
el = 0;
global goal;
global theta1 theta2 Tx Ty Tz TS;
global h;
global delta;
delta = 0.1;
global sphere_vec;

TS = eye(4);
% TS(1:3, 1:3) = compose_rotation(0, -0.6*pi/2, 0);
TS(1:3, 1:3) = compose_rotation(0, pi/4, 0);

spheres = dlmread('Models/head.spheres');
sphere_vec = tfSpheres(spheres, TS);

L1 = .12;
L2 = .2;
L3 = .15;    
[x, y, z] = entryFromPolar(0, 0, sphere_vec); %entry location 
entry = [x, y, z];
goal = [0.00, 0.00, 0.00]; %workspace location

% This sets up the initial plot - only do when we are invisible
% so window can get raised using controls.
if strcmp(get(hObject,'Visible'),'off')
    h = figure();
    plotSetup(0.3);
    % view(-90, 90);
    camproj('perspective');
    redraw(0, 0, handles);
end

% --- Outputs from this function are returned to the command line.
function varargout = controls_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


function redraw(hObject, eventdata, handles)
global h;
set(0, 'currentfigure', h);
[az_view, el_view] = view;
cla();
hold on;
axis equal;
axis([-0.3, 0.3, -0.3, 0.3, -0.15, 0.3])
view(az_view, el_view);

global L1;
global L2;
global L3;
global entry;
global goal;
global theta1 theta2 Tx Ty Tz TS;

[theta1, theta2, Tx, Ty, Tz] = RCMInvKin(L1, L2, L3, entry, goal);

PlotRCM(Tx, Ty, Tz, theta1, theta2 ,L1,L2,L3);
scatter3(entry(1), entry(2), entry(3), 120, 'b', 'filled');
scatter3(goal(1), goal(2), goal(3), 100, 'r', 'filled');

light('Position',[1 3 2]); 
light('Position',[-3 -1 3]); 
material shiny; 
show_model_trans_stl('Models/newMeshes/brain_low.stl', TS, [1 0.75 0.65], 0.4, 'none');
show_model_trans_stl('Models/newMeshes/skin_tilt_low.stl', TS, 'white', 0.4, 'none');


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});











% --- Executes on slider movement.
function azslider_Callback(hObject, eventdata, handles)
global az el entry sphere_vec;
az = get(hObject,'Value');
[x, y, z] = entryFromPolar(az, el, sphere_vec);
entry = [x, y, z];
redraw(0, 0, handles);

% --- Executes during object creation, after setting all properties.
function azslider_CreateFcn(hObject, eventdata, handles)
global goal delta;
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
%     set(hObject, 'Min', goal(1) - delta);
%     set(hObject, 'Max', goal(1) + delta);
    set(hObject, 'Value', goal(1));
end


% --- Executes on slider movement.
function elslider_Callback(hObject, eventdata, handles)
global az el entry sphere_vec;
el = get(hObject,'Value');
[x, y, z] = entryFromPolar(az, el,sphere_vec);
entry = [x, y, z];
redraw(0, 0, handles);

% --- Executes during object creation, after setting all properties.
function elslider_CreateFcn(hObject, eventdata, handles)
global goal delta;
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
%     set(hObject, 'Min', goal(2) - delta);
%     set(hObject, 'Max', goal(2) + delta);
    set(hObject, 'Value', goal(2));
end









% --- Executes on slider movement.
function sliderX_Callback(hObject, eventdata, handles)
global goal;
val = get(hObject,'Value')
goal(1) = val;
redraw(0, 0, handles);

% --- Executes during object creation, after setting all properties.
function sliderX_CreateFcn(hObject, eventdata, handles)
global goal delta;
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
%     set(hObject, 'Min', goal(1) - delta);
%     set(hObject, 'Max', goal(1) + delta);
    set(hObject, 'Value', goal(1));
end


% --- Executes on slider movement.
function sliderY_Callback(hObject, eventdata, handles)
global goal;
val = get(hObject,'Value')
goal(2) = val;
redraw(0, 0, handles);

% --- Executes during object creation, after setting all properties.
function sliderY_CreateFcn(hObject, eventdata, handles)
global goal delta;
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
%     set(hObject, 'Min', goal(2) - delta);
%     set(hObject, 'Max', goal(2) + delta);
    set(hObject, 'Value', goal(2));
end


% --- Executes on slider movement.
function sliderZ_Callback(hObject, eventdata, handles)
global goal;
val = get(hObject,'Value')
goal(3) = val;
redraw(0, 0, handles);

% --- Executes during object creation, after setting all properties.
function sliderZ_CreateFcn(hObject, eventdata, handles)
global goal delta;
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
%     set(hObject, 'Min', goal(3) - delta);
%     set(hObject, 'Max', goal(3) + delta);
    set(hObject, 'Value', goal(3));
end
