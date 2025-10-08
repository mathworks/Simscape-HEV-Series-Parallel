function HEV_SeriesParallel_config_electrical(mdl,elecType)
if(strcmp(elecType,'Detailed'))
    set_param([mdl '/Electrical'],'popup_machModelType','Detailed');
    set_param([mdl '/Electrical/Solver Configuration'],'UseLocalSolver','on','DoFixedCost','on');
    set_param(mdl,'SolverType','Fixed-step','SolverName','ode1');
else
    set_param([mdl '/Electrical'],'popup_machModelType','System');
    set_param([mdl '/Electrical/Solver Configuration'],'UseLocalSolver','off','DoFixedCost','off');
    set_param(mdl,'SolverType','Variable-step','SolverName','ode23t');
end