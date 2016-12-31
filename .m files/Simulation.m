function varargout = Simulation(varargin)
% SIMULATION MATLAB code for Simulation.fig
%      SIMULATION, by itself, creates a new SIMULATION or raises the existing
%      singleton*.
%
%      H = SIMULATION returns the handle to a new SIMULATION or the handle to
%      the existing singleton*.
%
%      SIMULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMULATION.M with the given input arguments.
%
%      SIMULATION('Property','Value',...) creates a new SIMULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Simulation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Simulation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Simulation

% Last Modified by GUIDE v2.5 14-Dec-2016 18:27:33

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Simulation_OpeningFcn, ...
                   'gui_OutputFcn',  @Simulation_OutputFcn, ...
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


% --- Executes just before Simulation is made visible.
function Simulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Simulation (see VARARGIN)

% Choose default command line output for Simulation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Simulation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Simulation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function survRate_Callback(hObject, eventdata, handles)
% hObject    handle to survRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of survRate as text
%        str2double(get(hObject,'String')) returns contents of survRate as a double
x = str2double(get(hObject, 'String'));
geneticOptions.survivalRate = x; 

% --- Executes during object creation, after setting all properties.
function survRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to survRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numGens_Callback(hObject, eventdata, handles)
% hObject    handle to numGens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numGens as text
%        str2double(get(hObject,'String')) returns contents of numGens as a double
x = str2double(get(hObject, 'String'));
geneticOptions.numOfGenerations = x;

% --- Executes during object creation, after setting all properties.
function numGens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numGens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function popSize_Callback(hObject, eventdata, handles)
% hObject    handle to popSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popSize as text
%        str2double(get(hObject,'String')) returns contents of popSize as a double
x = str2double(get(hObject, 'String'));
geneticOptions.populationSize = x;

% --- Executes during object creation, after setting all properties.
function popSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function g_Callback(hObject, eventdata, handles)
% hObject    handle to g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g as text
%        str2double(get(hObject,'String')) returns contents of g as a double
x = str2double(get(hObject, 'String'));
environment.g_mpsps = x;

% --- Executes during object creation, after setting all properties.
function g_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numCycles_Callback(hObject, eventdata, handles)
% hObject    handle to numCycles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numCycles as text
%        str2double(get(hObject,'String')) returns contents of numCycles as a double
x = str2double(get(hObject, 'String'));
animateOptions.cyclesPerAnimation = x;


% --- Executes during object creation, after setting all properties.
function numCycles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numCycles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coeffOfRest_Callback(hObject, eventdata, handles)
% hObject    handle to coeffOfRest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coeffOfRest as text
%        str2double(get(hObject,'String')) returns contents of coeffOfRest as a double
x = str2double(get(hObject, 'String'));
environment.coeffRes = x;


% --- Executes during object creation, after setting all properties.
function coeffOfRest_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coeffOfRest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenu.
function popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu
contents = cellstr(get(hObject,'String'));
x = contents{get(hObject,'Value')};

% --- Executes during object creation, after setting all properties.
function popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in startSim.
function startSim_Callback(hObject, eventdata, handles)
% hObject    handle to startSim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.popupmenu,'String'));
x = contents{get(handles.popupmenu,'Value')};
if strcmp(x, 'Slug') == 1
    load('slug.mat')
    environment.coeffFric = 1.9;
elseif strcmp(x, 'Arch') == 1
    load('arch.mat')
    environment.coeffFric = .8;
elseif strcmp(x, 'Snail') == 1
    load('snail.mat')
    environment.coeffFric = .85;
    animateOptions.windowSize_px = [0,50,0,10];
elseif strcmp(x, 'Truss') == 1
    load('truss.mat')
    environment.coeffFric = 1.3;
end

geneticOptions.populationSize = str2double(get(handles.popSize, 'String'));
geneticOptions.survivalRate = str2double(get(handles.survRate, 'String'));
geneticOptions.numOfGenerations = str2double(get(handles.numGens, 'String'));
geneticOptions.mutationChance = .1;
geneticOptions.matingChance = .9;
geneticOptions.matingVsMutationChance = .7;
geneticOptions.numSurvive = floor(geneticOptions.survivalRate*geneticOptions.populationSize);

environment.pos_m = [0,0,100,1000];
environment.g_mpsps = str2double(get(handles.g, 'String'));
% environment.coeffFric = str2double(get(handles.CoeffOfF, 'String'));
environment.coeffRes = str2double(get(handles.coeffOfRest, 'String'));
environment.maxSpeed_mps = 100;
environment.minSpeed_mps = .001;
environment.endTime_s = 5;
environment.dt_s = .01;
environment.time_s = 0;
environment.activationForce_N = 60;
environment.minActivationTime_s = 1;
environment.maxForce_N = 1000;
environment.numTimeSteps = floor(environment.endTime_s/environment.dt_s);

animateOptions.cyclesPerAnimation = str2double(get(handles.numCycles, 'String'));
animateOptions.jointSize_px = 80;
animateOptions.jointColor = 'k';
animateOptions.limbWidth_px = 5;
animateOptions.limbRestColor = 'k';
animateOptions.limbActivatedColor = 'r';
animateOptions.frameRate_s = .005;
animateOptions.windowSize_px = [0,50,0,15];
animateOptions.background = 'mario.png';

CalculationTime = geneticAlgorithm(environment,joints,limbs,geneticOptions)
load('firstOne.mat');
load('winner.mat');
physicsAnimation2(environment,joints,limbs,winner,firstOne,animateOptions);
