tvar_Nonlinear_Iterations = '3';
tvar_StepSize = '0.005';
Select_HEV_Model_Systems('Sys BC VS',HEV_Configs);
tvar_LocalSolver = 'NE_BACKWARD_EULER_ADVANCER';

% Do not run script that autoconfigures solver settings based on variants
set_param(bdroot,'InitFcn','%Configure_HEV_Simulation');

HEV_Param.Control.Mode_Logic_TS = str2num(tvar_StepSize);

set_param(bdroot,'Solver','ode1','FixedStep','auto');
tvar_solverBlock = find_system(bdroot,'FollowLinks','on','LookUnderMasks','on', 'SubClassName', 'solver');
for i=1:size(tvar_solverBlock,1)
    set_param(char(tvar_solverBlock(i)), 'UseLocalSolver','on','DoFixedCost','on','MaxNonlinIter',tvar_Nonlinear_Iterations,'LocalSolverChoice',tvar_LocalSolver,'LocalSolverSampleTime',tvar_StepSize);
end
clear tvar_Nonlinear_Iterations tvar_StepSize tvar_LocalSolver tvar_solverBlock