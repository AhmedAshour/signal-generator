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
breakPts(breakPtsNums+1)= endTime;
%----------- Signal Formation --------------

regionStartTime = startTime;
tOP = [];
yOP = [];
for i = 1:breakPtsNums+1
  region = strcat(int2str(regionStartTime), " : ", int2str(breakPts(i)));
  signalType = menu(strcat("Choose signal type for region ", region), "DC Signal", "Ramp Signal", 
  "General Order Polynomial Signal", "Exponential Signal", "Sinusoidal Signal");
  
  sample = (breakPts(i)-regionStartTime)*fs; % No. of samples 
  t = linspace(regionStartTime, breakPts(i), sample);

   switch (signalType)
     case 1 %DC Signal
        amp = input("Enter amplitude of DC signal: "); 
        y = amp*ones(1,sample);
     case 2 %Ramp Signal
       slope = input("Enter slope of Ramp signal: "); 
       intercept = input("Enter intercept of Ramp signal: "); 
        y = slope*t + intercept;
     case 3 %General Order Polynomial Signal
       ampPower = input("Enter the amplitude power:");
       for i=0:ampPower
          power = input(strcat("Enter coefficient of X^", i));
          p = [p power];
       endfor
       y = polyval(p,t); % Poynomial evaluation
     case 4 %Exponential Signal
       amp = input("Enter amplitude of Exponential signal: "); 
       exp = input("Enter exponent of Exponential signal: "); 
       y = amp*exp(t);
     case 5%"Sinusoidal Signal"
        amp = input("Enter amplitude of Sinosoidal signal: "); 
        freq = input("Enter freq of Sinosoidal signal: "); 
        phase = input("Enter phase of Sinosoidal signal: "); 
        y = amp*sin(2*pi*freq*t + phase);
     otherwise
   endswitch
   
   regionStartTime = breakPts(i)
   tOP = [tOP t];
   yOP = [yOP y];
endfor

plot(tOP,yOP);

%----------- Signal Operations --------------
while(1)
  signalOperation = menu("Do you want to make an operation on the signal?", "Amplitude Scaling", "Time Reversal", 
    "Time Shift", "Expanding the signal", "Compressing the signal", "None");
    tOperation = tOP;
    yOperation = yOP;
  switch (signalOperation)
    case 1 %"Amplitude Scaling"
      scale = input("Enter scale value: "); 
      yOperation = scale*yOP;
    case 2 %"Time Reversal"
      tOperation = fliplr(-tOP);
      yOperation = fliplr(yOP);
    case 3 %"Time Shift"
      shift = input("Enter shift value: "); 
      tOperation = tOP + shift;
    case 4 %"Expanding the signal"
      c = input("Enter expanding value: ");
      if c ~= 0
        tOperation = c*tOP;
      endif
    case 5 %"Compressing the signal"
      c = input("Enter compressing value: ");
      if c ~= 0
        tOperation = c*tOP;
      endif
    otherwise break;
  endswitch
  plot(tOperation, yOperation)
endwhile
