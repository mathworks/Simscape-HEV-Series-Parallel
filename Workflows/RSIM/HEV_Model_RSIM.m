%% OPEN AND CONFIGURE MODEL
% Copyright 2011-2020 The MathWorks, Inc.

mdl = 'HEV_SeriesParallel';
open_system(mdl);
Select_HEV_Model_Systems(mdl,'Sys BC VF',HEV_Configs);
HEV_Param.Control.Mode_Logic_TS = 0.1;

%% BUILD STANDALONE EXECUTABLE
disp(['Building standalone executable for ' mdl]);
set_param(bdroot,'SystemTargetFile','rsim.tlc')
set_param(bdroot,'SimscapeLogType','none');
set_param(bdroot,'DefaultParameterBehavior','Inlined');
set_param([bdroot '/SLRT Scope'],'Commented','on');
slbuild(mdl);
disp(['Finished building standalone executable for ' mdl '.mdl']);

%% CREATE RSIM PARAMETER FILES
disp(' ');disp('Creating RSIM parameter files...')

Drive_Cycle_Num = 1; 
[rtpstruct]= rsimgetrtp(mdl);
save HEV_Model_Parameters_01 rtpstruct;

Drive_Cycle_Num = 2; 
[rtpstruct]= rsimgetrtp(mdl);
save HEV_Model_Parameters_02 rtpstruct;

Drive_Cycle_Num = 3; 
[rtpstruct]= rsimgetrtp(mdl);
save HEV_Model_Parameters_03 rtpstruct;

disp('Finished creating parameter data files.')

%% RUN STANDALONE EXECUTABLE
disp(' ');disp('Running RSIM simulations...')
!HEV_SeriesParallel -p HEV_Model_Parameters_01.mat -o results_01.mat -tf 195
!HEV_SeriesParallel -p HEV_Model_Parameters_02.mat -o results_02.mat -tf 400
!HEV_SeriesParallel -p HEV_Model_Parameters_03.mat -o results_03.mat -tf 400
disp('Finished RSIM simulations...')

%% PLOT RESULTS
colordef black
figure
set(gcf,'Position',[551   135   449   548]);
YAxLims= [0 150];

subplot(311)
load results_01.mat; HS_h(1) =plot(rt_Car.time,rt_Car.signals(4).values(:,1),'y'); grid on; set(gca,'YLim',YAxLims);
subplot(312)
load results_02.mat; HS_h(2) =plot(rt_Car.time,rt_Car.signals(4).values(:,1),'m'); grid on; set(gca,'YLim',YAxLims);
subplot(313)
load results_03.mat; HS_h(3) =plot(rt_Car.time,rt_Car.signals(4).values(:,1),'r'); grid on; set(gca,'YLim',YAxLims);
hold off;
set(HS_h,'LineWidth',3);

subplot(311)
title_h = title('Vehicle Speed (kph)');
subplot(313)
xlabel_h = xlabel('Time (s)');
set(title_h,'FontSize',14);
set(xlabel_h,'FontSize',12);
grid on

%axis([0 200 0 120]);
colordef white

%% CLEANUP DIRECTORY
delete HEV_SeriesParallel.exe
delete HEV_Model_Parameters*.mat
delete results*.mat
rtw_dirs = dir('*_rtw');
for i=1:size(rtw_dirs,1)
    rmdir(rtw_dirs(i).name,'s');
    %eval(['!rmdir ' rtw_dirs(i).name '/S /Q'])
end
!rmdir slprj /S/Q
set_param(bdroot,'SystemTargetFile','grt.tlc')
set_param([bdroot '/SLRT Scope'],'Commented','off');
set_param(bdroot,'DefaultParameterBehavior','Tunable');
