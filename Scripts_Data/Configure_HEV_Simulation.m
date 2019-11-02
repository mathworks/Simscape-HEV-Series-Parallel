% Copyright 2011-2014 The MathWorks, Inc.

%disp('CONFIGURING MODEL...');
HEV_Solver_Selection = 'ode15s';
%evalin('base',['disp([''Mode Logic TS = '' num2str(HEV_Param.Control.Mode_Logic_TS)])']);

%disp('Checking blocks...');
expModel = bdroot;
HEV_Model_DLevel_blk = [expModel '/Electrical'];
DetailLevel = get_param(HEV_Model_DLevel_blk,'BlockChoice');

set_param(HEV_Model_DLevel_blk,'BlockChoice',DetailLevel);

HEV_Model_BattModel_blk = find_system(bdroot,'FollowLinks','on','LookUnderMasks','on','SearchDepth','3','Name','Battery');
BattModel = get_param(HEV_Model_BattModel_blk,'BlockChoice');


%if ~isequal(get_param(SimulinkModel,'BlockChoice'),DetailLevel)
%    set_param(SimulinkModel,'BlockChoice',DetailLevel);
%end

%disp('Adjusting Settings...');

if (strcmp(DetailLevel,'Mean Value') || strcmp(DetailLevel,'Mean Value1'))
    decimation = 500;
%    decimation = 5;
    assignin('base','Ts',60e-6)
    assignin('base','decimation',decimation)
    if (strcmp(BattModel,'Predefined'))
        set_param(expModel,'Solver',HEV_Solver_Selection,'MaxStep','1e-3')
        %set_param(expModel,'Solver','ode23tb','MaxStep','1e-3')
    else
        set_param(expModel,'Solver',HEV_Solver_Selection,'MaxStep','1e-3')
    end
    set_param([expModel,'/powergui'],'SimulationMode','Discrete');
elseif (strcmp(DetailLevel,'Detailed')  || strcmp(DetailLevel,'Detailed1'))
    decimation = 5000;
%    decimation = 50;  % FOR POWER QUALITY
%    decimation = 1;  % FOR PLOTS
    assignin('base','Ts',2e-6)
    assignin('base','decimation',decimation)
    if (strcmp(BattModel,'Predefined'))
        set_param(expModel,'Solver',HEV_Solver_Selection,'MaxStep','1e-3')
        %set_param(expModel,'Solver','ode23tb','MaxStep','1e-3')
    else
        set_param(expModel,'Solver',HEV_Solver_Selection,'MaxStep','1e-3')
    end
    set_param([expModel,'/powergui'],'SimulationMode','Discrete');
elseif (strcmp(DetailLevel,'Simplified'))
    decimation = 2;
    assignin('base','Ts',[])
    assignin('base','decimation',decimation)
    if (strcmp(BattModel,'Predefined'))
        set_param(expModel,'Solver',HEV_Solver_Selection,'MaxStep','auto')
        %set_param(expModel,'Solver','ode23tb','MaxStep','auto')
    else
        set_param(expModel,'Solver',HEV_Solver_Selection,'MaxStep','1e-3')
    end
    set_param([expModel,'/powergui'],'SimulationMode','Continuous');
elseif strcmp(DetailLevel,'System Level')
    decimation = 2;
    assignin('base','Ts',[])
    assignin('base','decimation',decimation)
    set_param(expModel,'Solver',HEV_Solver_Selection,'MaxStep','auto')
    set_param([expModel,'/powergui'],'SimulationMode','Continuous');
end

%disp('FINISH MODEL CONFIGURATION');
%evalin('base',['disp([''Mode Logic TS = '' num2str(HEV_Param.Control.Mode_Logic_TS)])']);
