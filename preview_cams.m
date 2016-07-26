clear all;
close all;
clc;

% Show the preview of the cameras in a custom GUI
% Also save the timestamps of both.
% Also save the live video stream at the end

global record;
global stop;
global arduino;
global v_left;      % The videoWriter objects, which change each time the patient info is changed
global v_right;
global h1;
global h2;
global attempt;
global hImage1;
global hImage2;

record = 2;     % A neutral value that it only takes at the start
stop = 2;

%% Establish connection to the arduino
ports = instrhwinfo('serial');
ports_list = ports.AvailableSerialPorts;

for i = 1:size(ports_list, 1)
    if ~strcmp(ports_list(i), 'COM1')
        arduino_port = ports_list(i)    % TODO: establish comm to prove it is the arduino
        break
    else
        arduino_port = ports_list(i+1)
    end
end

if ~(exist('arduino_port'))
    msgbox('Arduino not plugged in! Exiting...');
    return
end

arduino = serial(arduino_port{1});  % establish comm.
set(arduino,'BaudRate',9600);
fopen(arduino);

%% Establish Connection to the Cameras
% NOTE : Make sure all the other camera devices (apart from the 2 USB
% Cameras of the device) are DISABLED to avoid any interference.

if (~exist('w1'))
    w1 = webcam1;
    start(w1);
end

if (~exist('w2'))
    w2 = webcam2;
    start(w2);
end

vidRes = w1.VideoResolution;    % assume w1 and w2 same which we know
nBands = w1.NumberOfBands;

hImage1 = zeros(vidRes(2), vidRes(1), nBands);
hImage2 = hImage1;

%% Creating the required Folders in case they do not exist

if ~exist('./Area_Size_Time_Cut_CSV','dir')
    mkdir('./Area_Size_Time_Cut_CSV');
end
if ~exist('./Area_Size_Time_Cut_CSV/1','dir')
    mkdir('./Area_Size_Time_Cut_CSV/1');
end
if ~exist('./Area_Size_Time_Cut_CSV/2','dir')
    mkdir('./Area_Size_Time_Cut_CSV/2');
end
if ~exist('./Area_Size_Time_Cut_CSV/3','dir')
    mkdir('./Area_Size_Time_Cut_CSV/3');
end
if ~exist('./Area_SOL_Time_CSV','dir')
    mkdir('./Area_SOL_Time_CSV');
end
if ~exist('./Final_XY_Vectors','dir')
    mkdir('./Final_XY_Vectors');
end
if ~exist('./Concatenated_Videos','dir')
    mkdir('./Concatenated_Videos');
end
if ~exist('./Plots','dir')
    mkdir('./Plots');
end
if ~exist('./Reports','dir')
    mkdir('./Reports');
end
if ~exist('./Thetas_R2_CSV','dir')
    mkdir('./Thetas_R2_CSV');
end
if ~exist('./Videos','dir')
    mkdir('./Videos');
end

%% Get Inputs From the Examiner
h = Main_Screen;