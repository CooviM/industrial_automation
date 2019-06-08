clear all 
%% Import data from text file.
% Script for importing data from the following text file:
%
%    D:\Documents\Dropbox\Spring_2019\Industrial_automation\project_1\scope_3.csv
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2019/02/03 13:52:36

%% Initialize variables.
filename = 'D:\Documents\Dropbox\Spring_2019\Industrial_automation\project_1\scope_3.csv';
delimiter = ',';
startRow = 3;

%% Format for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
scope1 = table(dataArray{1:end-1}, 'VariableNames', {'second','Volt','Volt1'});

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;
data=[scope1{941:2938,1},scope1{941:2938,2}];
C=2.2*10^-6;
R=5100;
t=(data(:,1));
ydata=(data(:,2));
x0=[R C];
fun=@(A,t).5*(1-exp(-(2*t)/(A(1)*A(2))));
x=lsqcurvefit(fun,x0,t,ydata);
x1=nlinfit(t,ydata,fun,x0);
% plot(t, ydata);
% hold on
t1=linspace(0,0.25,1000);
yt=.5*(1-exp(-(2.*t1)/(x1(1)*x1(2))));

plot(t1,yt);