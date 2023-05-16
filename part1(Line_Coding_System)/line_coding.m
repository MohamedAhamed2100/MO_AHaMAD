function [ lineCodeVec , timeVec , noSamplesPerBit  ] = line_coding(bit_stream , coding_scheme , voltage , bitPeriod )
  noSamplesPerBit = 200; %for plotting, samples per bit

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