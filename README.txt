README file for HEV_SeriesParallel demonstration
Steve Miller
Copyright 2014 The MathWorks, Inc.

To start this demonstration, run startup_HEV_Model.m
This will bring you to the simplest configuration of the full vehicle.
Test_HEV_Model_SHORT will run through all three drive cycles and bring up a report.


There are a number of things to be aware of with this demonstration.
  1. Configurations
  2. Stateflow
  3. Power Quality


1. Configurations

1.1 For the Mean Value and Detailed electrical variants, re-do the selection of the Electrical subsystem if you change the battery subsystem.

When you change Electrical variants, the solver will change.  This is done automatically via a script 
that is called in the Initialization mask of the Electrical and Battery blocks (Configure_HEV_Simulation.m).  
However, if you change the Battery variant, the solver doesn't change until you re-select the Electrical variant.


1.2 The "Cells" variant of the battery is only available for the System-Level electrical variant.

2. Stateflow

The Stateflow model produces three outputs that route to the Motor, Generator, and Engine control systems.  
However, by default, those signal connections do not affect the output of those control systems.  If you want 
to connect the Stateflow to the rest of the model, each subsystem has a manual switch in it that allows you 
to select a signal that uses the Stateflow output to enable/disable the output of the PI controller.  


3. Power Quality

3.1 The power quality demonstration uses Signal Processing Toolbox.  Though it is possible to measure power quality 
using SimPowerSystems alone, there are two reasons why we did not use this.
   
   1. The FFT analysis in the PowerGUI only checks at a single point in time
      We wanted to see a representation as time varies to identify the component
      contributing to poor power quality

   2. The Total Harmonic Distortion block in SimPowerSystems is only for AC networks.
      For an HEV, the DC network is the most interesting.
      Spectrogram works for both AC and DC networks.












