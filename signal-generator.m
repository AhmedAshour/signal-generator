disp("##################################");
disp("######## Signal Generator ########");
disp("##################################");

%Sampling Frequency
fs = input("Enter sampling frequecny: ");

% Start time 
startTime = input("Enter start time: ");

% End time 
endTime = input("Enter end time: "); 

% Break points
breakPtsNums = input("Enter number of break points: "); 
breakPts = [];
for i = 1:breakPtsNums
  breakPts(i) = input(["Enter position for break point " num2str(i) " : "]);   
endfor

%----------- Signal Formation --------------

regionStartTime = startTime;
% signal that will be concatenated
for i = 1:breakPtsNums
  region = strcat(int2str(regionStartTime), " : ", int2str(breakPts(i)))
  regionStartTime += breakPts(i)
  signalType = menu(strcat("Choose signal type for region ", region), "DC Signal", "Ramp Signal", 
  "General Order Polynomial Signal", "Exponential Signal", "Sinusoidal Signal");
   switch (signalType)
     case "DC Signal"
     case "Ramp Signal"
     case "General Order Polynomial Signal"
     case "Exponential Signal"
     case "Sinusoidal Signal"
     otherwise
   endswitch
endfor


% Plot signal

%----------- Signal Operations --------------

signalOperation = menu(strcat("Do you want to make an operation on the signal?", "Amplitude Scaling", "Time Reversal", 
  "Time Shift", "Expanding the signal", "Compressing the signal", "None");
switch (signalOperation)
  case "Amplitude Scaling"
  case "Time Reversal"
  case "Time Shift"
  case "Expanding the signal"
  case "Compressing the signal"
  otherwise
endswitch

%Plot the new signal



