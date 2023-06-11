function [lineCodeVec,timeVec]=line_coding(bit_stream,coding_scheme,voltage ,bitPeriod,noSamplesPerBit,fc )
   switch nargin
            %choose according to number of input arguments
            case 5
            [lineCodeVec,timeVec]=Baseband_communication(bit_stream,coding_scheme,voltage,bitPeriod,noSamplesPerBit);
            case 6
            [lineCodeVec,timeVec]=Passband_communication(bit_stream,coding_scheme,voltage,bitPeriod,noSamplesPerBit,fc);
   end 
end

function [lineCodeVec,timeVec]=Passband_communication(bit_stream,coding_scheme,voltage,bitPeriod,noSamplesPerBit,fc)
   %this function implement function of polarNRZ block in transmitter
   % calculations
   noOfBits=length(bit_stream);
   fs = 10*fc;  % sampling frequency-Sampling rate-This will define the resoultion 
   ts = 1/fs;   % time step    
   t = 0:ts:(noOfBits-1)*ts;  % Time for one bit - time of one bit = 1 second per one bit
   % generate time domain
   timeVec = [];
   for ii = 1: 1: length(bit_stream)
     timeVec = [timeVec t];
     t =  t + (noOfBits-1)*ts ;
   end
   noSamplesPerBit=length(t);
   % generate polarNrz line coding
   switch (coding_scheme)
    case 'PolarNRZ'
          lineCodeVec = polarNRZ(bit_stream , voltage , timeVec , noSamplesPerBit);
   end
end

function [lineCodeVec,timeVec]=Baseband_communication(bit_stream,coding_scheme,voltage,bitPeriod,noSamplesPerBit)
  %this function used to convert binary data into different voltage forms or wave forms 
  % noSamplesPerBit for plotting, samples per bit
  timeVec = timeVecDec(bit_stream , bitPeriod , noSamplesPerBit); %create time vector
  %to select the type of line coding
  switch (coding_scheme)
    case 'UniPolarNRZ'
          lineCodeVec = unipolarNRZ(bit_stream , voltage , timeVec , noSamplesPerBit);

    case 'PolarNRZ'
          lineCodeVec = polarNRZ(bit_stream , voltage , timeVec , noSamplesPerBit);

    case 'UniPolarRZ'
          lineCodeVec = unipolarRZ(bit_stream , voltage , timeVec , noSamplesPerBit);

    case 'BiPolarRZ'
          lineCodeVec = bipolarRZ(bit_stream , voltage , timeVec , noSamplesPerBit);

    case 'ManchesterCoding'
          lineCodeVec = manchesterCoding(bit_stream , voltage , timeVec , noSamplesPerBit);
  end
end

function timeVec = timeVecDec(bit_stream , bitPeriod , noSamplesPerBit)
  % total time of the stream of bits = bit time period * total no of bits
  totTime = bitPeriod * length(bit_stream);
  % samples are used to increase the smoothness of the plotting
  % each bit is plotted using noSamplesPerBit
  % total no of samples used = no smaples per bit * total no of bits
  totNoSamples = noSamplesPerBit * length(bit_stream);
  % periodic time of the samples
  samplePeriod = totTime / totNoSamples;
  %create time vector, steps are samplePeriodic time, end point is the totaltime of the bits
  timeVec = 0 : samplePeriod : totTime - samplePeriod;
end

function lineCodeVec = unipolarNRZ(bit_stream , voltage , timeVec , noSamplesPerBit)
    lineCodeVec = zeros(1 , length(timeVec));
    for i = 1 : length(bit_stream)
       if bit_stream(i) == 1
        % +ve voltage for all the bit period
        lineCodeVec( ((i - 1) * noSamplesPerBit) + 1 : i * noSamplesPerBit) = voltage;
       end
    end
end

function lineCodeVec = polarNRZ(bit_stream , voltage , timeVec , noSamplesPerBit)
  lineCodeVec = unipolarNRZ(bit_stream , voltage , timeVec , noSamplesPerBit);
  %same as unipolarNRZ but change all the zeros into -ve voltage
  lineCodeVec(lineCodeVec == 0) = -1 * voltage;
end

function lineCodeVec = unipolarRZ(bit_stream , voltage , timeVec , noSamplesPerBit)
    lineCodeVec = zeros(1 , length(timeVec));
    for i = 1 : length(bit_stream)
      if bit_stream(i) == 1
        %+ve voltage for the first half cycle of the bits
        lineCodeVec( ((i - 1) * noSamplesPerBit) + 1 : (i * noSamplesPerBit) - (noSamplesPerBit / 2)) = voltage;
        % 0 voltage for the other half cycle of the bit
        lineCodeVec( (i * noSamplesPerBit) - (noSamplesPerBit / 2) + 1 : i * noSamplesPerBit) = 0;
      end
    end
end

function lineCodeVec = bipolarRZ(bit_stream , voltage , timeVec , noSamplesPerBit)
    lineCodeVec = zeros(1 , length(timeVec));
    flag = 0; % to indicate whether the voltage to be +ve or -ve
    for i = 1 : length(bit_stream)
      if bit_stream(i) == 1
            if (flag == 0)
               %+ve voltage for the first half cycle of the bits
               lineCodeVec( ((i - 1) * noSamplesPerBit) + 1 : (i * noSamplesPerBit) - (noSamplesPerBit / 2)) = voltage;
               % 0 voltage for the other half cycle of the bit
               lineCodeVec( (i * noSamplesPerBit) - (noSamplesPerBit / 2) + 1 : i * noSamplesPerBit) = 0;
               flag = 1; %update the flag
            elseif(flag == 1)
               %-ve voltage for the first half cycle of the bits
               lineCodeVec( ((i - 1) * noSamplesPerBit) + 1 : (i * noSamplesPerBit) - (noSamplesPerBit / 2)) = -voltage;
               % 0 voltage for the other half cycle of the bit
               lineCodeVec( (i * noSamplesPerBit) - (noSamplesPerBit / 2) + 1 : i * noSamplesPerBit) = 0;
               flag = 0; %update the flag
            end
      end
    end
end

function lineCodeVec = manchesterCoding(bit_stream , voltage , timeVec , noSamplesPerBit)
    lineCodeVec = zeros(1 , length(timeVec));
    for i = 1 : length(bit_stream)
      if bit_stream(i) == 1
        %+ve voltage for the first half cycle of the bits
        lineCodeVec( ((i - 1) * noSamplesPerBit) + 1 : (i * noSamplesPerBit) - (noSamplesPerBit / 2)) = voltage;
        %-ve voltage for the other half cycle of the bit
        lineCodeVec( (i * noSamplesPerBit) - (noSamplesPerBit / 2) + 1 : i * noSamplesPerBit) = -1* voltage;
      else
        %-ve voltage for the first half cycle of the bits
        lineCodeVec( ((i - 1) * noSamplesPerBit) + 1 : (i * noSamplesPerBit) - (noSamplesPerBit / 2)) = -1 * voltage;
        %+ve voltage for the other half cycle of the bit
        lineCodeVec( (i * noSamplesPerBit) - (noSamplesPerBit / 2) + 1 : i * noSamplesPerBit) = voltage;
      end
    end
end