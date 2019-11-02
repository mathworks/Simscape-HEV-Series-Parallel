% Copyright 2011-2014 The MathWorks, Inc.

expModel = bdroot;
error = {};
testfail = {};

SaveFolderRoot = [pwd '\SimResults_12a'];

EffVariants = {'Ideal' 'Lossy'};
ModelVariants = {'System Level' 'Mean Value' 'Detailed'};
BattVariants = {'Predefined' 'Generic'};% 'Cells'};
VehVariants = {'Simple' 'Full'};

% SimDuration = [max(UrbanCycle1.time) max(UrbanCycle2.time) max(UrbanCycle3.time) max(UrbanCycle4.time) max(UrbanCycle5.time)];
%SimDuration = [50 50 50];
% SimDuration = [0.01 0.01 0.01 0.01 0.01];
SimDuration = [2 2 2 2 2];

% FOR POWER QUALITY TESTS
%SimDuration = [10 10 10];
% SimDuration = [13 13 13];
% SimDuration = [0.01 0.01 0.01];

for EFF_ind = 1:length(EffVariants)
    PlanGear_h = find_system(bdroot,'Name','Planetary Gear');
    set_param(char(PlanGear_h),'friction_model',num2str(EFF_ind))
    for MV_ind = 3%:length(ModelVariants)
        
        MV_str = char(ModelVariants(MV_ind));
        MV_name = strrep(MV_str,' ','_');
        
        for DC_ind=1:3
            
            for Veh_ind = 1:length(VehVariants)
                Veh_str = char(VehVariants(Veh_ind));
                Veh_name = strrep(Veh_str,' ','_');
                set_param([expModel '/Vehicle Dynamics'],'BlockChoice',Veh_str);
                
                for Batt_ind = 1:length(BattVariants)
                    Batt_str = char(BattVariants(Batt_ind));
                    Batt_name = strrep(Batt_str,' ','_');
                    
                    set_param(expModel,'StopTime',num2str(SimDuration(DC_ind)));
                    Drive_Cycle_Num = DC_ind;
                    set_param([expModel '/Electrical'],'BlockChoice',MV_str);
                    set_param([expModel '/Electrical/' MV_str '/Battery'],'BlockChoice',Batt_str);
                    set_param([expModel '/Electrical'],'BlockChoice',MV_str);
                    
                    disp(['Simulating UC' num2str(DC_ind) ', ' get_param([expModel '/Electrical'],'BlockChoice') ', '...
                        get_param([expModel '/Vehicle Dynamics'],'BlockChoice') ' Vehicle, ',...
                        get_param([expModel '/Electrical/' MV_str '/Battery'],'BlockChoice') ' Battery, ' EffVariants{EFF_ind} ' Gear Model'] );
                    try
                        tic
                        sim(expModel);
                        toc
                    catch err
                        error{end+1} = err;
                        testfail{end + 1} = ['Simulating UC' num2str(DC_ind) ', ' get_param([expModel '/Electrical'],'BlockChoice') ', '...
                        get_param([expModel '/Vehicle Dynamics'],'BlockChoice') ' Vehicle, ',...
                        get_param([expModel '/Electrical/' MV_str '/Battery'],'BlockChoice') ' Battery, ' EffVariants{EFF_ind} ' Gear Model'];
                    end
                        
%                     disp(['Fuel Used: ' num2str(FuelUsedLiters) ' Liters']);
%                     disp(' ');
                    
%                     eval([MV_name '.Electrical = Electricals;']);
%                     eval([MV_name '.Car = Car;']);
%                     eval([MV_name '.Generator = Generator;']);
%                     eval([MV_name '.Motor = Motor;']);
%                     eval([MV_name '.Control_Logic = Control_Logic;']);
%                     eval([MV_name '.DCDC_Conv = DCDC_Temp;']);
%                     eval([MV_name '.Elapsed_Sim_Time = Elapsed_Sim_Time;']);
%                     eval([MV_name '.Fuel_Used_Liters = FuelUsedLiters;']);
%                     
%                     SaveFolder = [SaveFolderRoot '\UC' num2str(DC_ind) '\' MV_name];
%                     %                                       _DATA_AC FOR ACCEL CYCLE
%                     SaveFileName = [SaveFolder '\' MV_name '_DATA_UC' num2str(DC_ind) '_Veh' num2str(Veh_ind) '_Batt' num2str(Batt_ind)];
%                     %SaveFileName = [SaveFolder '\' MV_name '_DATA_UC' num2str(DC_ind) '_Veh' num2str(Veh_ind) '_Batt' num2str(Batt_ind) '_'  EffVariants{EFF_ind}];
%                     
%                     %disp(['save ' SaveFileName ' ' MV_name]);
%                     %eval(['save ' SaveFileName ' ' MV_name]);
% 
%                     eval(['clear ' MV_name ' Electricals Car Generator Motor Control_Logic']);
                end
            end
        end
    end
end
