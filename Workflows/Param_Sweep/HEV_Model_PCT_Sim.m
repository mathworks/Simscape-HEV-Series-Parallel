%% Script to run HEV_SeriesParallel in parallel

% Resave model in PCT directory
cd(fileparts(which('HEV_SeriesParallel.slx')));
cd('PCT');
orig_mdl = 'HEV_SeriesParallel';
mdl = [orig_mdl '' ]; % Normally would add suffix for PCT copy
open_system(orig_mdl);
save_system(orig_mdl,[pwd filesep mdl]);

% Set up parameters
HEV_Vehicle_Mass = HEV_Param.Vehicle.Mass;
HEV_Model_Driver_Ki = 0.04;

% Set up model - vehicle configuration, other settings
Select_HEV_Model_Systems(mdl,'Sys BC VS',HEV_Configs);
HEVSP_tictoc('off');
set_param([mdl '/Vehicle Dynamics/Simple'],'mass','HEV_Vehicle_Mass');
set_param([mdl '/SLRT Scope'],'Commented','on');
set_param(bdroot,'SimscapeLogType','none');
Drive_Cycle_Num = 1; 
set_param(mdl,'StopTime',num2str(eval(['UrbanCycle' num2str(Drive_Cycle_Num) '.time(end)'])));

save_system(mdl);

%% GENERATE PARAMETER SETS
Mass_array = [1000:40:1600]; 

for i=1:length(Mass_array)
    simInput(i) = Simulink.SimulationInput(mdl);
    simInput(i) = simInput(i).setVariable('HEV_Vehicle_Mass',Mass_array(i));
end

%% Run
clear simOut
gcp('nocreate');

% Series
simOut  = sim(simInput,'ShowProgress','on','UseFastRestart','on');

%% Plots
if ~exist('h4_hev_seriesparallel_pct', 'var') || ...
        ~isgraphics(h4_hev_seriesparallel_pct, 'figure')
    h4_hev_seriesparallel_pct = figure('Name', 'hev_seriesparallel_pct');
end
figure(h4_hev_seriesparallel_pct)
clf(h4_hev_seriesparallel_pct)

temp_colororder = get(gca,'defaultAxesColorOrder');
set(gcf,'Position',[11   356   545   293]);

for i=length(simOut):-1:1
    data = simOut(i).Motor;
    plot(data.time(:,1),data.signals(3).values(:,1),'LineWidth',2)
    hold all
end
title('Motor Torque','FontSize',16,'FontWeight','Bold');
xlabel('Time (s)','FontSize',12,'FontWeight','Bold');
ylabel('Motor Torque','FontSize',12,'FontWeight','Bold');
legend(cellstr(num2str(fliplr(Mass_array(1:1:end))')),'FontSize',10);

%% Parallel
simOut  = parsim(simInput,'ShowProgress','on','UseFastRestart','on','ShowSimulationManager','on','TransferBaseWorkspaceVariables','on');

%% CLOSE PARALLEL POOL
delete(gcp);

%% CLEANUP DIR
%{x

bdclose(mdl);
movefile([mdl '.slx'],[mdl '_pct_temp.slx']);
!rmdir slprj /S/Q
delete([mdl '.slxc']);

%}x

% Copyright 2013-2019 The MathWorks(TM), Inc.

