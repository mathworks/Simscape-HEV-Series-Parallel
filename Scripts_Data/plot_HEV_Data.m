function plot_HEV_Data(FigID,SubPlID,DataStr,SigID,ValID,titlestr,PlotChoice)
% Copyright 2011-2020 The MathWorks, Inc.

figure(FigID)
temp_colororder = get(gca,'defaultAxesColorOrder');

SP_color = temp_colororder(1,:);
SP_style = '-';

SY_color = temp_colororder(1,:);
SY_style = '-';

MV_color = temp_colororder(2,:); 
MV_style = '-';

DT_color = temp_colororder(3,:); 
DT_style = '-';
PlotLineWidth = 0.5;


subplot(SubPlID(1),SubPlID(2),SubPlID(3));
%subplot(3,1,1)
for pc_ind = 1:length(PlotChoice)
    if PlotChoice(pc_ind) == 'D'
        legendstrings{pc_ind} = 'Detailed';
        DT_Time = evalin('base', ['Detailed.' DataStr '.time']);
        DT_Data = evalin('base', ['Detailed.' DataStr '.signals(' num2str(SigID) ').values(:,' num2str(ValID) ');']);
        DT_maxind = length(DT_Time);
        plot(DT_Time(1:DT_maxind),DT_Data(1:DT_maxind),...
            'LineStyle',DT_style,'Color',DT_color,'LineWidth',4);%PlotLineWidth);
    elseif PlotChoice(pc_ind) == 'S'
        legendstrings{pc_ind} = 'System Level';
        SY_Time = evalin('base', ['System_Level.' DataStr '.time']);
        SY_Data = evalin('base', ['System_Level.' DataStr '.signals(' num2str(SigID) ').values(:,' num2str(ValID) ');']);
        SY_maxind = length(SY_Time);
        plot(SY_Time(1:SY_maxind),SY_Data(1:SY_maxind),...
            'LineStyle',SY_style,'Color',SY_color,'LineWidth',3)%PlotLineWidth);
   elseif PlotChoice(pc_ind) == 'M'
        legendstrings{pc_ind} = 'Mean Value';
        MV_Time = evalin('base', ['Mean_Value.' DataStr '.time']);
        MV_Data = evalin('base', ['Mean_Value.' DataStr '.signals(' num2str(SigID) ').values(:,' num2str(ValID) ');']);
        MV_maxind = length(MV_Time);
        plot(MV_Time(1:MV_maxind),MV_Data(1:MV_maxind),...
            'LineStyle',MV_style,'Color',MV_color,'LineWidth',1);%,PlotLineWidth);
    else
        legendstrings{pc_ind} = 'Simplified';
        SP_Time = evalin('base', ['Simplified.' DataStr '.time']);
        SP_Data = evalin('base', ['Simplified.' DataStr '.signals(' num2str(SigID) ').values(:,' num2str(ValID) ');']);
        SP_maxind = length(SP_Time);
        plot(SP_Time(1:SP_maxind),SP_Data(1:SP_maxind),...
            'LineStyle',SP_style,'Color',SP_color,SP_style,'LineWidth',PlotLineWidth);
    end
    hold on
end

hold off
title(titlestr);
legend(legendstrings);
grid on

end
