% Copyright 2011-2020 The MathWorks, Inc.

%disp('DEFINING PARAMETERS...');
% HEV SERIES PARALLEL PARAMETERS

% PREDEFINED LI-ION BATTERY PARAMS
HEV_Param.Battery_Det.Nominal_Voltage = 200;
HEV_Param.Battery_Det.Rated_Capacity = 8.1;      % Ampere-hours
HEV_Param.Battery_Det.Initial_SOC = 75.75;       % Percent
HEV_Param.Battery_Det.Series_Resistance = 0.2/10;   % Ohm


% FOR ACCEL TEST
%HEV_Param.Battery_Det.Initial_SOC = 97;         % Percent

% GENERIC BATTERY PARAMS
HEV_Param.Battery_Sys.Nominal_Voltage = 217;
HEV_Param.Battery_Sys.Internal_Resistance = 0.24691;% Ohm
HEV_Param.Battery_Sys.Rated_Capacity = 6.9;     % Ampere-hours
HEV_Param.Battery_Sys.Initial_Charge = 6.9;    % Ampere-hours
HEV_Param.Battery_Sys.Expn_Voltage = 215.0342;       % V
HEV_Param.Battery_Sys.Expn_Charge = 2.3438;

HEV_Param.Battery_Sys.C1.Capacitance = 2500;
HEV_Param.Battery_Sys.C1.Initial_Voltage = 19;
HEV_Param.Battery_Sys.C1.Series_Resistance = 1e-6;
HEV_Param.Battery_Sys.R2 = 0.3;
HEV_Param.Battery_Sys.R1 = 1.8;
HEV_Param.Battery_Sys.Maximum_Capacity = HEV_Param.Battery_Sys.Rated_Capacity;    % Ampere-hours


% ULTRACAPACITOR PARAMETERS
HEV_Param.UltraCapacitor.Nominal_Capacitance = 1000; % Farad
HEV_Param.UltraCapacitor.Rate_C_V = 0.2;          % Farad/Volt
HEV_Param.UltraCapacitor.Series_R = 30/3;            % Ohm
HEV_Param.UltraCapacitor.Self_Discharge_R = 500;  % Ohm
HEV_Param.UltraCapacitor.Initial_Voltage = 217;     % Volt


% MOTOR PARAMETERS
HEV_Param.Motor.Stator_Resistance = 0.0065*14;        % Ampere-hours
HEV_Param.Motor.Stator_Resistance = 0.0065*14;
HEV_Param.Motor.TorqSpdLUT.SpeedRPM = [0   1200 2000 3000 4000 5000 6000  6500 10000];
HEV_Param.Motor.TorqSpdLUT.TorqueNm = [400 400  225  150  100  80   70    0    0];
HEV_Param.Motor.Damping = 1e-5; %N*m/(rad/s)
HEV_Param.Motor.TorqueControl_TimeConst = 0.02*2/1.5;
HEV_Param.Motor.Shaft_Inertia = 0.2;
HEV_Param.Motor.Series_Resistance = 0.01; %CHG
HEV_Param.Motor.Inductances = [0.001597972349731   0.002057052250467];
HEV_Param.Motor.Efficiency = 91;


% GENERATOR PARAMETERS
HEV_Param.Generator.Stator_Resistance = 0.05*0.095;
HEV_Param.Generator.Inductances = [0.000635 0.000635];
HEV_Param.Generator.TorqSpdLUT.SpeedRPM = [ 0 1200 2000 3000 4000 10000 15000];
HEV_Param.Generator.TorqSpdLUT.TorqueNm = [400 400 250 150 110 0 0];
HEV_Param.Generator.Damping = 1e-5; %N*m/(rad/s)
HEV_Param.Generator.TorqueControl_TimeConst = 0.02*2;
HEV_Param.Generator.Shaft_Inertia = 0.2;
HEV_Param.Generator.Series_Resistance = 0.01; %CHG

% -- trq indep losses adds compliance -- 10W
HEV_Param.Generator.TorqIndep_Elec_Loss = 0; %W

