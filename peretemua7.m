function varargout = peretemua7(varargin)
% PERETEMUA7 MATLAB code for peretemua7.fig
%      PERETEMUA7, by itself, creates a new PERETEMUA7 or raises the existing
%      singleton*.
%
%      H = PERETEMUA7 returns the handle to a new PERETEMUA7 or the handle to
%      the existing singleton*.
%
%      PERETEMUA7('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PERETEMUA7.M with the given input arguments.
%
%      PERETEMUA7('Property','Value',...) creates a new PERETEMUA7 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before peretemua7_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to peretemua7_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help peretemua7

% Last Modified by GUIDE v2.5 11-Apr-2019 20:46:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @peretemua7_OpeningFcn, ...
                   'gui_OutputFcn',  @peretemua7_OutputFcn, ...
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


% --- Executes just before peretemua7 is made visible.
function peretemua7_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to peretemua7 (see VARARGIN)

% Choose default command line output for peretemua7
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes peretemua7 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = peretemua7_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function pushbutton1_Callback(hObject, eventdata, handles)

open=guidata(gcbo);
[namafile,direktori]=uigetfile({'*.jpg;*.bmp;*.tif'}, 'OpenImage');
I=imread(namafile);

set(open.figure1,'CurrentAxes',open.axes1);
set(imagesc(I));colormap('gray');
set(open.axes1,'Userdata',I);

% ===================================
% OPRASI TRANSALASI

Tx = 20;
Ty = 50;
A = imread(namafile);
[brs kol] = size(A);
for x = 1 : brs 
    for y = 1 : kol
        B(x+Tx, y+Ty) = A(x,y);
    end
end
B = B(1:brs,1:kol);
set(open.figure1,'CurrentAxes',open.axes3);
set(imagesc(B));colormap('gray');
set(open.axes1,'Userdata',B);

% ===================================
% OPERASI CROPPING
[brs kol] = size(I);
x1 = 50;
x2 = 200;
y1 = 50;
y2 = 200;
I(1:x1,:) = 0;
I(x2:brs,:) = 0;
I(:,1:y1) = 0;
I(:,y2:kol) = 0;
% imshow(I);
set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(I));colormap('gray');
set(open.axes2,'Userdata',I);

% ===================================
% OPERASI FLIPPING VERTIKAL
I=imread(namafile);
[brs kol] = size(I);
J = repmat(0,brs,kol);
mirror = floor(kol/2);
for x = 1 : brs-1
    for y = 1 : kol-1
    J(x,y) = I((2*mirror)-x, y);
    end
end
set(open.figure1,'CurrentAxes',open.axes4);
set(imagesc(J));colormap('gray');
set(open.axes4,'Userdata',J);

% ===================================
% OPERASI FLIPPING HORIZONAL
I=imread(namafile);
[brs kol] = size(I);
J = repmat(0,brs,kol);
mirror = floor(brs/2);
for x = 1 : brs-1
    for y = 1 : kol-1
        J(x,y) = I(x, (2*mirror)-y);
    end
end
set(open.figure1,'CurrentAxes',open.axes8);
set(imagesc(J));colormap('gray');
set(open.axes8,'Userdata',J);

% ===================================
% OPERASI ROTASI
T = 45;
E = imread(namafile);

% buka function yang ada di file rotasi.m
J = rotasi(E,T);

set(open.figure1,'CurrentAxes', open.axes5);
set(imagesc(J));colormap('gray');
set(open.axes5,'Userdata',J);
imshow(uint8(J),'initialmagnification','fit');

% ===================================
% OPERASI FLIPPING
F = imread(namafile);
ShX = 2;
ShY = 1;
K = perbesar(F,ShX,ShY);

set(open.figure1,'CurrentAxes', open.axes9);
set(imagesc(K));colormap('gray');
set(open.axes9,'Userdata',K);
imshow(uint8(K),'initialmagnification','fit');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
