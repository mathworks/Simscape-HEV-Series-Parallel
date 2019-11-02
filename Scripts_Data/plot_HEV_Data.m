function plot_HEV_Data(FigID,SubPlID,DataStr,SigID,ValID,titlestr,PlotChoice)
% Copyright 2011 The MathWorks, Inc.

SP_style = 'b';
SY_style = 'r--';
MV_style = 'g-.';
DT_style = 'm:';
PlotLineWidth = 2;

figure(FigID)
subplot(SubPlID(1),SubPlID(2),SubPlID(3));

for pc_ind = 1:length(PlotChoice)
    if PlotChoice(pc_ind) == 'D'
        legendstrings{pc_ind} = 'Detailed';
        DT_Time = evalin('base', ['Detailed.' DataStr '.time']);
        DT_Data = evalin('base', ['Detailed.' DataStr '.signals(' num2str(SigID) ').values(:,' num2str(ValID) ');']);
        DT_maxind = length(DT_Time);
        plot(DT_Time(1:DT_maxind),DT_Data(1:DT_maxind),DT_style,'LineWidth',PlotLineWidth);
    elseif PlotChoice(pc_ind) == 'S'
        legendstrings{pc_ind} = 'System Level';
        SY_Time = evalin('base', ['System_Level.' DataStr '.time']);
        SY_Data = evalin('base', ['System_Level.' DataStr '.signals(' num2str(SigID) ').values(:,' num2str(ValID) ');']);
        SY_maxind = length(SY_Time);
        plot(SY_Time(1:SY_maxind),SY_Data(1:SY_maxind),SY_style,'LineWidth',PlotLineWidth);
   elseif PlotChoice(pc_ind) == 'M'
        legendstrings{pc_ind} = 'Mean Value';
        MV_Time = evalin('base', ['Mean_Value.' DataStr '.time']);
        MV_Data = evalin('base', ['Mean_Value.' DataStr '.signals(' num2str(SigID) ').values(:,' num2str(ValID) ');']);
        MV_maxind = length(MV_Time);
        plot(MV_Time(1:MV_maxind),MV_Data(1:MV_maxind),MV_style,'LineWidth',PlotLineWidth);
    else
        legendstrings{pc_ind} = 'Simplified';
        SP_Time = evalin('base', ['Simplified.' DataStr '.time']);
        SP_Data = evalin('base', ['Simplified.' DataStr '.signals(' num2str(SigID) ').values(:,' num2str(ValID) ');']);
        SP_maxind = length(SP_Time);
        plot(SP_Time(1:SP_maxind),SP_Data(1:SP_maxind),SP_style,'LineWidth',PlotLineWidth);
    end
    hold on
end

hold off
title(titlestr);
legend(legendstrings);

end
