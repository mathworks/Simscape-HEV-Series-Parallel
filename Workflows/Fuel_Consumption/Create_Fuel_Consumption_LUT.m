%% ESTIMATE FUEL CONSUMPTION WITH MEASURED DATA
% Copyright 2011-2020 The MathWorks, Inc.
% CONSTANTS
gasoline_density_gpm3 = 750*1000; % Grams per cubic meter
gallons_per_m3 = 264.172;         % gallons per cubic meter

%% IMPORT EXPERIMENTAL DATA
%  http://www.transportation.anl.gov/pdfs/HV/2.pdf
FC_Measured_Data = xlsread('Fuel_Consumption_DATA.xlsx');
FCData.Speed_RPM = FC_Measured_Data(1:(end-1),1);
FCData.Trq_Nm = FC_Measured_Data(1:(end-1),2);
FCData.FuelUse_gps = FC_Measured_Data(1:(end-1),3)/gallons_per_m3*gasoline_density_gpm3;
Fuel_Consumption_PlotData

%% OPEN SURFACE FITTING TOOL
cftool(FCData.Speed_RPM, FCData.Trq_Nm, FCData.FuelUse_gps)

% Polynomial, x=2, y=2
% Fit/Save to Workspace
% sftool('FC_SFit_Session.sfit') % Saved Session

%% GENERATE LOOKUP TABLE
load FCMap_Poly2
numpts = 10;
FCMap.Speed_Vector = linspace(min(FCData.Speed_RPM),max(FCData.Speed_RPM),numpts); 
FCMap.Torque_Vector = linspace(min(FCData.Trq_Nm),max(FCData.Trq_Nm),numpts); 
[SpeedArray,TorqueArray] = meshgrid(FCMap.Speed_Vector,FCMap.Torque_Vector);
FCMap.Consumption_Table = FCMap_Poly2(SpeedArray,TorqueArray);

% PLOT LOOKUP TABLE AS SURFACE
surf(SpeedArray,TorqueArray,FCMap.Consumption_Table);


