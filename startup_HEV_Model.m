% Copyright 2011 The MathWorks, Inc.

HEV_Model_HomeDir = pwd;
addpath(pwd);
addpath([pwd '/Libraries/Electrical']);
addpath([pwd '/Libraries/Battery']);
addpath([pwd '/Libraries/Vehicle']);
addpath([pwd '/Images']);
addpath([pwd '/Scripts_Data']);
addpath([pwd '/Reports']);
addpath([pwd '/Power_Quality']);
addpath(genpath([pwd '/SimResults']));

HEV_Model_PARAM

% FOR VARIABLE INERTIA (PCT TESTS)
if(exist('Libraries\Vehicle')==7)
    cd Libraries\Vehicle
    if((exist('+TunableMech')==7) && ~exist('TunableMech_lib'))
        disp('Building Custom Simscape Library...');
        ssc_build TunableMech
        disp('Finished Building Library.');
    end
    cd(HEV_Model_HomeDir)
end

open('HEV_Model_Demo_Script.html')
HEV_SeriesParallel





