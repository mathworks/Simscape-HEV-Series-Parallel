function Select_HEV_Model_Systems(modelname,HEV_Config_Name,HEV_Configs)
% Copyright 2011-2020 The MathWorks, Inc.

% Find block with mask parameters to set variants
f = Simulink.FindOptions('SearchDepth',1,'regexp',true);
elec_sys = getfullname(Simulink.findBlocks(modelname,'popup_electricalvariant','.*',f));
vehi_sys = [modelname '/Vehicle Dynamics'];

% Extract configuration
HEV_config_index = find(strcmp({HEV_Configs.Type},HEV_Config_Name));

elec_config = HEV_Configs(HEV_config_index).Electrical.choice;
batt_config = HEV_Configs(HEV_config_index).Battery.choice;
vehi_config = HEV_Configs(HEV_config_index).Vehicle.choice;

if(~strcmp(elec_config,'Empty'))
    set_param(elec_sys,'popup_electricalvariant',elec_config);
    set_param(elec_sys,'popup_batteryvariantsystem',batt_config);
    if(~strcmpi(batt_config,'cells'))
    set_param(elec_sys,'popup_batteryvariantdetailed',batt_config);
    end
end

if(~strcmp(vehi_config,'Empty'))
    set_param(vehi_sys,'LabelModeActiveChoice',vehi_config);
end






