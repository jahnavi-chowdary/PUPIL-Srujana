function varargout = Main_Screen(varargin)
% MAIN_SCREEN MATLAB code for Main_Screen.fig
%      MAIN_SCREEN, by itself, creates a new MAIN_SCREEN or raises the existing
%      singleton*.
%
%      H = MAIN_SCREEN returns the handle to a new MAIN_SCREEN or the handle to
%      the existing singleton*.
%
%      MAIN_SCREEN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_SCREEN.M with the given input arguments.
%
%      MAIN_SCREEN('Property','Value',...) creates a new MAIN_SCREEN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_Screen_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_Screen_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main_Screen

% Last Modified by GUIDE v2.5 18-Jul-2016 13:31:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Main_Screen_OpeningFcn, ...
    'gui_OutputFcn',  @Main_Screen_OutputFcn, ...
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


% --- Executes just before Main_Screen is made visible.
function Main_Screen_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main_Screen (see VARARGIN)

% Choose default command line output for Main_Screen
handles.output = hObject;

%% BackGround Image of the GUI START
% This creates the 'background' axes
ha = axes('units','normalized', ...
    'position',[0 0 1 1]);

% Move the background axes to the bottom
uistack(ha,'bottom');

% Load in a background image and display it using the correct colors
% The image used below, is in the Image Processing Toolbox.  If you do not have access to this toolbox, you can use another image file instead.
I=imread('pupil_back_screen1.jpg');
hi = imagesc(I);
colormap gray;

% Turn the handlevisibility off so that we don't inadvertently plot into the axes again
% Also, make the axes invisible
set(ha,'handlevisibility','off', ...
    'visible','off')
%% BackGround Image of the GUI END

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main_Screen wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_Screen_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in new_patient.
function new_patient_Callback(hObject, eventdata, handles)
% hObject    handle to new_patient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Entering Patient's Details

% Clicking on New Patient, 'Patients_Details' is called which is the GUI to enter the patient's details.

Patient_Details


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% CLicking on Exit closes the GUI

close;


% --- Executes on button press in review_records.
function review_records_Callback(hObject, eventdata, handles)
% hObject    handle to review_records (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Clicking on Review Records, 'Review_Patient_Records' is called which allows the user to view the videos, report and the data of the particular
% patient after conducting the test.

Review_Patient_Records
