% Copyright 2011-2023 The MathWorks, Inc.

set_param(bdroot,'Solver','ODE15s');
HEV_Param.Control.Mode_Logic_TS = 0.1;

set_param(bdroot,'InitFcn','Configure_HEV_Simulation');

f    = Simulink.FindOptions('FollowLinks',0,'LookUnderMasks','none');
tvar_solverBlock = Simulink.findBlocks(bdroot, 'SubClassName', 'solver',f);

for i=1:size(tvar_solverBlock,1)
    set_param(tvar_solverBlock(i), 'UseLocalSolver','off','DoFixedCost','off');
end

clear tvar_solverBlock