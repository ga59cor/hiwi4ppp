function stnKinData = storeData(parentdir,startSess,finSess,stnName)

numSess = finSess - startSess +1;   %Number of sessions
stnKinData = nan(600,12,numSess);   %Setup a sufficiently large 3D array for storing data

%%Sidereal filtering for multipath error mitigation
fourMinShift = 0.0028;              %MJD shift for sidereal filtering

ii=1;                               %Counter for session


for k = startSess:finSess
	% Create a kin filename, and load it into a structure called kinData.
	kinFileName = sprintf('%s18%d0.kin', stnName, k);
    kinFileName = strcat(parentdir,kinFileName);
	if exist(kinFileName, 'file')
        kinData         = load(kinFileName);            %Load data of kth session
        columnMeans     = mean(kinData,1);              %Mean of each column
        kinData(:,6)    = columnMeans(2);               %Mean of N component is stored in 6th column
        kinData(:,7)    = columnMeans(3);               %Mean of E component is stored in 7th column
        kinData(:,8)    = columnMeans(4);               %Mean of U component is stored in 8th column
        
        kinData(:,9)    = kinData(:,2) - kinData(:,6);  %N component minus N mean
        kinData(:,10)   = kinData(:,3) - kinData(:,7);  %E component minus E mean
        kinData(:,11)   = kinData(:,4) - kinData(:,8);  %U component minus U mean
        
        
        %Sidereal shifting: each successive day's epoch is shifted 4 min
        %bakward. The shifted epochs are saved in the 13th col
%         kinData(:,12)   = kinData(:,1) - (ii-1)*fourMinShift;
%         
%         [n,~]           = size(kinData);
%         stnKinData(1:n,:,ii)    = kinData;                 %Store successive iith session's kin data
%         
%         ii = ii+ 1; 
        kinData(:,12)   = (kinData(:,1)-fix(kinData(:,1))) - (ii-1)*fourMinShift;
        [n,~]           = size(kinData);
        for i=1:n
            if kinData(i,12) < 0
                kinData(i,12) = nan;
            end
        end
        kinData(:,12)   = fix(kinData(:,1))+kinData(:,12);
        stnKinData(1:n,:,ii)    = kinData;                 %Store successive iith session's kin data
        
        ii = ii+ 1; 
	else
		fprintf('File %s does not exist.\n', kinFileName);
	end
end



end