% CHG -- ADDED COMPLIANCE
HEV_Param.Generator.Shaft_Stiffness = 1e3; %W
HEV_Param.Generator.Shaft_Damping = 1e2; %W

% DC-DC CONVERTER PARAMETERS
HEV_Param.DCDCConv.Output_Voltage = 500;      % Volts
HEV_Param.DCDCConv.Resistance_Losses = 1000/40^2;      % Ohm
HEV_Param.DCDCConv.Kp = 0.01;
HEV_Param.DCDCConv.Ki = 10;
HEV_Param.DCDCConv.MinVin = 20;

HEV_Param.DCDCConv.Mean_Boost.Kp = 0.001;
HEV_Param.DCDCConv.Mean_Boost.Ki = 1;

HEV_Param.DCDCConv.EPower2Heat = 0.1;      % Watts/Watts
HEV_Param.DCDCConv.Thermal_Mass = 0.1*10;    % kg
HEV_Param.DCDCConv.Specific_Heat = 100;   % J/kg/K
HEV_Param.DCDCConv.Initial_Temperature = 25;     % C
HEV_Param.DCDCConv.Air_Temperature = 298;     % K
HEV_Param.DCDCConv.Convection.Area = 20;     % cm^2
HEV_Param.DCDCConv.Convection.HT_Coefficient = 100; % W/(m^2*K)


% CONTROLLER PARAMETERS
HEV_Param.Control.Engine_Start_RPM = 800; % RPM
HEV_Param.Control.Engine_Stop_RPM = 790; % RPM
HEV_Param.Control.Mode_Logic_TS = 0.1;
HEV_Param.Control.ICE.Kp = 0.02;
HEV_Param.Control.ICE.Ki = 0.01;
HEV_Param.Control.Gen.Kp = 10;
HEV_Param.Control.Gen.Ki = 3;
HEV_Param.Control.Mot.Kp = 500;
HEV_Param.Control.Mot.Ki = 300;
HEV_Param.Control.Veh_Spd.Kp = 0.02;
HEV_Param.Control.Veh_Spd.Ki = 0.04;


% VEHICLE PARAMETERS
HEV_Param.Vehicle.Mass = 600*2;         % kg
HEV_Param.Vehicle.Tire_Radius = 0.3;    % m
HEV_Param.Vehicle.Wheel_Inertia = 0.1;  % kg*m^2
HEV_Param.Vehicle.Aero_Drag_Coeff = 0.26;
HEV_Param.Vehicle.Incline = 0;
HEV_Param.Vehicle.Engine_Vehicle_Gear_Ratio = 1.3;
HEV_Param.Vehicle.Distance_CG_FrontAxle = 1.35;
HEV_Param.Vehicle.Distance_CG_RearAxle = 1.35;
HEV_Param.Vehicle.Distance_CG_Ground = 0.5;
HEV_Param.Vehicle.Frontal_Area = 2.16;
HEV_Param.Vehicle.Tire.Rated_Vertical_Load = 3000;  % N
HEV_Param.Vehicle.Tire.Rated_Peak_Long_Force = 3500;  % N
HEV_Param.Vehicle.Tire.Slip_At_Peak_Force = 6;  % Percent
%HEV_Param.Vehicle.Tire.Relaxation_Length = 0.2*0.09;  % Percent
%HEV_Param.Vehicle.Tire.Relaxation_Length = 0.2;
HEV_Param.Vehicle.Tire.Relaxation_Length = 0.25;
HEV_Param.Vehicle.Trans.Inertia = 0.5;
HEV_Param.Vehicle.Trans.Friction = 0.1*0.001;


% POWER SPLIT DEVICE PARAMETERS
HEV_Param.Power_Split.Ratio_Ring2Sun = 2.6;


% INTERNAL COMBUSTION ENGINE (ICE) PARAMETERS
HEV_Param.ICE.Shaft_Inertia = 0.25;
HEV_Param.ICE.Max_Power = 57000+57000;      % W
HEV_Param.ICE.Speed_At_Max_Power = 5000;    % RPM
HEV_Param.ICE.Max_Speed = 6000;             % RPM
HEV_Param.ICE.Friction = 0.2079;           % N*m*s/rad

