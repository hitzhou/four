function varargout = nec(varargin)
% NEC MATLAB code for nec.fig
%      NEC, by itself, creates a new NEC or raises the existing
%      singleton*.
%
%      H = NEC returns the handle to a new NEC or the handle to
%      the existing singleton*.
%
%      NEC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEC.M with the given input arguments.
%
%      NEC('Property','Value',...) creates a new NEC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nec_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nec_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nec

% Last Modified by GUIDE v2.5 16-Apr-2016 16:03:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nec_OpeningFcn, ...
                   'gui_OutputFcn',  @nec_OutputFcn, ...
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


% --- Executes just before nec is made visible.
function nec_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nec (see VARARGIN)

% Choose default command line output for nec
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nec wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nec_OutputFcn(hObject, eventdata, handles) 
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

global M;
global a;
global window;
global K;
global N;
global H;
global I;
global J;
global L;
global BLOCK;
global BLOCK2;

M=512;    %ԭͼ�񳤶�
a=0.1;   %ˮӡǶ��ǿ������
window=[7,7];  %��ֵ�˲����ڴ�С
K=8;
N=M/K;
H=zeros(M,M);
I=zeros(M,M);
J=zeros(N,N);
L=zeros(N,N);
BLOCK=zeros(K,K);
BLOCK2=zeros(K,K);




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
     global I;
     global H;
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'ѡ��ͼ��');
if isequal(filename,0)||isequal(pathname,0)
  errordlg('����û��ѡȡͼƬ����','��ܰ��ʾ');%���û�����룬�򴴽�����Ի��� 
  return;
else
    image=[pathname,filename];%�ϳ�·��+�ļ���
    I=imread(image);%��ȡͼ��
    set(handles.axes1,'HandleVisibility','ON');%�����꣬�������
    axes(handles.axes1);%%ʹ��ͼ�񣬲���������1
    imshow(I);%������axes1��ʾԭͼ�� 
    H = I;
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
     global J;
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'ѡ��ͼ��');
if isequal(filename,0)||isequal(pathname,0)
  errordlg('����û��ѡȡͼƬ����','��ܰ��ʾ');%���û�����룬�򴴽�����Ի��� 
  return;
else
    image=[pathname,filename];%�ϳ�·��+�ļ���
    J=imread(image);%��ȡͼ��
    set(handles.axes3,'HandleVisibility','ON');%�����꣬�������
    axes(handles.axes3);%%ʹ��ͼ�񣬲���������3
    imshow(J);%������axes3��ʾԭͼ�� 
end

% --- Executes on button press in pushbutton4.
%Ƕ��ˮӡ
global a;
global K;
global N;
global H;
global I;

global BLOCK;

for p=1:N
    for q=1:N
        x = (p-1)*K+1;
        y = (q-1)*K+1;
        BLOCK=I(x:x+K-1,y:y+K-1);
        %disp(BLOCK);
        BLOCK = dct2(BLOCK);
        %[i,j]=find(BLOCK==max(max(BLOCK)));
        if J(p,q) == 0
            w = -1;
        else
            w = 1;
        end
        %disp(BLOCK);disp(BLOCK(i,j));
        %disp([i,j]);
        %tmp = BLOCK(2,1);
        BLOCK(2,1) = BLOCK(2,1)*(1+w*a);
        BLOCK = idct2(BLOCK);
        H(x:x+K-1,y:y+K-1) = BLOCK;
        %tmp2=dct2(H(x:x+K-1,y:y+K-1));
        %disp(tmp2(2,1)-tmp);
    end
end

function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global H;
%��ʾǶ��ˮӡ���ͼ��
set(handles.axes2,'HandleVisibility','ON');%�����꣬�������
axes(handles.axes2);%%ʹ��ͼ�񣬲���������2
imshow(H);


% --- Executes on button press in pushbutton5
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%��ȡˮӡ
global a;
global K;
global N;
global H;
global I;
global BLOCK;
global BLOCK2;

for p=1:N
    for q=1:N
        x=(p-1)*K+1;
        y=(q-1)*K+1;
        BLOCK=H(x:x+K-1,y:y+K-1);
        BLOCK2=I(x:x+K-1,y:y+K-1);
        BLOCK=dct2(BLOCK);
        BLOCK2=dct2(BLOCK2); 
        %[i,j]=find(BLOCK2==max(max(BLOCK2)));
        
        w=(BLOCK(2,1)-BLOCK2(2,1))/(BLOCK2(2,1)*a);
        
        if w>0
            L(p,q)=1;      
        else if w < 0
            L(p,q)=0;
        end
    end
    end
end

%��ʾ��ȡ��ˮӡͼ��
set(handles.axes4,'HandleVisibility','ON');%�����꣬�������
axes(handles.axes4);%%ʹ��ͼ�񣬲���������4
imshow(L);
