function varargout = frameDisplayer2(varargin)
% FRAMEDISPLAYER2 MATLAB code for frameDisplayer2.fig
%      FRAMEDISPLAYER2, by itself, creates a new FRAMEDISPLAYER2 or raises the existing
%      singleton*.
%
%      H = FRAMEDISPLAYER2 returns the handle to a new FRAMEDISPLAYER2 or the handle to
%      the existing singleton*.
%
%      FRAMEDISPLAYER2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FRAMEDISPLAYER2.M with the given input arguments.
%
%      FRAMEDISPLAYER2('Property','Value',...) creates a new FRAMEDISPLAYER2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before frameDisplayer2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to frameDisplayer2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help frameDisplayer2

% Last Modified by GUIDE v2.5 18-Aug-2021 17:41:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @frameDisplayer2_OpeningFcn, ...
                   'gui_OutputFcn',  @frameDisplayer2_OutputFcn, ...
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


% --- Executes just before frameDisplayer2 is made visible.
function frameDisplayer2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to frameDisplayer2 (see VARARGIN)

% Choose default command line output for frameDisplayer2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes frameDisplayer2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = frameDisplayer2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in select.
function select_Callback(hObject, eventdata, handles)
% hObject    handle to select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path = uigetdir();
if isequal(path,0)
   disp('User selected Cancel');
else
    
    d = dir(fullfile(path));
    handles.dir = d;
    handles.idx = 3;
    
    w_path = fullfile(handles.dir(handles.idx).folder, handles.dir(handles.idx).name);
    d_path = split(w_path, '\');
    d_path{end - 1} = "depth_img";
    d_file = split(handles.dir(handles.idx).name, '_');
    d_file = strjoin(d_file(1:end - 2), '_');
    d_path{end} = strcat(d_file, ".jpg");
    d_path = fullfile(d_path{:});
    handles.d_path = d_path;
    axes(handles.w_frame);
    imshow(imread(w_path));
    axes(handles.d_frame);
    imshow(imread(d_path));
    set(handles.file_name, "string", handles.dir(handles.idx).name);
    guidata(hObject,handles)
end


% --- Executes on button press in point.
function point_Callback(hObject, eventdata, handles)
% hObject    handle to point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.p1, "string","");
set(handles.p2, "string","");
d_frame = rgb2gray(imread(handles.d_path));
axes(handles.d_frame);
button = 1;
count = 0;
while sum(button) <=1 % read ginputs until a mouse right-button occurs
    [x,y,button] = ginput(1);
    if (x > 1280 || x < 1) || (y > 720 || y < 1)
        break;
    end
    if count == 0
        set(handles.p1, "string", int2str(d_frame(floor(y),floor(x))));
    end
    if count == 1
        set(handles.p2, "string", int2str(d_frame(floor(y),floor(x))));
    end
    count = count + 1;
    
    if count == 2
        count = 0;
    end
end

% --- Executes on button press in mark.
function mark_Callback(hObject, eventdata, handles)
% hObject    handle to mark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.p1, "string","");
set(handles.p2, "string","");
w_frame = rgb2gray(imread(fullfile(handles.dir(handles.idx).folder, handles.dir(handles.idx).name)));
axes(handles.d_frame);
button = 1;
while sum(button) <=1 % read ginputs until a mouse right-button occurs
    [x,y,button] = ginput(1);
    if (x > 1280 || x < 1) || (y > 720 || y < 1)
        break;
    end
    w_frame(floor(y)-5:floor(y)+5,floor(x)-5:floor(x)+5, 1) = 255;
    w_frame(floor(y)-5:floor(y)+5,floor(x)-5:floor(x)+5, 2) = 0;
    w_frame(floor(y)-5:floor(y)+5,floor(x)-5:floor(x)+5, 3) = 0;
    axes(handles.w_frame);
    imshow(w_frame);
end

% --- Executes on button press in left.
function left_Callback(hObject, eventdata, handles)
% hObject    handle to left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.idx > 3
    handles.idx =  handles.idx - 1;
    w_path = fullfile(handles.dir(handles.idx).folder, handles.dir(handles.idx).name);
    d_path = split(w_path, '\');
    d_path{end - 1} = "depth_img";
    d_file = split(handles.dir(handles.idx).name, '_');
    d_file = strjoin(d_file(1:end - 2), '_');
    d_path{end} = strcat(d_file, ".jpg");
    d_path = fullfile(d_path{:});
    handles.d_path = d_path;
    axes(handles.w_frame);
    imshow(imread(w_path));
    axes(handles.d_frame);
    imshow(imread(d_path));
    set(handles.file_name, "string", handles.dir(handles.idx).name);
    guidata(hObject,handles)
end
% --- Executes on button press in right.
function right_Callback(hObject, eventdata, handles)
% hObject    handle to right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.idx < length(handles.dir)
    handles.idx =  handles.idx + 1;
    w_path = fullfile(handles.dir(handles.idx).folder, handles.dir(handles.idx).name);
    d_path = split(w_path, '\');
    d_path{end - 1} = "depth_img";
    d_file = split(handles.dir(handles.idx).name, '_');
    d_file = strjoin(d_file(1:end - 2), '_');
    d_path{end} = strcat(d_file, ".jpg");
    d_path = fullfile(d_path{:});
    handles.d_path = d_path;
    axes(handles.w_frame);
    imshow(imread(w_path));
    axes(handles.d_frame);
    imshow(imread(d_path));
    set(handles.file_name, "string", handles.dir(handles.idx).name);
    guidata(hObject,handles)
end
