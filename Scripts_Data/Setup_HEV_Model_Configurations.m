% Copyright 2011-2020 The MathWorks, Inc.

expModel = bdroot;

electrical_path = char(find_system(expModel,'Name','Electrical'));
vehicle_path = char(find_system(expModel,'Name','Vehicle Dynamics'));

HEV_Electrical_Variants = {'Mean Value' 'System Level' 'Detailed'};


HEV_Configs_TBL_COLS =  {'Type'         'ELECTRICAL'        'BATTERY'        'VEHICLE'      'SIM TIME'};
HEV_Configs_TABLE{1} =  {'Sys BD VS'    'System Level'      'Predefined'     'Simple'       10}; % 15
HEV_Configs_TABLE{2} =  {'Sys BC VS'    'System Level'      'Generic'        'Simple'       10}; % 15
HEV_Configs_TABLE{3} =  {'Sys BD VF'    'System Level'      'Predefined'     'Full'         10}; % 15
HEV_Configs_TABLE{4} =  {'Sys BC VF'    'System Level'      'Generic'        'Full'         10}; % 15
HEV_Configs_TABLE{5} =  {'Mvl BD VS'    'Mean Value'        'Predefined'     'Simple'       10}; % 15
HEV_Configs_TABLE{6} =  {'Mvl BC VS'    'Mean Value'        'Generic'        'Simple'       10}; % 15
HEV_Configs_TABLE{7} =  {'Mvl BD VF'    'Mean Value'        'Predefined'     'Full'         10}; % 15
HEV_Configs_TABLE{8} =  {'Mvl BC VF'    'Mean Value'        'Generic'        'Full'         10}; % 15
HEV_Configs_TABLE{9} =  {'Det BD VS'    'Detailed'          'Predefined'     'Simple'       10}; % 15
HEV_Configs_TABLE{10} = {'Det BC VS'    'Detailed'          'Generic'        'Simple'       10}; % 15
HEV_Configs_TABLE{11} = {'Det BD VF'    'Detailed'          'Predefined'     'Full'         10}; % 15
HEV_Configs_TABLE{12} = {'Det BC VF'    'Detailed'          'Generic'        'Full'         10}; % 15


for i=1:length(HEV_Configs_TABLE)
    HEV_Configs(i).Type = HEV_Configs_TABLE{i}{1};
    HEV_Configs(i).Electrical.choice = HEV_Configs_TABLE{i}{2};
    HEV_Configs(i).Battery.choice = HEV_Configs_TABLE{i}{3};
    HEV_Configs(i).Vehicle.choice = HEV_Configs_TABLE{i}{4};
    HEV_Configs(i).Sim_Time = HEV_Configs_TABLE{i}{5};
end

for i=1:length(HEV_Configs)
    HEV_Configs(i).Electrical.path = {electrical_path};
    HEV_Configs(i).Battery.path = {[electrical_path '/' char(HEV_Configs(i).Electrical.choice) '/Battery']};
    HEV_Configs(i).Vehicle.path = {vehicle_path};
end
