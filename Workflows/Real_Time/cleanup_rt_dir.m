% CLEANUP RT TEST DIR
% Copyright 2011-2020 The MathWorks, Inc.

mdl = 'HEV_SeriesParallel';
delete([mdl '*bio.m'])
delete([mdl '*pt.m'])
delete([mdl '*ref.m'])
delete([mdl '*.dlm'])
delete([mdl '*.xml'])
rtw_dirs = dir('*_rtw');
for i=1:size(rtw_dirs,1)
    rmdir(rtw_dirs(i).name,'s');
    %eval(['!rmdir ' rtw_dirs(i).name '/S /Q'])
end
bdclose all
delete('*.mex*')

