function varargout = final(varargin)
% FINAL MATLAB code for final.fig
%      FINAL, by itself, creates a new FINAL or raises the existing
%      singleton*.
%
%      H = FINAL returns the handle to a new FINAL or the handle to
%      the existing singleton*.
%
%      FINAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINAL.M with the given input arguments.
%
%      FINAL('Property','Value',...) creates a new FINAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before final_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to final_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help final
% Last Modified by GUIDE v2.5 08-Jun-2016 13:39:05
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @final_OpeningFcn, ...
                   'gui_OutputFcn',  @final_OutputFcn, ...
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


% --- Executes just before final is made visible.
function final_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to final (see VARARGIN)

% Choose default command line output for final
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes final wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = final_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function lfile_Callback(hObject, eventdata, handles)
% hObject    handle to lfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axes = gca;
axes.Title.String = 'Moor Signal';
axes.Title.FontWeight = 'normal';

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axes = gca;
axes.Title.String = 'Prototype Signal';
axes.Title.FontWeight = 'normal';
% Hint: place code in OpeningFcn to populate axes2


% --- Executes on button press in LDB.
function LDB_Callback(hObject, eventdata, handles)
% hObject    handle to LDB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.mat','Open');
if filename~=0
    loaddata = load([pathname filename]);
    load('sampleRate.mat');
end
moor = resample( loaddata.LDF_Moor, 10, rate );
proto = resample( loaddata.LDF_Prototype, 10, rate );

moorEnergyS= czt_ldf( moor, 10, 1024 );
protoEnergyS = czt_ldf( proto, 10 ,1024);

for j=1:1:5
    dataMoorarray(1,j)=moorEnergyS(j);
    dataProtoarray(1,j)=protoEnergyS(j);
end
%disp(dataMoorarray);
%disp (dataProtoarray);
handles.dataProtoarray=dataProtoarray;
guidata(hObject, handles);
%moor is blue,prototype is red
axes(handles.axes5);
b = bar(dataProtoarray);
b.FaceColor = 'red';
axes(handles.axes6);
b2=bar( dataMoorarray);
b2.FaceColor = 'blue';
axes(handles.axes7);
bp=zeros(5,2);
for j=1:1:5
    bp(j,1) = dataMoorarray(1,j);
end
bar(bp,'group');
handles.bp=bp;
guidata(hObject, handles);
time = linspace( 0, 200, length( loaddata.LDF_Moor) );
%moor is blue, prototype is red
axes(handles.axes1);
hndl2 = plot( time, loaddata.LDF_Moor );
set(hndl2,'Color',[0 0 1]);
axes(handles.axes2);
hndl=plot( time, loaddata.LDF_Prototype );
set(hndl,'Color',[1 0 0]);



% --- Executes on button press in TDB_1.
function TDB_1_Callback(hObject, eventdata, handles)
% hObject    handle to TDB_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
beta_data1 =(1.0e-06)*[ 0.0266    0.0175    0.0085    0.0042    0.0098;
   -0.0284   -0.0202   -0.0066   -0.0052   -0.0037;
   -0.0998   -0.0487   -0.0119    0.0013   -0.0098;
    0.5918    0.3442    0.1086    0.0330    0.0537;
    0.0632   -0.0241   -0.0768   -0.0261   -0.0237;
   -0.7863   -0.3841   -0.0341   -0.0004    0.0094];
%disp(beta_data1);
dataProtoarray_data1=handles.dataProtoarray;
NdataProtoarray_data1=ones(1,6);
for i=1:1:6
    if i~=1
        NdataProtoarray_data1(1,i)=dataProtoarray_data1(1,i-1);
    end
end
%disp( NdataProtoarray_data1)
TdataProtoarray_data1=NdataProtoarray_data1*beta_data1;
TdataProtoarray_data1=abs(TdataProtoarray_data1);
%disp( TdataProtoarray_data1);
axes(handles.axes7);
bp=handles.bp;
for j=1:1:5
    bp(j,2) = TdataProtoarray_data1(1,j);
end
bar(bp,'group');
sum=0;
for j=1:1:5
    sum=sum+(abs(bp(j,1)-bp(j,2)))/bp(j,1);
end
sum=sum/5;
set(handles.text2, 'String',sum);
me=zeros(1, 5);
for i=1:1:5
    me(1, i)=bp(i, 1);
