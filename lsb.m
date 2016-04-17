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

[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'ѡ��ͼ��');
if isequal(filename,0)||isequal(pathname,0)
  errordlg('����û��ѡȡͼƬ����','��ܰ��ʾ');%���û�����룬�򴴽�����Ի��� 
  return;
else
    image=[pathname,filename];%�ϳ�·��+�ļ���
    im=imread(image);%��ȡͼ��
    set(handles.axes1,'HandleVisibility','ON');%�����꣬�������
    axes(handles.axes1);%%ʹ��ͼ�񣬲���������1
    imshow(im);%������axes1��ʾԭͼ�� 
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global water;
global watermark;
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'ѡ��ͼ��');
if isequal(filename,0)||isequal(pathname,0)
  errordlg('����û��ѡȡͼƬ����','��ܰ��ʾ');%���û�����룬�򴴽�����Ի��� 
  return;
else
    watermark=[pathname,filename];%�ϳ�·��+�ļ���
    water=imread(watermark);%��ȡͼ��
    set(handles.axes2,'HandleVisibility','ON');%�����꣬�������
    axes(handles.axes2);%%ʹ��ͼ�񣬲���������2
    imshow(water);%������axes1��ʾԭͼ�� 
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

%����˵��:
%input����Ϣ��������ͼ��
%file��������Ϣ�ļ�
%output����Ϣ���غ������ͼ��
%key������������Կ
vector = image;
secret = watermark;
output = 'file:///Users/zssec/Desktop/four/output.bmp';
key = 1992;%��Կ
I1 = imread(vector);%��������lena�Ҷ�bmpͼ��
ste_cover = double(I1);
I2 = ste_cover;
J1 = imread(secret);%����Ƕ���bmpͼ��
J2 = dec2bin(J1);%��ͼ���еĻҶ�ֵתΪ�����Ƶ�һ��n������
J2 = double(J2);
[m,n] = size(ste_cover);%��ȡ����ͼ�������������
%vector_total=m*n;
[a,b] = size(J2);%��ȡǶ��ͼ�������������
f_id = fopen(secret,'r');
[msg,len_total] = fread(f_id,'ubit1');
%�ж�Ƕ��ͼ���Ƿ����
if len_total > m*n
    error('Ƕ����Ϣ������,�����ͼ��');
end
p = 1; %��Ϊ��ϢǶ��λ��������
%�����������ѡȡ���ص�
[row,col] = randinterval(ste_cover,len_total,key);
%Ƕ������
for i = 1:len_total
%������δ���Ҳ����ʵ����ͬ����
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
set(handles.axes3,'HandleVisibility','ON');%�����꣬�������
axes(handles.axes3);%%ʹ��ͼ�񣬲���������3
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

%��ȡ����
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
set(handles.axes4,'HandleVisibility','ON');%�����꣬�������
axes(handles.axes4);%%ʹ��ͼ�񣬲���������4
imshow(J1);

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%�ļ���:randinterval.m 
%��������:������������������н��м������,ѡ����Ϣ����λ�� 
%�����ʽ����:[row,col]=randinterval(test,60,1983) 
%����˵��: 
%matrixΪ������� 
%countΪҪǶ�����Ϣ������(Ҫѡ�����������) 
%keyΪ��Կ 
%rowΪα�������������б� 
%colΪα�������������б� 
function [row,col] = randinterval(matrix,count,key) 
%��������λ�� 
[m,n] = size(matrix); 
interval1 = floor(m*n/count)+1; 
interval2 = interval1-2; 
if interval2 == 0 
   error('�����С���ܽ�������Ϣ���ؽ�ȥ!'); 
end 
%����������� 
rand('seed',key); 
a = rand(1,count); 
%����row��col 
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
    error('�����С���ܽ�������Ϣ���ؽ�ȥ!'); 
end 
c = mod(c,n); 
if c == 0 
    c = 1; 
end 
end 
row(1,i) = r; 
col(1,i) = c; 
end
