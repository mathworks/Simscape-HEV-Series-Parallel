set_param(bdroot,'Solver','ODE15s');
HEV_Param.Control.Mode_Logic_TS = 0.1;

set_param(bdroot,'InitFcn','Configure_HEV_Simulation');

tvar_solverBlock = find_system(bdroot,'FollowLinks','on','LookUnderMasks','on', 'SubClassName', 'solver');
for i=1:size(tvar_solverBlock,1)
    set_param(char(tvar_solverBlock(i)), 'UseLocalSolver','off','DoFixedCost','off');
end

clear tvar_solverBlock