HEV_Param.ICE.sensor_time_constant = 0.005; %0.001

load FuelConsMap
HEV_Param.ICE.FC.Speed_Vector = FCMap.Speed_Vector;
HEV_Param.ICE.FC.Torque_Vector = FCMap.Torque_Vector;
HEV_Param.ICE.FC.Consumption_Table = FCMap.Consumption_Table;
clear FCMap



% Battery Model Parameters - 50Ah
HEV_Param.Battery_Cell.NominalCap = 50; %(Ah)
    
% Battery Block Initial Conditions
% Initial State of Charge (% of full charge)
% Initial Electrolyte Temperature (°C, typically same as ambient temp)
HEV_Param.Battery_Cell.SOC_init = 0.8;
HEV_Param.Battery_Cell.theta_init = 25;
    
% Battery Block Thermal Parameters
HEV_Param.Battery_Cell.Ctheta = 400; %(J/°C) Thermal Capacitance
HEV_Param.Battery_Cell.Area = 0.01; % (m^2) Surface area of battery exposed to air
HEV_Param.Battery_Cell.Rtheta = 20;  %(W/m^2/K) Convective heat transfer coefficient
    
% Battery Block Capacity Parameters
% Charge/discharge cycles at ranges of current/temp
HEV_Param.Battery_Cell.Kc = 1.2; %()
HEV_Param.Battery_Cell.Costar = 1.8e+005; %(As)
HEV_Param.Battery_Cell.Kt_Temps = [25 40 60 75]; % Temperature breakpoints for Kt LUT
HEV_Param.Battery_Cell.Kt = [0.80,1.10,1.20,1.12;]; %() LUT output values
HEV_Param.Battery_Cell.delta = 0.73; %()
HEV_Param.Battery_Cell.Istar = 15; %(A) Nominal Current (=cap/disch_t)
HEV_Param.Battery_Cell.theta_f = -40; %(°C) Electrolyte Freezing Temp
    
% Battery Block Parasitic Branch Parameters
% End of charge cycle at ranges of current/temp
HEV_Param.Battery_Cell.Ep = 1.95; %(V) Parasitic emf
HEV_Param.Battery_Cell.Gpo = 2.0e-011; %(s)
HEV_Param.Battery_Cell.Vpo = 0.12; %(V)
HEV_Param.Battery_Cell.Ap = 2.0; %()
HEV_Param.Battery_Cell.Taup = 3; % (s)
    
% Battery Block Main Branch Parameters
HEV_Param.Battery_Cell.Emo = 2.18*10; % (V) [max o.c. volts per cell]
HEV_Param.Battery_Cell.Ke = 0.0006; %(V/°C)
HEV_Param.Battery_Cell.Ao = -0.6; % ()
HEV_Param.Battery_Cell.Roo = 0.0042; % (Ohm)
HEV_Param.Battery_Cell.R10 = 0.0010; %(Ohm)
HEV_Param.Battery_Cell.A21 = -10.0; %()
HEV_Param.Battery_Cell.A22 = -8.75; %()
HEV_Param.Battery_Cell.R20 = 0.11; %(Ohm)
HEV_Param.Battery_Cell.Tau1 = 100; %(s)
    
% Battery Block Number Of Cells Parameters
HEV_Param.Battery_Cell.ns = 6; %() Number of cells in series in each parallel branch
    
% Compute initial extracted charge
HEV_Param.Battery_Cell.Qe_init = (1-HEV_Param.Battery_Cell.SOC_init)*HEV_Param.Battery_Cell.Kc*HEV_Param.Battery_Cell.Costar*interp1([HEV_Param.Battery_Cell.theta_f HEV_Param.Battery_Cell.Kt_Temps],[0 HEV_Param.Battery_Cell.Kt],HEV_Param.Battery_Cell.theta_init,'spline');

