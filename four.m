function varargout = four(varargin)
% FOUR MATLAB code for four.fig
%      FOUR, by itself, creates a new FOUR or raises the existing
%      singleton*.
%
%      H = FOUR returns the handle to a new FOUR or the handle to
%      the existing singleton*.
%
%      FOUR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOUR.M with the given input arguments.
%
%      FOUR('Property','Value',...) creates a new FOUR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before four_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to four_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help four

% Last Modified by GUIDE v2.5 14-Apr-2016 23:13:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @four_OpeningFcn, ...
                   'gui_OutputFcn',  @four_OutputFcn, ...
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


% --- Executes just before four is made visible.
function four_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to four (see VARARGIN)

% Choose default command line output for four
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes four wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = four_OutputFcn(hObject, eventdata, handles) 
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
     global im;
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
global im;
global Igray;
set(handles.axes2,'HandleVisibility','ON');%打开坐标，方便操作
axes(handles.axes2);%%使用图像，操作在坐标2
Igray = rgb2gray(im);
imshow(Igray);



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Igray;
global watermarked_img;
ori_img = Igray; 
 
% compute size of the original image
H = size(ori_img, 1);	% height 
W = size(ori_img, 2);	% width
num = H * W;   % the number of pixels
 
% get 2~8 bits from each 8 pixels
line = ceil(num/8);
binarray = zeros(line, 56);
k = 1;
m = 0;
for i = 1 : H 
    for j = 1 : W
        if m > 7
            m = 0;
            k = k + 1; 
        end
        binarray(k, 7 * m + 1) = bitget(ori_img(i, j), 8);
        binarray(k, 7 * m + 2) = bitget(ori_img(i, j), 7);
        binarray(k, 7 * m + 3) = bitget(ori_img(i, j), 6);
        binarray(k, 7 * m + 4) = bitget(ori_img(i, j), 5);
        binarray(k, 7 * m + 5) = bitget(ori_img(i, j), 4);
        binarray(k, 7 * m + 6) = bitget(ori_img(i, j), 3);
        binarray(k, 7 * m + 7) = bitget(ori_img(i, j), 2);
        m = m + 1;
    end
end

% compute watermark
binarray = uint8(binarray);
watermark = zeros(1, 56);
watermark = uint8(watermark);
for k = 1 : line
    watermark(1, :) = bitxor(watermark(1, :), binarray(k, :));
end
 
% set the lsb of 56 pixels of the original images to the value of watermark
k = 1;
watermarked_img = ori_img;
for i = 1 : H
    for j = 1 : W
        if k <= 56
            watermarked_img(i, j) = bitset(watermarked_img(i, j), 1, watermark(1, k));
            k = k + 1;
        end
    end
end
 
% write the watermarked image to a file 

% display watermarked image 
    set(handles.axes3,'HandleVisibility','ON');%打开坐标，方便操作
    axes(handles.axes3);%%使用图像，操作在坐标1
imshow(watermarked_img,[]) 



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% function [psnr_value] = lsb_embed()
% lsb_embed:  Least Significant Bit Substitution
%             Watermark Embeding
% psnr_value: Return the Value of PSNR
global Igray;
global watermarked;
global watermarked_image;
% read in the cover object 
cover_object = Igray; 
 
% read in the message image 
message=watermarked; 
message1=message; 
 
% convert to double for normalization, then back again 
message=double(message);
message=fix(message./2); 
message=uint8(message); 
 
% determine size of cover object 
Mc=size(cover_object,1);	%Height 
Nc=size(cover_object,2);	%Width 
 
% determine size of message object 
Mm=size(message,1);	        %Height 
Nm=size(message,2);	        %Width 
 
% title the message object out to cover object size to generate watermark 
for ii = 1:Mc 
    for jj = 1:Nc
        watermark(ii,jj)=message(mod(ii,Mm)+1,mod(jj,Nm)+1);
    end 
end 

% now we set the lsb of cover_object(ii,jj) to the value of watermark(ii,jj) 
watermarked_image=cover_object; 
for ii = 1:Mc 
    for jj = 1:Nc 
        watermarked_image(ii,jj)=bitset(watermarked_image(ii,jj),1,watermark(ii,jj));
    end 
end 

