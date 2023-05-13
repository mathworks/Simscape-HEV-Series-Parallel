%% Script to run HEV_SeriesParallel in parallel
% Copyright 2013-2023 The MathWorks(TM), Inc.

% Move to folder where script is saved
cd(fileparts(which(mfilename)));

% Open model and save under another name for test
orig_mdl = 'HEV_SeriesParallel';
open_system(orig_mdl);
mdl = [orig_mdl '_pct_temp' ]; 
save_system(orig_mdl,mdl);

%% Configure model for tests

% Set up parameters
HEV_Vehicle_Mass = HEV_Param.Vehicle.Mass;
HEV_Model_Driver_Ki = 0.04;

% Model settings
Select_HEV_Model_Systems(mdl,'Sys BC VS',HEV_Configs);
HEVSP_tictoc('off');
set_param([mdl '/Vehicle Dynamics/Simple'],'mass','HEV_Vehicle_Mass');
set_param([mdl '/SLRT Scope'],'Commented','on');
set_param(bdroot,'SimscapeLogType','none');
Drive_Cycle_Num = 1; 
set_param(mdl,'StopTime',num2str(eval(['UrbanCycle' num2str(Drive_Cycle_Num) '.time(end)'])));

save_system(mdl);

%% Generate parameter sets
Mass_array = [1000:40:1600]; 

for i=1:length(Mass_array)
    simInput(i) = Simulink.SimulationInput(mdl);
    simInput(i) = simInput(i).setVariable('HEV_Vehicle_Mass',Mass_array(i));
end

%% Run one simulation to see time used
timerVal = tic;
sim(mdl)
Elapsed_Sim_Time_single = toc(timerVal);
disp(['Elapsed Simulation Time Single Run: ' num2str(Elapsed_Sim_Time_single)]);

%% Run parameter sweep in parallel
timerVal = tic;
simOut = parsim(simInput,'ShowSimulationManager','on',...
    'ShowProgress','on','UseFastRestart','on',...
    'TransferBaseWorkspaceVariables','on');
Elapsed_Time_Time_parallel  = toc(timerVal);

%% Calculate elapsed time less setup of parallel
Elapsed_Time_Sweep = ...
    (datenum(simOut(end).SimulationMetadata.TimingInfo.WallClockTimestampStop) - ...
    datenum(simOut(1).SimulationMetadata.TimingInfo.WallClockTimestampStart)) * 86400;
disp(['Elapsed Sweep Time Total:       ' sprintf('%5.2f',Elapsed_Time_Sweep)]);
disp(['Elapsed Sweep Time/(Num Tests): ' sprintf('%5.2f',Elapsed_Time_Sweep/length(simOut))]);

%% Plot results
plot_sim_res(simOut,'Parallel Test',Elapsed_Time_Time_parallel)


%% Close parallel pool
delete(gcp);

%% Cleanup directory

bdclose(mdl);
delete([mdl '.slx']);



%% Plot Function
function plot_sim_res(simOut,annotation_str,elapsed_time)

% Plot Results
fig_handle_name = 'h4_hev_seriesparallel_pct';

handle_var = evalin('base',['who(''' fig_handle_name ''')']);
if(isempty(handle_var))
    evalin('base',[fig_handle_name ' = figure(''Name'', ''' fig_handle_name ''');']);
elseif ~isgraphics(evalin('base',handle_var{:}))
    evalin('base',[fig_handle_name ' = figure(''Name'', ''' fig_handle_name ''');']);
end
figure(evalin('base',fig_handle_name))
clf(evalin('base',fig_handle_name))

for i=length(simOut):-1:1
    data = simOut(i).Motor;
    plot(data.time(:,1),data.signals(3).values(:,1),'LineWidth',2)
    hold all
end
title('Motor Torque','FontSize',16,'FontWeight','Bold');
xlabel('Time (s)','FontSize',12,'FontWeight','Bold');
ylabel('Motor Torque','FontSize',12,'FontWeight','Bold');
Mass_array = evalin('base','Mass_array');
legend(cellstr(num2str(fliplr(Mass_array(1:1:end))')),'FontSize',10);

text(0.05,0.05,[annotation_str ', Elapsed Time: ' num2str(elapsed_time)],'Color',[1 1 1]*0.6,'Units','Normalized');
end

