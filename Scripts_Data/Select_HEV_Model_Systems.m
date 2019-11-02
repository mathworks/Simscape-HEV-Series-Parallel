function Select_HEV_Model_Systems(HEV_Config_Name,HEV_Configs)
% Copyright 2011-2014 The MathWorks, Inc.

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
  set_param(char(x.path),'BlockChoice',char(x.choice));
end

for i=1:length(systems_to_set)
    x = getfield(HEV_Configs(HEV_config_index),char(systems_to_set(i)));
    if(~strcmp(char(x.choice),'Empty'))
        set_param(char(x.path),'BlockChoice',char(x.choice));
    end
end

%set_param(ModelName,'StopTime',num2str(HEV_Configs(HEV_config_index).Sim_Time));





