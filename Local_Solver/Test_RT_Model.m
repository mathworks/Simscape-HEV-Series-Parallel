%% OPEN MODEL
% Copyright 2011-2016 The MathWorks, Inc.

mdl = 'HEV_SeriesParallel';
open_system(mdl);
Select_HEV_Model_Systems('Sys BC VS',HEV_Configs);
set_param(mdl,'StopTime','30');
Drive_Cycle_Num = 1;

set_param(mdl,'SimscapeLogType','None');
set_param(mdl,'SignalLogging','off');

%% GET REFERENCE RESULTS
HEVSP_setdesktop
sim(mdl)
t_ref = Car.time; y_ref = Car.signals(4).values(:,1);
clear tout yout

%% CREATE PLOT
figure(1)
set(gcf,'Position',[552    50   472   301]);
plot(t_ref,y_ref,'k','LineWidth',3)
title('Comparing Simulation Results','FontSize',14,'FontWeight','Bold');
xlabel('Time (s)','FontSize',12);ylabel('Vehicle Speed');
legend({'Reference'},'Location','best')

%% LOAD REAL-TIME SIMULATION SOLVER SETTINGS
HEVSP_setrealtime
sim(mdl)
t_fs = Car.time; y_fs = Car.signals(4).values(:,1);

%% ADD FIXED-STEP RESULTS TO PLOT
figure(1)
set(gcf,'Position',[552    50   472   301]);
h1=plot(t_ref,y_ref,'k','LineWidth',3);
hold on
h2=stairs(t_fs, y_fs,'r','LineWidth',2.5);
title('Comparing Simulation Results','FontSize',14,'FontWeight','Bold');
xlabel('Time (s)','FontSize',12);ylabel('Vehicle Speed');
legend([h1(1) h2(1)],{'Reference','Fixed-Step'},'Location','best')
hold off

%% BUILD AND DOWNLOAD XPC TARGET
slbuild(mdl);

%% SET SIMULATION MODE TO EXTERNAL
set_param(mdl,'SimulationMode','External');

%% CONNECT TO TARGET AND RUN
set_param(gcs, 'SimulationCommand', 'connect')
set_param(gcs, 'SimulationCommand', 'start')

open_system(mdl);
disp('Waiting for Simulink Real-Time to finish...');
pause(1);
disp(get_param(bdroot,'SimulationStatus'));
while(~strcmp(get_param(bdroot,'SimulationStatus'),'stopped'))
    pause(2);
    disp(get_param(bdroot,'SimulationStatus'));
end
%% PLOT REFERENCE AND REAL-TIME RESULTS
figure(1)
clf
set(gcf,'Position',[552    50   472   301]);
h1=plot(t_ref,y_ref,'k','LineWidth',5);
hold on
h2=stairs(t_fs,y_fs,'r','LineWidth',2.5);
h3=stairs(tg.TimeLog,tg.OutputLog,'c-.','LineWidth',1);
hold off
xlabel('Time (s)'); ylabel('Results');
title('Reference and Real-Time Results','FontSize',14,'FontWeight','Bold');
legend([h1(1),h2(1),h3(1)],{'Reference','Fixed-Step','Real-Time'},'Location','Best');

%% CLOSE MODEL AND CLEAN UP DIRECTORY
cleanup_rt_dir
