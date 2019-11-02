% Copyright 2011-2015 The MathWorks, Inc.

% SELECT SIMULATION RESULTS TO BE COMPARED
VarSetStr = 'SM';
BattStr = 'P';
VehStr = 'S';
DCycle = '2';
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
   
    FileName = [MV_name '_DATA_UC' DCycle '_Veh' num2str(VehInd) '_Batt' num2str(BattInd)}]; 
    %FileName = [MV_name '_DATA_UC' DCycle '_Veh' num2str(VehInd) '_Batt' num2str(BattInd) '_' EffVariants{str2num(EffInd)}]; 
    
    disp(FileName)
    eval(['load ' FileName]);
end

plot_HEV_Data(1,[3 1 1],'Car',4,1,'Vehicle Speed (kph)',VarSetStr);
plot_HEV_Data(1,[3 1 2],'Motor',2,1,'Motor Speed (RPM)',VarSetStr);
plot_HEV_Data(1,[3 1 3],'Generator',2,1,'Generator Speed (RPM)',VarSetStr);

plot_HEV_Data(2,[2 1 1],'Electrical',2,2,'Battery Voltage',VarSetStr);
plot_HEV_Data(2,[2 1 2],'Electrical',2,1,'DC Bus Voltage',VarSetStr);

plot_HEV_Data(3,[2 1 1],'Electrical',3,2,'Battery Current',VarSetStr);
plot_HEV_Data(3,[2 1 2],'Electrical',3,3,'Generator Current',VarSetStr);
plot_HEV_Data(3,[3 1 1],'Electrical',3,2,'Battery Current',VarSetStr);
plot_HEV_Data(3,[3 1 2],'Electrical',3,3,'Generator Current',VarSetStr);
plot_HEV_Data(3,[3 1 3],'Electrical',3,1,'Motor Current',VarSetStr);

plot_HEV_Data(4,[2 1 1],'Generator',3,1,'Generator Torque',VarSetStr);
plot_HEV_Data(4,[2 1 2],'Motor',3,1,'Motor Torque',VarSetStr);

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

