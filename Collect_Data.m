function varargout = Collect_Data(varargin)
% COLLECT_DATA MATLAB code for Collect_Data.fig
%      COLLECT_DATA, by itself, creates a new COLLECT_DATA or raises the existing
%      singleton*.
%
%      H = COLLECT_DATA returns the handle to a new COLLECT_DATA or the handle to
%      the existing singleton*.
%
%      COLLECT_DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COLLECT_DATA.M with the given input arguments.
%
%      COLLECT_DATA('Property','Value',...) creates a new COLLECT_DATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Collect_Data_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Collect_Data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Collect_Data

% Last Modified by GUIDE v2.5 25-Jul-2016 12:01:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Collect_Data_OpeningFcn, ...
                   'gui_OutputFcn',  @Collect_Data_OutputFcn, ...
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


% --- Executes just before Collect_Data is made visible.
function Collect_Data_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Collect_Data (see VARARGIN)

% Choose default command line output for Collect_Data
handles.output = hObject;

%% BackGround Image of the GUI START

% This creates the 'background' axes
ha = axes('units','normalized', ...
            'position',[0 0 1 1]);

% Move the background axes to the bottom
uistack(ha,'bottom');

% Load in a background image and display it using the correct colors
% The image used below, is in the Image Processing Toolbox.  If you do not have %access to this toolbox, you can use another image file instead.
I=imread('pupil_back_screen3.jpg');
hi = imagesc(I);
colormap gray

% Turn the handlevisibility off so that we don't inadvertently plot into the axes again
% Also, make the axes invisible
set(ha,'handlevisibility','off', ...
            'visible','off')
%% BackGround Image of the GUI END

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Collect_Data wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Collect_Data_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in begin_test.
function begin_test_Callback(hObject, eventdata, handles)
% hObject    handle to begin_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Start the Test by clicking on Begin Test which starts the automated swinging light pattern that is embedded into the device.

begin_test(1,1,'1')


% --- Executes on button press in finish_test.
function finish_test_Callback(hObject, eventdata, handles)
% hObject    handle to finish_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% The test happens in 6 steps - OS1 , OD1 , OS2 , OD2 , OS3 , OD3 after which the test is completed by clicking on the Finish button at the bottom right.
% This stops the test and plots the graph of the current test.

finish_test(1,1,'1')

% --- Executes on button press in save_test.
function save_test_Callback(hObject, eventdata, handles)
% hObject    handle to save_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Analyzing the plot that is generated after finishing the test, if the plot is Satisfactory then clicking on Save Test saves all the data corresponding
% to the current patient.

save_test();
close;
msgbox('All The Data has been successfully saved!!!');



% --- Executes on button press in cancel_test.
function cancel_test_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Analyzing the plot that is generated after finishing the test, if the plot is NOT Satisfactory then clicking on Canel Test cancels the current test
% WITHOUT saving any data corresponding to the current patient.

cancel_test();
close;
msgbox('Current Test has been Discarded!!!');


% --- Executes on button press in os1.
function os1_Callback(hObject, eventdata, handles)
% hObject    handle to os1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in od1.
function od1_Callback(hObject, eventdata, handles)
% hObject    handle to od1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in os2.
function os2_Callback(hObject, eventdata, handles)
% hObject    handle to os2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in od2.
function od2_Callback(hObject, eventdata, handles)
% hObject    handle to od2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in os3.
function os3_Callback(hObject, eventdata, handles)
% hObject    handle to os3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in od3.
function od3_Callback(hObject, eventdata, handles)
% hObject    handle to od3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function OS_Preview_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OS_Preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate OS_Preview

w1 = evalin('base','w1');
hImage1 = evalin('base','hImage1');
v_left = evalin('base','v_left');

% display('Entered OS Axes');

ax1 = subplot(1,2,1);
set(ax1,'position',[0.1 0.25 0.3 0.4]);

% Create figure and use it to display previews of both cameras
h1 = subimage(hImage1);

preview(w1, h1); 

setappdata(h1, 'UpdatePreviewWindowFcn', @(obj, evt, h1)process_videos_func_left(obj, evt, h1, v_left));



% --- Executes during object creation, after setting all properties.
function OD_Preview_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OD_Preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate OD_Preview

w2 = evalin('base','w2');
hImage2 = evalin('base','hImage2');
v_right = evalin('base','v_right');

% display('Entered OD Axes')

ax2 = subplot(1,2,2);
set(ax2,'position',[0.5 0.25 0.3 0.4]);

% Create figure and use it to display previews of both cameras
h2 = subimage(hImage2);     % h1 and h2 are the handles to the subimages 

preview(w2, h2); 

setappdata(h2, 'UpdatePreviewWindowFcn', @(obj, evt, h2)process_videos_func_right(obj, evt, h2, v_right));
