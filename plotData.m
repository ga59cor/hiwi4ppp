function plotData(stnName,stnData,plotParam)
% stnName = "WTZA";
% stnData = stn1KinData;
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
figure('Name',strcat("Sidereal-shifted data for stn ",stnName),'NumberTitle','off')
grid on; hold on;
[r1,~,r3] = size(stnData);
legendInfo = strings(r3,1);

for ii=1:r3
    t = (datetime(stnData(1:r1,12,ii),'convertfrom','modifiedjuliandate'))';   %Sidereal-filtering shifted datetime stored in t
    plot (timeofday(t),stnData(:,plotParam,ii).');                                  %Extract time of day from t     
    legendInfo(ii) = strcat("Session #",num2str(ii));
end

legend(legendInfo,'Location','NorthEast')
xlabel('Epoch'), ylabel('Offsets')
title(strcat(plotParamName," Offsets for ",stnName));
hold off;

end
