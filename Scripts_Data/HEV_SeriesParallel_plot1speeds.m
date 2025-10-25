% Code to plot simulation results from HEV_SeriesParallel.slx
%% Plot Description:
%
% The plot below shows the requested and measured torque for the
% test, as well as the phase currents in the electric drive.

% Copyright 2017-2025 The MathWorks, Inc.

% Reuse figure if it exists, else create new figure
if ~exist('h1_HEV_SeriesParallel', 'var') || ...
        ~isgraphics(h1_HEV_SeriesParallel, 'figure')
    h1_HEV_SeriesParallel = figure('Name', 'HEV_SeriesParallel');
end
figure(h1_HEV_SeriesParallel)
clf(h1_HEV_SeriesParallel)

% Get simulation results
simlog_t      = logsout_HEV_SeriesParallel.get('RefSpd').Values.Time;
simlog_RefSpd = logsout_HEV_SeriesParallel.get('RefSpd').Values.Data;
simlog_vehSpd = logsout_HEV_SeriesParallel.get('vehSpd').Values.Data;


% Plot results
%simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_t, simlog_RefSpd, 'LineWidth', 1,'DisplayName','Commanded')
hold on
plot(simlog_t, simlog_vehSpd,'--','LineWidth', 1,'DisplayName','Measured')
hold off
grid on
title('Vehicle Speed')
ylabel('Speed (kph)')
legend('Location','NorthWest');

annStr = ['# Steps: ' num2str(length(simlog_t)) ', Duration: ' num2str(Elapsed_Sim_Time)];

text(0.95,0.95,annStr,'Color',[1 1 1]*0.6,...
    'Units','Normalized','HorizontalAlignment','right');

%{
simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_t, simlog_iMot(:,1))
hold on
plot(simlog_t, simlog_iMot(:,2))
plot(simlog_t, simlog_iMot(:,3))
hold off
grid on
title('Phase Currents')
ylabel('Current (A)')
xlabel('Time (s)')
linkaxes(simlog_handles, 'x')
%}

% Remove temporary variables
%clear simlog_t simlog_handles
%clear simlog_trq_meas simlog_trq_estim
%clear simlog_trq_ref simlog_trq_lim
%clear simlog_iMot
