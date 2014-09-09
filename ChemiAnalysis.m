clear
clc
%Created by Allen Morris 022014
%read in the reactivity excel file formated properly
%date = input('Please input Date in format 1mmddyy:\n')
%filename = num2str(date)
ChemiFile = xlsread('1021914');
ChemiFile(isnan(ChemiFile)) = 0;
%Arrays of all of the isotherms - In the future think about how to make
%these more general
Array1 = ChemiFile(2:17,1:12);
Array2 = ChemiFile(19:34,1:12);
Array3 = ChemiFile(36:51,1:12);
Array4 = ChemiFile(53:68,1:12);
Array5 = ChemiFile(70:85,1:12);
Array6 = ChemiFile(87:102,1:12);
%3D matrix of all the temperature isotherms for different samples
ChemiMatrix = cat(3,Array1,Array2,Array3,Array4,Array5,Array6);
numCol = size(ChemiMatrix);
Index = numCol(2);
numArray = numCol(3);
%for loops which loop over the number of arrays in the 3rd dimension as
%well as the various temperatures in those arrays.
%loop over colors?
for i=1:numArray
    Q1{i} = ChemiMatrix(16,2,i);
    Q2{i} = ChemiMatrix(16,12,i);
end
Q1 = cell2mat(Q1);
Q2 = cell2mat(Q2);
Qmax = Q1; %Maximum adsorption - Used for Calculating Coverage
%Diff = cellfun(@minus,Q1,Q2,'Un',0) %CellArray Subtraction
Diff = Q1-Q2;
for i=1:length(Q1)
    Range{i} = Q2(i):Diff(i)/5:Q1(i); %Range of adsorptions that can be found in the data
end
Range = cell2mat(Range);

%!!!From here on out its only for one data set right now!!!
for i=1:2:Index
    TempRange(i) = ChemiMatrix(1,i,1);
end
TempRange(TempRange==0) = [];
Range1 = Range(1:6)
Coverage = Range1./Qmax


% % for i=1:2:Index
% %     legendInfo{i} = [num2str(ChemiMatrix(1,i,1))];
% % end
% %     legendInfo(cellfun(@isempty,legendInfo)) = [];
% % for i=1:2:Index
% %     plot(ChemiMatrix(2:16,i,1),ChemiMatrix(2:16,i+1,1),'-o','color',rand(1,3))
% %     hold on
% % end    
% % title('Isotherms')
% % xlabel('Pressure, Torr')
% % %axis([0 100 -0.1 1.2])
% % ylabel('Quantity Adsorbed (cm3/g)')
% % set(gca,'XScale','log')
% % legend(legendInfo,'Location','NorthWest')
% % hold off

%Plot of all isotherms for different samples at 308K; figure num+1

%Calculate the Heats of Adsorption using the CC equation, Somehow need to
%check for linearty (See latusek dissertation)
