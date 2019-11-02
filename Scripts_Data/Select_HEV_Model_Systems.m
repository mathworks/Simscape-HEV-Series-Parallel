function Select_HEV_Model_Systems(HEV_Config_Name,HEV_Configs)
% Copyright 2011-2019 The MathWorks, Inc.

CurrentPath = gcs;
SlashInd = findstr(CurrentPath,'/');
if(~isempty(SlashInd))
    ModelName = CurrentPath(1:SlashInd(1)-1);
else
    ModelName = gcs;
end

HEV_config_index = find(strcmp({HEV_Configs.Type},HEV_Config_Name));

systems_to_set = setdiff(fieldnames(HEV_Configs),{'Type' 'Sim_Time'});

x = getfield(HEV_Configs(HEV_config_index),'Electrical');
if(~strcmp(char(x.choice),'Empty'))
    %set_param(char(x.path),'BlockChoice',char(x.choice));
    set_param(char(x.path),'popup_electricalvariant',char(x.choice));
end

x = getfield(HEV_Configs(HEV_config_index),'Electrical');
b = getfield(HEV_Configs(HEV_config_index),'Battery');
if(~strcmp(char(x.choice),'Empty'))
    %set_param(char(x.path),'BlockChoice',char(x.choice));
    set_param(char(x.path),'popup_batteryvariantsystem',char(b.choice));
    if(~strcmpi(char(b.choice),'cells'))
    set_param(char(x.path),'popup_batteryvariantdetailed',char(b.choice));
    end
end

x = getfield(HEV_Configs(HEV_config_index),'Vehicle');
if(~strcmp(char(x.choice),'Empty'))
    %set_param(char(x.path),'BlockChoice',char(x.choice));
    set_param(char(x.path),'LabelModeActiveChoice',char(x.choice));
end






