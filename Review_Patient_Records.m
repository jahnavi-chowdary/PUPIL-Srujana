function varargout = Review_Patient_Records(varargin)
% REVIEW_PATIENT_RECORDS MATLAB code for Review_Patient_Records.fig
%      REVIEW_PATIENT_RECORDS, by itself, creates a new REVIEW_PATIENT_RECORDS or raises the existing
%      singleton*.
%
%      H = REVIEW_PATIENT_RECORDS returns the handle to a new REVIEW_PATIENT_RECORDS or the handle to
%      the existing singleton*.
%
%      REVIEW_PATIENT_RECORDS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REVIEW_PATIENT_RECORDS.M with the given input arguments.
%
%      REVIEW_PATIENT_RECORDS('Property','Value',...) creates a new REVIEW_PATIENT_RECORDS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Review_Patient_Records_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Review_Patient_Records_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Review_Patient_Records

% Last Modified by GUIDE v2.5 21-Jul-2016 14:47:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Review_Patient_Records_OpeningFcn, ...
                   'gui_OutputFcn',  @Review_Patient_Records_OutputFcn, ...
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


% --- Executes just before Review_Patient_Records is made visible.
function Review_Patient_Records_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Review_Patient_Records (see VARARGIN)

% Choose default command line output for Review_Patient_Records
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

% UIWAIT makes Review_Patient_Records wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Review_Patient_Records_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in view_videos.
function view_videos_Callback(hObject, eventdata, handles)
% hObject    handle to view_videos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% NOTE : In the "..." Give the path to the VLC.exe file specific to your computer

system('"D:\VLC\VLC.exe" new_concatenated_video.avi')


% --- Executes on button press in view_report.
function view_report_Callback(hObject, eventdata, handles)
% hObject    handle to view_report (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mr_no = evalin('base','mr_no');
attempt = evalin('base','attempt');
    
try
    fname_report = strcat(mr_no,'_',num2str(attempt),'_Report','.pdf');
    winopen(fullfile('./Reports',fname_report)); % Open document in in-built PDF viewer
catch
    fname_report = strcat(mr_no,'_',num2str(attempt),'_Report','.docx');
    winopen(fullfile('./Reports',fname_report)); % If unable to open in PDF format then Open document in in-built Docx viewer
end


% --- Executes on button press in view_excel.
function view_excel_Callback(hObject, eventdata, handles)
% hObject    handle to view_excel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

winopen('ReportData.xls')


% --- Executes on button press in done.
function done_Callback(hObject, eventdata, handles)
% hObject    handle to done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close;
