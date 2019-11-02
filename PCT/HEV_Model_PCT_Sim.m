%% SETUP MODEL FOR RSIM
HEV_Vehicle_Mass = HEV_Param.Vehicle.Mass;
HEV_Model_Driver_Ki = 0.04;
mdl = 'HEV_SeriesParallel';
open_system(mdl);

%% CONFIGURE FOR TEST
Select_HEV_Model_Systems('Sys BC VS',HEV_Configs);
HEVSP_tictoc('off');
set_param([mdl '/Vehicle Dynamics/Simple'],'mass','HEV_Vehicle_Mass');
set_param([mdl '/SLRT Scope'],'Commented','on');
set_param(bdroot,'SimscapeLogType','none');
Drive_Cycle_Num = 1; 
set_param(mdl,'StopTime',num2str(eval(['UrbanCycle' num2str(Drive_Cycle_Num) '.time(end)'])));
save_system(mdl);

%% BUILD TARGET
rtp = Simulink.BlockDiagram.buildRapidAcceleratorTarget(mdl);

%% GENERATE PARAMETER SETS
Mass_array = [1000:50:1600]; 
SimSettings = Generate_Sim_Settings(Mass_array,'HEV_Vehicle_Mass',rtp);

numSims = length(SimSettings);
out = cell(1, numSims);

%% START PARALLEL POOL
parpool(2);
Initialize_MLPool

%% SIMULATE
tic;
for i = 1:numSims
    out{i} = sim(mdl, SimSettings{i});
end
Total_Testing_Time = toc;
disp(['Total Testing Time (for)    = ' num2str(Total_Testing_Time)]);

%% SIMULATE
tic;
parfor i = 1:numSims
    out{i} = sim(mdl, SimSettings{i});
end
Total_Testing_Time = toc;
disp(['Total Testing Time (parfor) = ' num2str(Total_Testing_Time)]);

%% PLOT RESULTS
figure(1)
clf
set(gcf,'Position',[11   356   545   293]);

for i=numSims:-1:1
    data = out{i}.find('Motor');
    plot(data.time(:,1),data.signals(3).values(:,1),'LineWidth',2)
    hold all
end
title('Motor Torque','FontSize',16,'FontWeight','Bold');
xlabel('Time (s)','FontSize',12,'FontWeight','Bold');
ylabel('Motor Torque','FontSize',12,'FontWeight','Bold');
legend(cellstr(num2str(fliplr(Mass_array(1:1:end))')),'FontSize',10);

%% CLOSE PARALLEL POOL
delete(gcp);
HEV_Param.Control.Mode_Logic_TS = 0.1;

%% UNDO CONFIGURATION CHANGES, CLEANUP DIR 
HEVSP_tictoc('on');
set_param([mdl '/Vehicle Dynamics/Simple'],'mass','HEV_Param.Vehicle.Mass');
set_param([mdl '/SLRT Scope'],'Commented','off');
set_param(bdroot,'SimscapeLogType','all');
Select_HEV_Model_Systems('Sys BD VF',HEV_Configs);
save_system(mdl);
bdclose(mdl);
delete('*.mex*')
!rmdir slprj /S/Q

% Copyright 2013-2016 The MathWorks(TM), Inc.

