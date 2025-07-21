clc; clear; close all;

% Set folder path and filenames
folderPath = 'F:\sub1';
inputFile = fullfile(folderPath, 'MT_012003B0-001-000.txt');   % Input file
outputFile = fullfile(folderPath, 'acc_norm.txt');             % Output file

% 1. Load data
DATA = importdata(inputFile);
Data_IMU = DATA.data;
acc = Data_IMU(:,6:8);  % Extract 3-axis acceleration

% 2. Low-pass filtering (assuming lopass_butterworth is a custom function)
for i = 1:3
    B(:,i) = lopass_butterworth(acc(:,i), 100, 500, 3);
end

% 3. Time axis and interpolation
datalength = size(B,1);
time = (1:datalength)';
time500 = (1:1/5:datalength)';
acc500 = interp1(time, B, time500, 'spline');  % Spline interpolation to 500 Hz

% 4. Compute norm (Euclidean magnitude) at each time point
m = size(acc500,1);
f = zeros(m,1);
for i = 1:m
    a = acc500(i,:);          % Current 3-axis values
    f(i,1) = norm(a);         % Euclidean norm
end

% Round to 4 decimal places
f = round(f, 4);

% 5. Save result to text file
writematrix(f, outputFile, 'Delimiter', 'tab');

disp(['Processing complete. Result saved to: ', outputFile]);
