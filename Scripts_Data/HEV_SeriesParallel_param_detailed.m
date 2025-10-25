%% Parameters for Series-Parallel HEV Example

% This example shows a simplified series-parallel hybrid electric vehicle
% (HEV). An interior permanent magnet synchronous machine (IPMSM) and an
% internal combustion engine (ICE) provide the vehicle propulsion. The ICE
% also uses electric generator to recharge the high-voltage battery
% during driving. The vehicle transmission and differential are implemented
% using a fixed-ratio gear-reduction model. The Vehicle Controller
% subsystem converts the driver inputs into torque commands. The vehicle
% control strategy is implemented as a Stateflow(R) state machine. The ICE
% Controller subsystem controls the torque of the combustion engine. The
% Generator Controller subsystem controls the torque of the electric
% generator. The Drive Controller subsystem controls the torque of the IPMSM.
% The Scopes subsystem contains scopes that allow you to see the simulation
% results.

% Copyright 2017-2025 The MathWorks, Inc.

%% Electric Drive Parameters
PmaxEM = 35000;      % Maximum power                   [W]
TmaxEM = 205;        % Maximum torque                  [N*m]
Ld     = 0.00024368; % Stator d-axis inductance        [H]
Lq     = 0.00029758; % Stator q-axis inductance        [H]
L0     = 0.00012184; % Stator zero-sequence inductance [H]
Rs     = 0.010087;   % Stator resistance per phase     [Ohm]
psim   = 0.04366*2;    % Permanent magnet flux linkage   [Wb]
p      = 8;          % Number of pole pairs
Cdc    = 0.001;      % DC-link capacitor               [F]
Vnom   = 325/2;        % Nominal voltage                 [V]

%% Battery Parameters
Q    = 20000;       % Battery capacity                     [W*hr]
Vbat = 250;         % Nominal voltage                      [V]
Ri   = 0.001;       % Internal resistance                  [Ohm]
AH   = Q/Vbat;      % Ampere-hour rating                   [hr*A]
V1   = 200;         % Voltage V1 < Vnom when charge is AH1 [V]
AH1  = AH/2;        % Charge AH1 when no-load volts are V1 [hr*A]
SOC0 = 0.7;         % Initial State of Charge              [%]
AH0  = SOC0*AH;     % Initial charge                       [hr*A]

%% ICE Parameters
TmaxICE = 400;    % Maximum torque                  [N*m]
PmaxICE = 160000; % Maximum power                   [W]
Km      = 3000;   % Gain for ICE model
Tm      = 0.1;    % Time constant for ICE model     [s]
 
%% Control Parameters
Ts   = 1e-5;        % Fundamental sample time                      [s]
fsw  = 10e3;        % PMSM drive switching frequency               [Hz]
Tsi  = 1e-4;        % Sample time for current control loops        [s]
Tsd  = 1e-3;        % Sample time for DCDC current control loop    [s]
Tso  = 1e-3;        % Sample time for generator outer control loop [s]

Kp_id = 0.8779;     % Proportional gain id controller
Ki_id = 710.3004;   % Integrator gain id controller
Kp_iq = 1.0744;     % Proportional gain iq controller
Ki_iq = 1.0615e+03; % Integrator gain iq controller

Kp_omega = 1.5;     % Proportional gain velocity controller
Ki_omega = 100;     % Integrator gain velocity controller

Kp_ice = 0.01;      % Proportional gain ice controller
Ki_ice = 0.1;      % Integrator gain ice controller

%% Zero-Cancellation Transfer Functions
numd_id = Tsi/(Kp_id/Ki_id);
dend_id = [1 (Tsi-(Kp_id/Ki_id))/(Kp_id/Ki_id)];
numd_iq = Tsi/(Kp_iq/Ki_iq);
dend_iq = [1 (Tsi-(Kp_iq/Ki_iq))/(Kp_iq/Ki_iq)];

numd_omega = Tso/(Kp_omega/Ki_omega);
dend_omega = [1 (Tso-(Kp_omega/Ki_omega))/(Kp_omega/Ki_omega)];

%% Current References
load HEV_SeriesParallel_35kWCurrentRef;

%% Vehicle Parameters
Mv    = 1000;   % Vehicle mass                   [kg]
g     = 9.8;    % Gravitational acceleration     [m/s^2]
rho_a = 1.225;  % Air density                    [kg/m^3]
AL    = 5;      % Max vehicle cross section area [m^2]
Cd    = 0.25;   % Air drag coefficient           [N*s^2/kg*m]
cr1   = 0.01;   % Rolling coefficient            
cr2   = 0.02;   % Rolling coefficient                      
Rw    = 0.28;   % Wheel radius                   [m]
ratio = 2;      % Ring to sun teeth ratio
i_t   = 5;      % Final gear ratio 
