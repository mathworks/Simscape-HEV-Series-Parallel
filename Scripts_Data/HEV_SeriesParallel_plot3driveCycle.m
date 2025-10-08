% Code to plot simulation results from HEV_SeriesParallel.slx

% Copyright 2017-2023 The MathWorks, Inc.

% Reuse figure if it exists, else create new figure
if ~exist('h3_HEV_SeriesParallel', 'var') || ...
        ~isgraphics(h3_HEV_SeriesParallel, 'figure')
    h3_HEV_SeriesParallel = figure('Name', 'HEV_SeriesParallel');
end
figure(h3_HEV_SeriesParallel)
clf(h3_HEV_SeriesParallel)

plot(DriveCycles(Drive_Cycle_Num).time, DriveCycles(Drive_Cycle_Num).SpdKph, 'LineWidth', 1)
grid on
title(['Vehicle Speed for Drive Cycle ' num2str(Drive_Cycle_Num)]);
ylabel('Speed (kph)')

xlabel('Time (s)')
