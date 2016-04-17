function varargout = lsb(varargin)
% LSB MATLAB code for lsb.fig
%      LSB, by itself, creates a new LSB or raises the existing
%      singleton*.
%
%      H = LSB returns the handle to a new LSB or the handle to
%      the existing singleton*.
%
%      LSB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LSB.M with the given input arguments.
%
%      LSB('Property','Value',...) creates a new LSB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lsb_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lsb_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lsb

% Last Modified by GUIDE v2.5 17-Apr-2016 12:20:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lsb_OpeningFcn, ...
                   'gui_OutputFcn',  @lsb_OutputFcn, ...
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


% --- Executes just before lsb is made visible.
function lsb_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lsb (see VARARGIN)

% Choose default command line output for lsb
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lsb wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lsb_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
global image;

[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'选择图像');
if isequal(filename,0)||isequal(pathname,0)
  errordlg('您还没有选取图片！！','温馨提示');%如果没有输入，则创建错误对话框 
  return;
else
    image=[pathname,filename];%合成路径+文件名
    im=imread(image);%读取图像
    set(handles.axes1,'HandleVisibility','ON');%打开坐标，方便操作
    axes(handles.axes1);%%使用图像，操作在坐标1
    imshow(im);%在坐标axes1显示原图像 
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global water;
global watermark;
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'选择图像');
if isequal(filename,0)||isequal(pathname,0)
  errordlg('您还没有选取图片！！','温馨提示');%如果没有输入，则创建错误对话框 
  return;
else
    watermark=[pathname,filename];%合成路径+文件名
    water=imread(watermark);%读取图像
    set(handles.axes2,'HandleVisibility','ON');%打开坐标，方便操作
    axes(handles.axes2);%%使用图像，操作在坐标2
    imshow(water);%在坐标axes1显示原图像 
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global watermark;
global output;
global ste_cover;
global len_total;
global key;
global p;
global I1;
global I2;
global J1;
global J2;
global m;
global n;
global a;
global b;
global f_id;

%参数说明:
%input是信息隐藏载体图象
%file是秘密消息文件
%output是信息隐秘后的生成图象
%key是随机间隔的密钥
vector = image;
secret = watermark;
output = 'file:///Users/zssec/Desktop/four/output.bmp';
key = 1992;%密钥
I1 = imread(vector);%读入载体lena灰度bmp图像
ste_cover = double(I1);
I2 = ste_cover;
J1 = imread(secret);%读入嵌入的bmp图像
J2 = dec2bin(J1);%将图像中的灰度值转为二进制的一行n列序列
J2 = double(J2);
[m,n] = size(ste_cover);%获取载体图像的行数和列数
%vector_total=m*n;
[a,b] = size(J2);%获取嵌入图像的行数和列数
f_id = fopen(secret,'r');
[msg,len_total] = fread(f_id,'ubit1');
%判断嵌入图像是否过大
if len_total > m*n
    error('嵌入消息量过大,请更换图象');
end
p = 1; %作为消息嵌入位数计数器
%调用随机函数选取象素点
[row,col] = randinterval(ste_cover,len_total,key);
%嵌入像素
for i = 1:len_total
%以下这段代码也可以实现相同功能
%     if (mod (ste_cover(row(i),col(i)),2)==0)
%        if (J2(i)==1)
%             ste_cover(row(i),col(i))= ste_cover(row(i),col(i))+1;
%         else
%              ste_cover(row(i),col(i))= ste_cover(row(i),col(i));
%         end
%     else 
%        if (J2(i)==0)
%             ste_cover(row(i),col(i))= ste_cover(row(i),col(i))-1;
%         else
%             ste_cover(row(i),col(i))= ste_cover(row(i),col(i));
%         end
      ste_cover(row(i),col(i)) = ste_cover(row(i),col(i))-mod(ste_cover(row(i),col(i)),2)+msg(p,1);
     %end
     if p == len_total
         break;
     end
     p = p+1;   
end
I3 = I2-ste_cover;
ste_cover = uint8(ste_cover);
I3 = uint8(I3);
set(handles.axes3,'HandleVisibility','ON');%打开坐标，方便操作
axes(handles.axes3);%%使用图像，操作在坐标3
imshow(ste_cover);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global output;
global ste_cover;
global len_total;
global key;
global p;
global J1;

%提取像素
[row,col] = randinterval(ste_cover,len_total,key);
% frr = fopen(output,'w');
%  for i = 1:len_total
%      if (bitand(ste_cover(row(i),col(i)),1) == 1)
%          fwrite(frr,1,'ubit1');
%          result(p,1) = 1;
%      else
%          fwrite(frr,0,'ubit1');
%          result(p,1) = 0;
%      end
%      if p == len_total
%          break
%      end
%      p = p+1;
%  end
% fclose(frr);
% result = uint8(result);
set(handles.axes4,'HandleVisibility','ON');%打开坐标，方便操作
axes(handles.axes4);%%使用图像，操作在坐标4
imshow(J1);

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%文件名:randinterval.m 
%函数功能:本函数将利用随机序列进行间隔控制,选择消息隐藏位置 
%输入格式举例:[row,col]=randinterval(test,60,1983) 
%参数说明: 
%matrix为载体矩阵 
%count为要嵌入的信息的数量(要选择的相素数量) 
%key为密钥 
%row为伪随机输出的相素行标 
%col为伪随机输出的相素列标 
function [row,col] = randinterval(matrix,count,key) 
%计算间隔的位数 
[m,n] = size(matrix); 
interval1 = floor(m*n/count)+1; 
interval2 = interval1-2; 
if interval2 == 0 
   error('载体大小不能将秘密信息隐藏进去!'); 
end 
%生成随机序列 
rand('seed',key); 
a = rand(1,count); 
%计算row和col 
r = 1; 
c = 1; 
row(1,1) = r; 
col(1,1) = c; 
for i = 2:count 
if a(i) >= 0.5 
   c = c + interval1; 
else 
   c = c + interval2; 
end 
if c > n 
  r = r+1; 
  if r > m 
    error('载体大小不能将秘密信息隐藏进去!'); 
end 
c = mod(c,n); 
if c == 0 
    c = 1; 
end 
end 
row(1,i) = r; 
col(1,i) = c; 
end
