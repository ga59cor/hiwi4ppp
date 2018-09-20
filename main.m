clc; clear all; close all;


parentdir       = '/Users/voyager/Desktop/hiwi4ppp/temp_KIN/';
%cd(parentdir);

%GNSS Stns (antennae) whose data is to be processed.
stnNames = ["WTCO";"WTZA";"WTZS";"WTZZ"];



prompt = 'First session:';          %First day of 2018 to be processed
startSess = input(prompt);
if isempty(startSess)
    startSess = 100;
end
  

prompt = 'Final Session:';          %Last day of 2018 to be processed
finSess = input(prompt);        
if isempty(finSess)
    prompt = 'Number of sessions:'; %Ask for Number of sessions if no last day given
    numSess = input(prompt);        
    if isempty(numSess)
        numSess = 2;                %Number of sessions = 2 if no value given
    end
    finSess = startSess + numSess -1;
end

numSess = finSess - startSess +1;   %TODO do we need this in this code?
 
tic
%Kin soln data will be stored here. Dimension: (720 epochs, 14 columns, numSess) 
stn1KinData = storeData(parentdir,startSess,finSess,stnNames(1));   %WTCO
stn2KinData = storeData(parentdir,startSess,finSess,stnNames(2));   %WTZA
stn3KinData = storeData(parentdir,startSess,finSess,stnNames(3));   %WTZS
stn4KinData = storeData(parentdir,startSess,finSess,stnNames(4));   %WTZZ

toc 


%% Plot data


%Plot data without shifting

% plotUnfilData('WTCO',stn1KinData);   %WTCO
% plotUnfilData('WTZA',stn2KinData);   %WTZA
% plotUnfilData('WTZS',stn3KinData);   %WTZS
% plotUnfilData('WTZZ',stn4KinData);   %WTZZ


%Sidereal-filtered data (shifted by 4min per day)
%plotParam - Define what to plot:1 for N-Nbar, 2 for E-Ebar, 3 for U-Ubar

plotData('WTCO',stn1KinData,2);   %WTCO 
% plotData('WTZA',stn2KinData,2);   %WTZA
% plotData('WTZS',stn2KinData,2);   %WTZS
% plotData('WTZZ',stn2KinData,2);   %WTZZ