end
coef=corrcoef(me, TdataProtoarray_data1 );
set(handles.text4, 'String',coef(1,2));



% --- Executes on button press in TDB_2.
function TDB_2_Callback(hObject, eventdata, handles)
% hObject    handle to TDB_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
beta_data2 =(1.0e-06)*[ 0.0620    0.0349    0.0082    0.0062    0.0186;
    0.0212    0.0150    0.0059    0.0008    0.0150;
    0.1559    0.0949    0.0240    0.0076   -0.0233;
   -0.2300   -0.1553   -0.0225   -0.0148    0.0465;
   -0.7875   -0.4732   -0.1770    0.0013   -0.2244;
   -0.5366   -0.2980   -0.0568   -0.0848    0.1375];
%disp(beta_data2);
dataProtoarray_data2=handles.dataProtoarray;
NdataProtoarray_data2=ones(1,6);
for i=1:1:6
    if i~=1
        NdataProtoarray_data2(1,i)=dataProtoarray_data2(1,i-1);
    end
end
%disp( NdataProtoarray_data2)
TdataProtoarray_data2=NdataProtoarray_data2*beta_data2;
TdataProtoarray_data2=abs(TdataProtoarray_data2);
%disp( TdataProtoarray_data2);
axes(handles.axes7);
bp=handles.bp;
for j=1:1:5
    bp(j,2) = TdataProtoarray_data2(1,j);
end
bar(bp,'group');
sum=0;
for j=1:1:5
    sum=sum+(abs(bp(j,1)-bp(j,2)))/bp(j,1);
end
sum=sum/5;
set(handles.text2, 'String',sum);
me=zeros(1, 5);
for i=1:1:5
    me(1, i)=bp(i, 1);
end
coef=corrcoef(me, TdataProtoarray_data2 );
set(handles.text4, 'String',coef(1,2));

% --- Executes on button press in TFB.
function TFB_Callback(hObject, eventdata, handles)
% hObject    handle to TFB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
beta_finger =(1.0e-06)*[-0.0063    0.0024   -0.0037    0.0041    0.0042;
    0.0207    0.0078    0.0012    0.0057    0.0146;
    0.1356    0.1239    0.0537    0.0067    0.0150;
   -0.3915   -0.3447   -0.1849   -0.0126    0.0039;
    0.1954    0.0042    0.1287   -0.0864   -0.3310;
   -0.6732   -0.2275   -0.0862   -0.0224    0.0946];
%disp(beta_finger);
dataProtoarray_finger=handles.dataProtoarray;
NdataProtoarray_finger=ones(1,6);
for i=1:1:6
    if i~=1
        NdataProtoarray_finger(1,i)=dataProtoarray_finger(1,i-1);
    end
end
%disp( NdataProtoarray_finger)
TdataProtoarray_finger=NdataProtoarray_finger*beta_finger;
TdataProtoarray_finger=abs(TdataProtoarray_finger);
%disp( TdataProtoarray_finger);
axes(handles.axes7);
bp=handles.bp;
for j=1:1:5
    bp(j,2) = TdataProtoarray_finger(1,j);
end
bar(bp,'group');
sum=0;
for j=1:1:5
    sum=sum+(abs(bp(j,1)-bp(j,2)))/bp(j,1);
end
sum=sum/5;
set(handles.text2, 'String',sum);
me=zeros(1, 5);
for i=1:1:5
    me(1, i)=bp(i, 1);
end
coef=corrcoef(me, TdataProtoarray_finger );
set(handles.text4, 'String',coef(1,2));


% --- Executes during object creation, after setting all properties.
function TDB_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TDB_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes during object creation, after setting all properties.
function TDB_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TDB_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function TFB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TFB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function axes5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axes = gca;
axes.Title.String = '5 Features (Prototype)';
axes.Title.FontWeight = 'normal';


% --- Executes during object creation, after setting all properties.
function LDB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LDB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function axes6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axes = gca;
axes.Title.String = '5 Features (Moor)';
axes.Title.FontWeight = 'normal';
% Hint: place code in OpeningFcn to populate axes6


% --- Executes during object creation, after setting all properties.
function axes7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axes = gca;
axes.Title.String = '5 Features (Moor and Transform)';
axes.Title.FontWeight = 'normal';
% Hint: place code in OpeningFcn to populate axes7


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
