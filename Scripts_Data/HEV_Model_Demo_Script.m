%% HEV Model Demo Script
%
% <html>
% <span style="font-family:Arial">
% <span style="font-size:10pt">
% <tr><b><u>Model</u></b><br>
% <tr>1.  <a href="matlab:open_system('HEV_SeriesParallel');">Open HEV Model</a><br>
% <tr>2.  <a href="matlab:Test_HEV_Model_SHORT;">Run Drive Cycles</a><br>
% <tr>3.  <a href="matlab:cd(fileparts(which('Create_Fuel_Consumption_LUT.m')));edit Create_Fuel_Consumption_LUT;">Estimate Fuel Economy With Measured Data</a><br>
% <br>
% <tr><b><u>Simulate</u></b><br>
% <tr>4. <a href="matlab:cd(fileparts(which('HEV_Model_PCT_Sim.m')));edit HEV_Model_PCT_Sim;HEV_SeriesParallel;">Distribute Simulations Using Parallel Computing</a><br>
% <tr>5.  Test and Analyze <a href="matlab:open('HEV_MODEL_TestManager.mldatx');">Test Case Management</a><br>
% <tr>6.  Document: <a href="matlab:open('HEV_Model_Report_SHORT.html');">View Report</a>, <a href="matlab:cd(fileparts(which('HEV_Model_Report_SHORT.rpt')));open('HEV_Model_Report_SHORT.rpt');">Generate Report</a><br>
% <tr>7.  Power Quality Plots: <a href="matlab:edit DC_Power_Quality_Analysis;">Create Plots</a><br>
% <br>
% <tr><b><u>Deploy</u></b><br>
% <tr>8. <a href="matlab:cd(fileparts(which('Test_RT_Model.m')));edit Test_RT_Model">Deploy to Real-Time Hardware for HIL Testing</a><br>
% <tr>9. <a href="matlab:cd(fileparts(which('HEV_Model_RSIM.m')));edit HEV_Model_RSIM">Deploy Simulation As a Standalone Executable</a><br>
% </style>
% </style>
% </html>
% 
% Copyright 2011-2020 The MathWorks(TM), Inc.


