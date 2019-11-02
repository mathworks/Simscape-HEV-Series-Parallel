%% SETUP MODEL FOR RSIM
% Copyright 2011 The MathWorks(TM), Inc.

HEV_Vehicle_Mass = HEV_Param.Vehicle.Mass;
HEV_Model_Driver_Ki = 0.04;
mdl = 'HEV_Model_PCT';
open_system(mdl);

%% BUILD TARGET
rtp = Simulink.BlockDiagram.buildRapidAcceleratorTarget(mdl);

%% GENERATE PARAMETER SETS
Mass_array = [1000:100:1600]; 
SimSettings = Generate_Sim_Settings(Mass_array,'HEV_Vehicle_Mass',rtp);

numSims = length(SimSettings);
out = cell(1, numSims);

%% START MATLAB POOL
matlabpool;
Initialize_MLPool

%% SIMULATE
tic;
parfor i = 1:numSims
    out{i} = sim(mdl, SimSettings{i});
end
Total_Testing_Time = toc;
disp(['Total Testing Time = ' num2str(Total_Testing_Time)]);

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

%% CLOSE MATLABPOOL 
matlabpool close
HEV_Param.Control.Mode_Logic_TS = 0.1;
