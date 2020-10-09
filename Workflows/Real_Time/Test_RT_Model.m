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
% Choose target
cs = getActiveConfigSet(mdl);
cs.switchTarget('slrealtime.tlc',[]);

slbuild(mdl);

%% Download to real-time target
tg = slrealtime;
tg.connect;

%% Run application
tg.load(mdl)
tg.start('ReloadOnStop',true,'ExportToBaseWorkspace',true)

open_system(mdl);
disp('Waiting for SLRT to finish...');
pause(1);
while(strcmp(tg.status,'running'))
    pause(2);
    disp(tg.status);
end
pause(2);

%% Extract results from logged data in Simulink Data Inspector
y_slrt1 = logsout.LiveStreamSignals.get('Veh Spd');

%% Add results from real-time simulation
figure(1)
hold on
h3=stairs(y_slrt1.Values.Time,y_slrt1.Values.Data,'c:','LineWidth',2.5);
hold off
legend({'Reference','Fixed-Step','Real-Time'},'Location','NorthWest');

%% Change a Simscape block parameter
disp(['Vehicle Mass (current) = ' num2str(getparam(tg,'','HEV_Vehicle_Mass'))]);
setparam(tg,'','HEV_Vehicle_Mass',1800)
disp(['Vehicle Mass (new)     = ' num2str(getparam(tg,'','HEV_Vehicle_Mass'))]);

%% Run simulation with new parameter value
tg.start('ReloadOnStop',true,'ExportToBaseWorkspace',true)

disp('Waiting for Simulink Real-Time to finish...');
pause(1);
while(strcmp(tg.status,'running'))
    pause(2);
    disp(tg.status);
end
pause(2);

%% Extract results from logged data in Simulink Data Inspector
y_slrt2 = logsout.LiveStreamSignals.get('Veh Spd');

%% Add results from modified vehicle model
figure(1)
hold on
h4=stairs(y_slrt2.Values.Time,y_slrt2.Values.Data,'Color',temp_colororder(4,:),'LineWidth',2);
hold off
legend({'Reference','Fixed-Step','Real-Time','Modified'},'Location','NorthWest');

% Copyright 2011-2020 The MathWorks(TM), Inc.
%% Close model and clean up directory
cleanup_rt_dir