% display watermarked image 
set(handles.axes4,'HandleVisibility','ON');%打开坐标，方便操作
axes(handles.axes4);%%使用图像，操作在坐标4
imshow(watermarked_image,[]) 



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% h = gcf;
nec;
% close(h);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
patchwork;

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% read the watermarked image 
global watermarked_img;
% file_name = 'distort_lena.bmp'; 
% watermarked_img = imread(file_name); 

% compute size of the watermarked image
H = size(watermarked_img, 1);	% height 
W = size(watermarked_img, 2);	% width
num = H * W;   % the number of pixels
 
% get 2~8 bits from each 8 pixels
line = ceil(num/8);
binarray = zeros(line, 56);
k = 1;
m = 0;
for i = 1 : H 
    for j = 1 : W
        if m > 7
            m = 0;
            k = k + 1; 
        end
        binarray(k, 7 * m + 1) = bitget(watermarked_img(i, j), 8);
        binarray(k, 7 * m + 2) = bitget(watermarked_img(i, j), 7);
        binarray(k, 7 * m + 3) = bitget(watermarked_img(i, j), 6);
        binarray(k, 7 * m + 4) = bitget(watermarked_img(i, j), 5);
        binarray(k, 7 * m + 5) = bitget(watermarked_img(i, j), 4);
        binarray(k, 7 * m + 6) = bitget(watermarked_img(i, j), 3);
        binarray(k, 7 * m + 7) = bitget(watermarked_img(i, j), 2);
        m = m + 1;
    end
end

% compute checksum value
binarray = uint8(binarray);
checksum_value = zeros(1, 56);
checksum_value = uint8(checksum_value);
for k = 1 : line
    checksum_value(1, :) = bitxor(checksum_value(1, :), binarray(k, :));
end

% compare checksum value with the watermark
watermark = zeros(1, 56);
k = 1;
for i = 1 : H
    for j = 1 : W
        if k <= 56
            watermark(1, k) = bitget(watermarked_img(i, j), 1);
            k = k + 1;
        end
    end
end
% display watermarked image 
    set(handles.axes7,'HandleVisibility','ON');%打开坐标，方便操作
    axes(handles.axes7);%%使用图像，操作在坐标7
imshow(watermark,[]) 




% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% read in watermarked image 
global watermarked_image;
watermarked_object=watermarked_image; 

% no attack
if attack_style==0 
    ww=watermarked_object; 
end

% attack
% gaussian filtering
if attack_style == 1 
    k = fspecial('gaussian');   % define the filter operator
    yy = filter2(k,watermarked_object)/255;
    imwrite(yy,'lsb_watermarked_lpf.bmp','bmp');
    ww=imread('lsb_watermarked_lpf.bmp');
end
% add Gaussian noise
if attack_style==2
    yy=imnoise(watermarked_object,'gaussian');
    imwrite(yy,'lsb_watermarked_noise.bmp','bmp');
    ww=imread('lsb_watermarked_noise.bmp');
end
% % double size (half size before recovering)
% if attack_style==3
%     xxx1=imresize(watermarked_object,2,'bicubic');
%     xxx2=imresize(xxx1,1/2,'bicubic');
%     yy=double(xxx2);
%     imwrite(yy,'lsb_watermarked_enlarge.bmp','bmp');
%     ww=imread('lsb_watermarked_enlarge.bmp');
% end
 
% determine size of watermarked image 
Mw=size(watermarked_object,1);	%Height 
Nw=size(watermarked_object,2);	%Width 
 
% use lsb of watermarked image to recover watermark 
for ii = 1:Mw 
    for jj = 1:Nw 
        watermark(ii,jj)=bitget(ww(ii,jj),1); 
    end 
end  
  
% scale and display recovered watermark 
    set(handles.axes8,'HandleVisibility','ON');%打开坐标，方便操作
    axes(handles.axes8);%%使用图像，操作在坐标8
    imshow(watermark,[]) 

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global watermarked;
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'选择图像');
if isequal(filename,0)||isequal(pathname,0)
  errordlg('您还没有选取图片！！','温馨提示');%如果没有输入，则创建错误对话框 
  return;
else
    image = [pathname,filename];%合成路径+文件名
    watermarked = imread(image);%读取图像
    set(handles.axes11,'HandleVisibility','ON');%打开坐标，方便操作
    axes(handles.axes11);%%使用图像，操作在坐标1
    imshow(watermarked);%在坐标axes11显示原图像 
end

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes11
