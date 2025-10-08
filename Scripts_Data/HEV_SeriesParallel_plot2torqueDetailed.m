% Code to plot simulation results from HEV_SeriesParallel.slx
%% Plot Description:
%
% The plot below shows the requested and measured torque for the
% test, as well as the phase currents in the electric drive.

% Copyright 2017-2023 The MathWorks, Inc.

fieldNamesMotor = fieldnames(simlog_HEV_SeriesParallel.Electrical.Motor);
if(~isempty(find(strcmp(fieldNamesMotor,'Detailed'))))

    % Reuse figure if it exists, else create new figure
    if ~exist('h2_HEV_SeriesParallel', 'var') || ...
            ~isgraphics(h2_HEV_SeriesParallel, 'figure')
        h2_HEV_SeriesParallel = figure('Name', 'HEV_SeriesParallel');
    end
    figure(h2_HEV_SeriesParallel)
    clf(h2_HEV_SeriesParallel)

    % Get simulation results

    simlog_t = simlog_HEV_SeriesParallel.Vehicle.Vehicle_Body.v.series.time;
    simlog_iMot = simlog_HEV_SeriesParallel.Electrical.Motor.Detailed.Meas_I.Current_Sensor.I.series.values('A');
    simlog_trq_ref = logsout_HEV_SeriesParallel.get('torque_ref');
    simlog_trq_meas = logsout_HEV_SeriesParallel.get('torque_meas');
    simlog_trq_estim = logsout_HEV_SeriesParallel.get('torque_estim');
    simlog_trq_lim = logsout_HEV_SeriesParallel.get('torque_lim');

    % Plot results
    simlog_handles(1) = subplot(2, 1, 1);
    plot(simlog_trq_meas.Values.Time, simlog_trq_meas.Values.Data, 'LineWidth', 1)
    hold on
    plot(simlog_trq_estim.Values.Time, simlog_trq_estim.Values.Data, 'LineWidth', 1)
    plot(simlog_trq_ref.Values.Time, simlog_trq_ref.Values.Data, 'LineWidth', 1)
    plot(simlog_trq_lim.Values.Time, simlog_trq_lim.Values.Data,'k-.', 'LineWidth', 1)
    plot(simlog_trq_lim.Values.Time, -simlog_trq_lim.Values.Data,'k-.', 'LineWidth', 1)
    hold off
    grid on
    title('Motor Torque')
    ylabel('Torque (Nm)')
    legend({'Measured','Estimated','Reference','Limits'},'Location','Best');

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

    % Remove temporary variables
    clear simlog_t simlog_handles
    clear simlog_trq_meas simlog_trq_estim
    clear simlog_trq_ref simlog_trq_lim
    clear simlog_iMot
else
    disp('Please run a simulation with the detailed electrical variant.')
end