%% CONSTANTS
% Copyright 2011-2020 The MathWorks, Inc.

FigurePos1 = [450   499   574   186];
FigurePos2 = [449    69   574   372];
FigurePos3 = [449   475   574   217];
FigurePos4 = [5   476   437   215];
PurpleColor = [102 0 204]/256;
GenColor = [200 102 100]/256;
SampleTime = (2e-6)*50;

%% LOAD DATA TEST A
load HEV_PQ_Test_A

%% PLOT DC VOLTAGE
figure(1);
plot(Time,DC_V,'Color',[102 0 204]/256);
title('DC Bus Voltage','FontSize',16,'FontWeight','Bold');
xlabel('Time','FontSize',12,'FontWeight','bold')
ylabel('Voltage (V)','FontSize',12,'FontWeight','Bold')
set(gcf,'Position',FigurePos1);
set(gca,'YLim',[400 600]);

%% PLOT SPECTROGRAM
figure(2);
spectrogram(DC_V,1024,512,1024,1/(Time(2)-Time(1)),'yaxis');
%spectrogram(DC_V,256,240,256,1/(SampleTime),'yaxis');
title('Spectrogram, DC Bus','FontSize',16,'FontWeight','Bold')
xlabel('Time','FontSize',12,'FontWeight','bold')
ylabel('Frequency (Hz)','FontSize',12,'FontWeight','Bold')
set(gcf,'Position',FigurePos2);

%% TEST B
close(1);close(2);
load HEV_PQ_Test_B

%% PLOT SPECTROGRAM
figure(3);
spectrogram(DC_V,1024,512,1024,1/(Time(2)-Time(1)),'yaxis');
title('Spectrogram, DC Bus','FontSize',16,'FontWeight','Bold')
xlabel('Time','FontSize',12,'FontWeight','bold')
ylabel('Frequency (Hz)','FontSize',12,'FontWeight','Bold')
set(gcf,'Position',FigurePos2);
%set(gca,'YLim',[0 1200]);
%view(0,90)


%% PLOT GENERATOR SPEED
figure(4);
plot(Time,Gen_Spd,'LineWidth',3,'Color',GenColor);
title('Generator Speed (RPM)','FontSize',16,'FontWeight','Bold');
xlabel('Time','FontSize',12,'FontWeight','bold')
ylabel('Speed (RPM)','FontSize',12,'FontWeight','Bold')
set(gcf,'Position',FigurePos3);

%% PLOT MOTOR SPEED
figure(5);
plot(Time,Mot_Spd,'LineWidth',3);
title('Motor Speed (RPM)','FontSize',16,'FontWeight','Bold');
xlabel('Time','FontSize',12,'FontWeight','bold')
ylabel('Speed (RPM)','FontSize',12,'FontWeight','Bold')
set(gcf,'Position',FigurePos4);
set(gca,'YLim',[0 450]);

%% CLOSE ALL
close all
