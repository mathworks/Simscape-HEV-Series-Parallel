% Copyright 2011-2020 The MathWorks, Inc.

HEV_Model_HomeDir = pwd;

HEV_Model_PARAM

open_start_content = 1;

% If running in a parallel pool
% do not open model or demo script
if(~isempty(ver('parallel')))
    if(~isempty(getCurrentTask()))
        open_start_content = 0;
    end
end

if(open_start_content)
    open('HEV_Model_Demo_Script.html')
    HEV_SeriesParallel
end




