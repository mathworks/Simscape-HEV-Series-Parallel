README file for HEV_SeriesParallel demonstration
Steve Miller, updated 2017
Copyright 2011-2017 The MathWorks, Inc.

To start this demonstration, run startup_HEV_Model.m
This will bring you to the simplest configuration of the full vehicle.
Look at the slides to see all of the available configurations.

For R2011a, 
  1. This model has been updated to use the Simscape-based driveline components.
  2. You can adjust the efficiency of the planetary gear
  3. There is a fuel economy calculation, and you can show how we imported data to make this calculation 

There are a number of things to be aware of with this demonstration.
  1. Configurations
  2. Animation
  3. Stateflow
  4. Power Quality


1. Configurations

1.1 For the Mean Value and Detailed electrical variants, re-do the selection 
of the Electrical subsystem if you change the battery subsystem.

When you change Electrical variants, the solver will change.  This is done 
automatically via a script that is called in the Initialization mask of 
the Electrical and Battery blocks (Configure_HEV_Simulation.m).  However, if 
you change the Battery variant, the solver doesn't change until you re-select 
the Electrical variant.

You probably will not simulate this interactively anyway, as Mean Value variants 
take 30 minutes - 3 hours to run, and Detailed variants take 12 hours -- 36 hours 
to run.


1.2 The "Cells" variant of the battery is only available for the System-Level 
electrical variant.


2. Animation

The fancy animation stopped working in R2014b due to changes in how S-
Functions are called.  The original code for the animation was written in 2006.  
If you want this fixed, contact Steve and we'll look into finding 
someone who can get it running again.

3. Stateflow

3.1 Not connected to rest of model by default

The Stateflow model produces three outputs that route to the Motor, Generator, 
and Engine control systems.  However, by default, those signal connections do 
not affect the output of those control systems.  This is because the Mean Value 
variant cannot run to completion for Drive Cycle 2 when the Stateflow diagram 
is connected.  All other variants run to completion.

If you want to connect the Stateflow to the rest of the model, each subsystem 
has a manual switch in it that allows you to select a signal that uses the 
Stateflow output to enable/disable the output of the PI controller.  
However, if you do this, be aware the results will not match the Mean Level 
and Detailed variants (done in the Report Generation demo).  This represents
a case where we have made a design change and have automatically documented the 
effect it has on the overall results.


4. Power Quality

4.1 The power quality demonstration uses Signal Processing Toolbox.  Though 
it is possible to measure power quality using Simscape Power Systems alone, 
there are two reasons why we did not use this.
   
   1. The FFT analysis in the PowerGUI only checks at a single point in time
      We wanted to see a representation as time varies to identify the component
      contributing to poor power quality

   2. The Total Harmonic Distortion block in Simscape Power Systems is only 
      for AC networks. For an HEV, the DC network is the most interesting.
      Spectrogram works for both AC and DC networks.

4.2 DC Voltage for HEV_PQ_Test_B

The plot for HEV_PQ_Test_B shows very clearly that the generator is contributing 
to poor power quality.  However, the voltage on the DC bus for this test shows 
other larger problems -- the battery can't supply enough voltage for this 
situation.  This situation was the best example we could find of the spectrogram 
pointing directly to a component on the network, so we chose to include it.  
Follow the script DC_Power_Quality_Analysis.m to see the test case













