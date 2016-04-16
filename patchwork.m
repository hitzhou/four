function varargout = patchwork(varargin)
% PATCHWORK MATLAB code for patchwork.fig
%      PATCHWORK, by itself, creates a new PATCHWORK or raises the existing
%      singleton*.
%
%      H = PATCHWORK returns the handle to a new PATCHWORK or the handle to
%      the existing singleton*.
%
%      PATCHWORK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PATCHWORK.M with the given input arguments.
%
%      PATCHWORK('Property','Value',...) creates a new PATCHWORK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before patchwork_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to patchwork_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help patchwork

% Last Modified by GUIDE v2.5 16-Apr-2016 19:39:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @patchwork_OpeningFcn, ...
                   'gui_OutputFcn',  @patchwork_OutputFcn, ...
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


% --- Executes just before patchwork is made visible.
function patchwork_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to patchwork (see VARARGIN)

% Choose default command line output for patchwork
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes patchwork wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = patchwork_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pim;
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'选择图像');
if isequal(filename,0)||isequal(pathname,0)
  errordlg('您还没有选取图片！！','温馨提示');%如果没有输入，则创建错误对话框 
  return;
else
    image=[pathname,filename];%合成路径+文件名
    pim=imread(image);%读取图像
    set(handles.axes1,'HandleVisibility','ON');%打开坐标，方便操作
    axes(handles.axes1);%%使用图像，操作在坐标1
    imshow(pim);%在坐标axes1显示原图像 
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pwater;
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'选择图像');
if isequal(filename,0)||isequal(pathname,0)
  errordlg('您还没有选取图片！！','温馨提示');%如果没有输入，则创建错误对话框 
  return;
else
    image=[pathname,filename];%合成路径+文件名
    pwater=imread(image);%读取图像
    set(handles.axes3,'HandleVisibility','ON');%打开坐标，方便操作
    axes(handles.axes3);%%使用图像，操作在坐标3
    imshow(pwater);%在坐标axes3显示原图像 
end




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 水印嵌入部分
global pim;
global pwater;
global cover;
global m;
global n;
global message;
global mm;
global mn;
global f;
global delta;
global ax;
global ay;
global bx;
global by;
global r;
global s;
global watermarked_image;

clc;
tic;			%运算时间初始值
cover = double(pim)./256;%归一化
[m,n] = size(cover);
% 读入水印，并取二值化
message = pwater;
[mm,mn] = size(message);
%为伪随机数发生器的种子
rand('state',256);	%嵌入的密钥
f = cover;		%时域方法
delta = 0.2;	%*256;%归一化后就不用*256了
ax = randperm(m);
ay = randperm(n);
bx = randperm(mm);
by = randperm(mn);
for r = 1:mm
    for s = 1:mn
        if message(r,s) == 1
           f(ax(r),ay(s)) = f(ax(r),ay(s))+delta;
           f(bx(r),by(s)) = f(bx(r),by(s))-delta;
        else              
           f(ax(r),ay(s)) = f(ax(r),ay(s))-delta;
           f(bx(r),by(s)) = f(bx(r),by(s))+delta;
        end
    end
end

% embed watermark
% determine size of cover object 
Mc=size(cover,1);	%Height 
Nc=size(cover,2);	%Width
watermarked_image=double(cover); 
for i=1:(Mc/2) 
    for j=1:(Nc/2) 
        if mod(i+j,2)==0 
            watermarked_image(i,j)=watermarked_image(i,j)+3; 
        else 
            watermarked_image(i,j)=watermarked_image(i,j)-3; 
        end 
    end 
end
set(handles.axes2,'HandleVisibility','ON');%打开坐标，方便操作
axes(handles.axes2);%%使用图像，操作在坐标2
imshow(uint8(watermarked_image),[]);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m;
global n;
global mm;
global mn;
global f;
global ax;
global ay;
global bx;
global by;
global r;
global s;
global watermark;

%水印提取部分
rand('state',256);	%提取的密钥
ax = randperm(m);
ay = randperm(n);
bx = randperm(mm);
by = randperm(mn);
for r = 1:mm
    for s = 1:mn
        if f(ax(r),ay(s))-f(bx(r),by(s)) > 0
            watermark(r,s) = 1;
        else 
            watermark(r,s) = 0;
        end 
    end
end
set(handles.axes4,'HandleVisibility','ON');%打开坐标，方便操作
axes(handles.axes4);%%使用图像，操作在坐标2
imshow(watermark*256,[]);
