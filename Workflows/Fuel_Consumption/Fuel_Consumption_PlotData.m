% Copyright 2011-2020 The MathWorks, Inc.

hndl = plot3(FCData.Speed_RPM, FCData.Trq_Nm, FCData.FuelUse_gps,'o','MarkerFaceColor','blue','MarkerEdgeColor','white');
grid on
box on
xlabel('Engine Speed RPM','FontSize',12,'FontWeight','Bold')
ylabel('Engine Torque (Nm)','FontSize',12,'FontWeight','Bold')
zlabel('Fuel Rate (gram/sec)','FontSize',12,'FontWeight','Bold')
title('Fuel Consumption, Measured Data','FontSize',14,'FontWeight','Bold')
set(gca,'XLim',[1200 4100]);
set(gca,'YLim',[30 99]);
set(gca,'ZLim',[0.25 2.75]);
hold on
