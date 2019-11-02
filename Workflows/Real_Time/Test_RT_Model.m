%% OPEN MODEL
mdl = 'HEV_SeriesParallel';
open_system(mdl);
HEVPS_setupRTtest

%% Get reference results
HEVSP_setdesktop
sim(mdl)
t_ref = Car.time; y_ref = Car.signals(4).values(:,1);
clear tout yout

%% Create plot for comparing results
figure(1); clf;
temp_colororder = get(gca,'DefaultAxesColorOrder');
set(gcf,'Position',[552    50   472   301]);
plot(t_ref,y_ref,'k','LineWidth',3)
title('Comparing Simulation Results','FontSize',14,'FontWeight','Bold');
xlabel('Time (s)','FontSize',12);ylabel('Vehicle Speed');
legend({'Reference'},'Location','NorthWest')
set(gca,'YLim',[0 20]);

%% Test with fixed-step, fixed-cost solver
HEVSP_setrealtime
sim(mdl)
t_fs = Car.time; y_fs = Car.signals(4).values(:,1);

%% Add fixed-step results to plot
figure(1)
hold on
h2=stairs(t_fs, y_fs,'Color',temp_colororder(2,:),'LineWidth',2.5);
hold off
legend({'Reference','Fixed-Step'},'Location','NorthWest')

%% Enable real-time parameter
tune_bpth = [mdl '/Vehicle Dynamics/Simple/Inertia'];
set_param(tune_bpth,'inertia_conf','runtime');

% Highlight block
open_system(get_param(tune_bpth,'Parent'),'force')
set_param(tune_bpth,'Selected','on');

%% Build and download to real-time target
slbuild(mdl);

%% Set simulation mode to external
set_param(mdl,'SimulationMode','External');

%% Connect to target and run
set_param(mdl, 'SimulationCommand', 'connect')
set_param(mdl, 'SimulationCommand', 'start')

open_system(mdl);
disp('Waiting for Simulink Real-Time to finish...');
pause(1);
disp(get_param(mdl,'SimulationStatus'));
while(~strcmp(get_param(mdl,'SimulationStatus'),'stopped'))
    pause(2);
    disp(get_param(mdl,'SimulationStatus'));
end
pause(2);

t_rt = tg.TimeLog; y_rt = tg.OutputLog;

%% Add results from real-time simulation
figure(1)
hold on
h3=stairs(t_rt,y_rt,'c:','LineWidth',2.5);
hold off
legend({'Reference','Fixed-Step','Real-Time'},'Location','NorthWest');

%% Change a Simscape block parameter
mass_ParamId = getparamid(tg,'','HEV_Vehicle_Mass');
disp(['Vehicle Mass (current) = ' num2str(getparam(tg,mass_ParamId))]);
setparam(tg,mass_ParamId,1800);
disp(['Vehicle Mass (new)     = ' num2str(getparam(tg,mass_ParamId))]);

%% Run simulation on real-time hardware
tg.start

disp('Waiting for Simulink Real-Time to finish...');
pause(1);
disp(tg.Status);
while(~strcmp(tg.Status,'stopped'))
    pause(2);
    disp(tg.Status);
end
pause(2);

t_rt2 = tg.TimeLog; y_rt2 = tg.OutputLog;

%% Add results from modified vehicle model
figure(1)
hold on
h4=stairs(t_rt2,y_rt2,'Color',temp_colororder(4,:),'LineWidth',2);
hold off
legend({'Reference','Fixed-Step','Real-Time','Modified'},'Location','NorthWest');

% Copyright 2011-2019 The MathWorks(TM), Inc.
%% Close model and clean up directory
cleanup_rt_dir
