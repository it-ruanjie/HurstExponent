clear; clc; close all;

%========================================
% LOAD/GENERATE DATA

nsteps = 10000;
time_vector = linspace(0, 100, nsteps);
TimeSeriesData = randn(nsteps, 1);
% Time Series should be column vector.
% If your TimeSeries is row vector do - TimeSeries = TimeSeries';

% Visualise the data
figure(1);
plot(time_vector, TimeSeriesData);
hold on
plot(time_vector, 8);
plot(time_vector, -8);


%========================================
% Calculate Hurst Exponent

% set scale - See the end to see how to choose
scale = [16, 32, 64, 128, 256, 512, 1024];

% set m - order of polynomial fit
% In most cases m = 1 will work. If it doesn't set m = 2 or 3
m = 1;

% Find Hurst Exponent
H = HurstExponent(TimeSeriesData, scale, m);
H

%========================================
% FAQ

% Q) HOW TO CHOOSE SCALE VECTOR?
% The scales should be from a sufficiently low value to a value about length(TimeSeries)/7
% Here we have length(TimeSeries) = 10000; Start-16, Stop-10000/7 = 1024(the last multiple of 2 in the range)
% Choose values in multiples of 2

% Q) VERIFY CORRECTNESS?
% To see if the range of scales is right and if H is being calculated correctly
% Uncomment the last 2 lines of the HurstExponent.m function. For every Time Series it should produce a straight line.

