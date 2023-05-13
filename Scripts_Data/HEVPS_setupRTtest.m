% Copyright 2014-2023 The MathWorks(TM), Inc.
Select_HEV_Model_Systems(mdl,'Sys BC VS',HEV_Configs);
set_param([mdl '/Vehicle Dynamics/Simple'],'LinkStatus','inactive')
HEV_Vehicle_Mass = 1600;
set_param([mdl '/Vehicle Dynamics/Simple'],'mass','HEV_Vehicle_Mass');
set_param(mdl,'StopTime','30');
Drive_Cycle_Num = 1;

% Choose target
cs = getActiveConfigSet(bdroot);
cs.switchTarget('slrealtime.tlc',[]);
%   Side effect of target selection
set_param(mdl,'SaveFormat','Array'); 

set_param(mdl,'SimscapeLogType','None');
