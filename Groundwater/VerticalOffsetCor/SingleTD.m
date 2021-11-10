function [data, depthAdj] = SingleTD(filenumber,clipdata,density,WaterColAve,waterdepth)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
files = dir('*.mat');
filename = files(filenumber).name
data = load(filename);
filename = strsplit(filename, ".mat");
filename = char(filename(1));
data = eval(['data.', filename]);
data = data([clipdata :end],:);
placeholder = data;
placeholder.Properties.VariableNames{4} = 'cmDI';
depthAdj = ((mean(placeholder.cmDI(1:WaterColAve))/density) + waterdepth)
dtw = placeholder.cmDI/density - depthAdj;
plot(placeholder.Date_Time_MDT,dtw)
ylabel('depth to water from surface (cm)')
clear placeholder
eval(['data.dtw_cm_', filename,' = ','dtw', ';'])
eval([filename ,' = data',';']);
eval(['save(', '"', filename, '_final.mat', '"',', ', '"', filename, '"',')'])
writetimetable(eval(filename), filename); 
data = data;
end

