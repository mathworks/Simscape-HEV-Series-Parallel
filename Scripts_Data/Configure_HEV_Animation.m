% IF ANIMATION IS TURNED ON, SLOW DOWN THE SIMULATION
% ELSE LET IT RUN AT FULL SPEED
% SPEED IS CONTROLLED BY SETTING SAMPLE TIME OF STATEFLOW CHART
% Copyright 2011-2014 The MathWorks, Inc.

expModel = bdroot;
HEV_Model_Animation_blk = [expModel '/Animation'];
AnimationOnOff = get_param(HEV_Model_Animation_blk,'BlockChoice');

if (strcmp(AnimationOnOff,'On'))
    evalin('base','HEV_Param.Control.Mode_Logic_TS = 0.005;');
else
    evalin('base','HEV_Param.Control.Mode_Logic_TS = 0.1;');
end
