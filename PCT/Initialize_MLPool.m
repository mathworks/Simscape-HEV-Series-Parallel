% Copyright 2011 The MathWorks, Inc.

parfor i = 1:2
    out{i} = sim(mdl, SimSettings{i});
end
