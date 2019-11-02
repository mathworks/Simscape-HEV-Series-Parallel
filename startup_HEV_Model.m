% Copyright 2011-2019 The MathWorks, Inc.

HEV_Model_HomeDir = pwd;
addpath(pwd);
addpath([pwd filesep 'Libraries' filesep 'Electrical']);
addpath([pwd filesep 'Libraries' filesep 'Battery']);
addpath([pwd filesep 'Libraries' filesep 'Vehicle']);
%addpath([pwd filesep 'Libraries' filesep 'Animation']);
addpath([pwd filesep 'Images']);
addpath([pwd filesep 'Scripts_Data']);
addpath([pwd filesep 'Reports']);
addpath([pwd filesep 'Power_Quality']);
addpath(genpath([pwd filesep 'SimResults']));

HEV_Model_PARAM

% FOR VARIABLE INERTIA (PCT TESTS)
if(exist(['Libraries' filesep 'Vehicle'])==7)
    cd(['Libraries' filesep 'Vehicle'])
    if((exist('+TunableMech')==7) && ~exist('TunableMech_lib'))
        disp('Building Custom Simscape Library...');
        ssc_build TunableMech
        disp('Finished Building Library.');
    end
    cd(HEV_Model_HomeDir)
end

open('HEV_Model_Demo_Script.html')
HEV_SeriesParallel





