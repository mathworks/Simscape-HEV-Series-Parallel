% Copyright 2011 The MathWorks, Inc.

sc_h = find_system(bdroot,'FollowLinks','on','LookUnderMasks','on','Grid','on');

for i=1:length(sc_h)
    
%    if (strcmp(get_param(sc_h(i),'SaveToWorkspace'),'on'))
        disp(['Block ' num2str(i) ': ' char(get_param(sc_h(i),'SaveName')) ', ' char(get_param(sc_h(i),'Decimation'))]);
%    else
%        disp(['Block ' num2str(i)]);
%    end
%    set_param(sc_h(i),'Decimation',{'decimation'})
%    set_param(sc_h(i),'Decimation',100)
    
end
