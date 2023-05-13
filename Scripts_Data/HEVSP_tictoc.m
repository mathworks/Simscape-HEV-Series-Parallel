function HEVSP_tictoc(enable)
% Copyright 2011-2023 The MathWorks, Inc.

if(strcmpi(enable,'on'))
    set_param(bdroot,'StartFcn','tic;');
    set_param(bdroot,'StopFcn','Elapsed_Sim_Time = toc; disp([''Elapsed time for '' bdroot '' = '' num2str(Elapsed_Sim_Time)])');
else    
    set_param(bdroot,'StartFcn','');
    set_param(bdroot,'StopFcn','');
end