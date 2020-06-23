% Copyright 2011-2020 The MathWorks, Inc.

% SELECT SIMULATION RESULTS TO BE COMPARED
VarSetStr = 'DSM';
BattStr = 'P';
VehStr = 'S';
DCycle = '1';
EffInd = '1';

% REST OF FILE SHOULD NOT CHANGE
EffVariants = {'Ideal' 'Lossy'};
ModelVariants = {'System Level' 'Mean Value' 'Detailed'};
BattVariants = {'Predefined' 'Generic'};
VehVariants = {'Simple' 'Full'};

BattInd = find(char(BattVariants) == BattStr);
VehInd = find(char(VehVariants) == VehStr);

for i=1:length(VarSetStr)
    MV_ind = find(char(ModelVariants) == VarSetStr(i));
    MV_str = char(ModelVariants(MV_ind));
    MV_name = strrep(MV_str,' ','_');
   
    FileName = [MV_name '_DATA_UC' DCycle '_Veh' num2str(VehInd) '_Batt' num2str(BattInd)]; 
    %FileName = [MV_name '_DATA_UC' DCycle '_Veh' num2str(VehInd) '_Batt' num2str(BattInd) '_' EffVariants{str2num(EffInd)}]; 
    
    disp(FileName)
    eval(['load ' FileName]);
end

plot_HEV_Data(1,[3 1 1],'Car',4,1,'Vehicle Speed (kph)',VarSetStr);
plot_HEV_Data(1,[3 1 2],'Motor',2,1,'Motor Speed (RPM)',VarSetStr);
plot_HEV_Data(1,[3 1 3],'Generator',2,1,'Generator Speed (RPM)',VarSetStr);
sub_h(1) = subplot(3,1,1); ylabel('Speed (kph)');
sub_h(2) = subplot(3,1,2); ylabel('Speed (RPM)');
sub_h(3) = subplot(3,1,3); xlabel('Time (s)'); ylabel('Speed (RPM)');
linkaxes(sub_h,'x'); clear sub_h


plot_HEV_Data(2,[2 1 1],'Electrical',2,2,'Battery Voltage',VarSetStr);
plot_HEV_Data(2,[2 1 2],'Electrical',2,1,'DC Bus Voltage',VarSetStr);
sub_h(1) = subplot(2,1,1); ylabel('Voltage (V)');
sub_h(2) = subplot(2,1,2); ylabel('Voltage (V)'); xlabel('Time (s)'); 
linkaxes(sub_h,'x'); clear sub_h

plot_HEV_Data(3,[2 1 1],'Electrical',3,2,'Battery Current',VarSetStr);
plot_HEV_Data(3,[2 1 2],'Electrical',3,3,'Generator Current',VarSetStr);
sub_h(1) = subplot(2,1,1); ylabel('Current (A)');
sub_h(2) = subplot(2,1,2); ylabel('Current (A)'); xlabel('Time (s)'); 
linkaxes(sub_h,'x'); clear sub_h

plot_HEV_Data(4,[3 1 1],'Electrical',3,2,'Battery Current',VarSetStr);
plot_HEV_Data(4,[3 1 2],'Electrical',3,3,'Generator Current',VarSetStr);
plot_HEV_Data(4,[3 1 3],'Electrical',3,1,'Motor Current',VarSetStr);
sub_h(1) = subplot(3,1,1); ylabel('Current (A)');
sub_h(2) = subplot(3,1,2); ylabel('Current (A)');
sub_h(3) = subplot(3,1,3); ylabel('Current (A)'); xlabel('Time (s)'); 
linkaxes(sub_h,'x'); clear sub_h

plot_HEV_Data(5,[2 1 1],'Generator',3,1,'Generator Torque',VarSetStr);
plot_HEV_Data(5,[2 1 2],'Motor',3,1,'Motor Torque',VarSetStr);
sub_h(1) = subplot(2,1,1); ylabel('Torque (Nm)');
sub_h(2) = subplot(2,1,2); ylabel('Torque (Nm)'); xlabel('Time (s)'); 
linkaxes(sub_h,'x'); clear sub_h

%{
plot_HEV_Data(6,[2 1 1],'Electrical',2,2,'Battery Voltage',VarSetStr);
plot_HEV_Data(6,[2 1 2],'Electrical',3,1,'Motor Current',VarSetStr);

plot_HEV_Data(7,[2 1 1],'Control_Logic',1,1,'ICE Enable, SF',VarSetStr);
plot_HEV_Data(7,[2 1 2],'Control_Logic',1,2,'ICE Enable, SL',VarSetStr);

plot_HEV_Data(8,[2 1 1],'Control_Logic',2,1,'Motor Enable, SF',VarSetStr);
plot_HEV_Data(8,[2 1 2],'Motor',3,1,'Motor Torque',VarSetStr);

plot_HEV_Data(9,[2 1 1],'Control_Logic',3,1,'Generator Enable, SF',VarSetStr);
plot_HEV_Data(9,[2 1 2],'Generator',3,1,'Generator Torque',VarSetStr);

plot_HEV_Data(10,[2 1 1],'Electrical',3,2,'Battery Current',VarSetStr);
plot_HEV_Data(10,[2 1 2],'Motor',1,1,'Stator Current',VarSetStr);
plot_HEV_Data(10,[2 1 2],'Electrical',3,1,'Motor Current',VarSetStr);
%}

