%% Hybrid Electric Vehicle with Series-Parallel Architecture
% 
% This example models a hybrid electric vehicle with a series-parallel
% architecture.  The fidelity level of the electrical system, including the
% generator, motor, and battery can be configured.
% 
% Copyright 2025 The MathWorks, Inc.

%% Model

open_system('HEV_SeriesParallel')
HEV_SeriesParallel_config_electrical('HEV_SeriesParallel','System')
set_param(find_system('HEV_SeriesParallel','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures'),'Interpreter','off')

%% Electrical System

set_param('HEV_SeriesParallel/Electrical','LinkStatus','none')
open_system('HEV_SeriesParallel/Electrical','force')

%% Vehicle System

set_param('HEV_SeriesParallel/Vehicle','LinkStatus','none')
open_system('HEV_SeriesParallel/Vehicle','force')

%% Simulation Results from Simscape Logging, Drive Cycle 1
%
% The plot below shows the wheel speeds during the maneuver.  
Drive_Cycle_Num = 1;
sim('HEV_SeriesParallel')
HEV_SeriesParallel_plot1speeds

%% Simulation Results from Simscape Logging, Drive Cycle 2
%
% The plot below shows the wheel speeds during the maneuver.  
Drive_Cycle_Num = 2;
sim('HEV_SeriesParallel')
HEV_SeriesParallel_plot1speeds

%% Simulation Results from Simscape Logging, Drive Cycle 3
%
% The plot below shows the wheel speeds during the maneuver.  
Drive_Cycle_Num = 3;
sim('HEV_SeriesParallel')
HEV_SeriesParallel_plot1speeds

%% Simulation Results from Simscape Logging, Drive Cycle 4
%
% The plot below shows the wheel speeds during the maneuver.  
Drive_Cycle_Num = 4;
sim('HEV_SeriesParallel')
HEV_SeriesParallel_plot1speeds

%% Simulation Results from Simscape Logging, Drive Cycle 5
%
% The plot below shows the wheel speeds during the maneuver.  
Drive_Cycle_Num = 5;
sim('HEV_SeriesParallel')
HEV_SeriesParallel_plot1speeds

%% Simulation Results from Simscape Logging, Drive Cycle 6
%
% The plot below shows the wheel speeds during the maneuver.  
Drive_Cycle_Num = 6;
sim('HEV_SeriesParallel')
HEV_SeriesParallel_plot1speeds

%% Simulation Results from Simscape Logging, Drive Cycle 6, Detailed Electrical System
%
% The plot below shows the wheel speeds during the maneuver.  
Drive_Cycle_Num = 6;

HEV_SeriesParallel_config_electrical('HEV_SeriesParallel','Detailed')
sim('HEV_SeriesParallel')
HEV_SeriesParallel_plot1speeds
HEV_SeriesParallel_plot2torqueDetailed

%%

%clear all
close all
bdclose all
