function plot3dData(stnName,stnData,plotParam,sidFiltParam)
% close all;
% stnName = "WTZA";
% stnData = stn2KinData;
% plotParam = 2;
if isempty(stnData)
    disp("No data received. Ending process!");
    return;
end
plotParam = plotParam + 8;  %translate N,E,U to column number

switch plotParam
    case 9
        plotParamName = "North";
    case 10
        plotParamName = "East";
    case 11
        plotParamName = "Up";
    otherwise
        disp("Null")
        plotParamName = "Null";
  
end

%figure(1);
figure('Name',strcat("Std. dev. data for stn ",stnName),'NumberTitle','off')
grid on; hold on;
[r1,~,r3] = size(stnData);

switch sidFiltParam
    case 'y'
        for ii = 1: r3
            t = (datetime(stnData(1:r1,12,ii),'convertfrom','modifiedjuliandate'))';   %Sidereal-filtering shifted datetime stored in t
            plot3 (timeofday(t),(datetime(fix(stnData(1:r1,12,ii)),'convertfrom','modifiedjuliandate'))',stnData(:,plotParam,ii));
        end
        view (3)
        
    case 'n'
        for ii = 1: r3
            t = (datetime(stnData(1:r1,1,ii),'convertfrom','modifiedjuliandate'))';   %No sidereal filtering
            plot3 (timeofday(t),(datetime(fix(stnData(1:r1,12,ii)),'convertfrom','modifiedjuliandate'))',stnData(:,plotParam,ii));
        end
        view (3)
        
    otherwise
        disp("Received no input. Defaulting to Y!");
        sidFiltParam = 'y';
        for ii = 1: r3
            t = (datetime(stnData(1:r1,1,ii),'convertfrom','modifiedjuliandate'))';   %Sidereal-filtering shifted datetime stored in t
            plot3 (timeofday(t),(datetime(fix(stnData(1:r1,12,ii)),'convertfrom','modifiedjuliandate'))',stnData(:,plotParam,ii));
        end
        view (3)
        
end
%legend(legendInfo,'Location','NorthEast')
xlabel('Epochs'), ylabel('Session'), zlabel('Offsets')
title(strcat(plotParamName," Offsets for ",stnName,". Sidereal shifting: ",sidFiltParam));
hold off;

end
