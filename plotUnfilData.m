%plotUnfilData.m
% close all;
function plotUnfilData(stnName,stnData)
% stnName = "WTZA";
% stnData = stn2KinData;
%plotParam = plotParam + 8;  %translate N,E,U to column number
%figure(1);
if isempty(stnData)
    disp("No data received. Ending process!");
    return;
end

[~,r2,r3] = size(stnData);
tempData = nan(1,r2);               %init a 2D matrix to store data to be plotted
%legendInfo = strings(r3,1);

for ii=1:r3
    tempData = vertcat(tempData,stnData(:,:,ii));
         
    %legendInfo(ii) = strcat("Session #",num2str(ii));
end

%tempData = tempData(sum(isnan(tempData),2)==0);
t = (datetime(tempData(:,12),'convertfrom','modifiedjuliandate'));   %Sidereal-filtering shifted datetime stored in t

figure('Name',strcat("Unshifted data for stn ",stnName),'NumberTitle','off')

subplot(2,2,1);
grid on; hold on;
plot (t,tempData(:,9).');                                  
legend('North','Location','NorthEast')
xlabel('Epoch'), ylabel('Offsets (m)')
title(strcat("Offsets for ",stnName," (North)"));
hold off;

subplot(2,2,2);
grid on; hold on;
plot (t,tempData(:,10).');                                 
legend('East','Location','NorthEast')
xlabel('Epoch'), ylabel('Offsets(m)')
title(strcat("Offsets for ",stnName," (East)"));
hold off;

subplot(2,2,3);
grid on; hold on;
plot (t,tempData(:,11).');                                  
legend('Up','Location','NorthEast')
xlabel('Epoch'), ylabel('Offsets(m)')
title(strcat("Offsets for ",stnName," (Up)"));
hold off;

subplot(2,2,4);
grid on; hold on;
plot (t,tempData(:,9:11).');                                  
legend('North','East','Up','Location','NorthEast')
xlabel('Epoch'), ylabel('Offsets (m)')
title(strcat("Offsets for ",stnName));
hold off;

end
