function  [spectral,f,BW,Spec_Original_line_coding]=spectral_domain(lineCodeVec,bit_stream,noSamplesPerBit,bitPeriod,fc)
   switch nargin
        %choose according to number of input arguments
        case 4
            [spectral,f]=Baseband_communication(lineCodeVec,bit_stream,noSamplesPerBit,bitPeriod);
        case 5
            [spectral,f,BW,Spec_Original_line_coding]=Passband_communication(lineCodeVec,bit_stream,noSamplesPerBit,bitPeriod,fc);
   end   
end

function [spectral,f,BW,Spec_Original_line_coding]=Passband_communication(lineCodeVec,bit_stream,noSamplesPerBit,bitPeriod,fc)
    %calculation to generate frequency domain
    noOfBits=length(bit_stream);
    fs = 10*fc;  % sampling frequency -Sampling rate - This will define the resoultion 
    ts = 1/fs;   % time step    
    T  = (noOfBits)*(noOfBits*ts); % simulation time 
    Rb =  noOfBits/T;              %bit rate = N/simulation time
    BW =  Rb ;   %polar & nrz
    df = 1/T;    %frequency  step
    %spectrum of Original Digital Signal
    Spec_Original_line_coding = (fftshift(fft(lineCodeVec)))/noOfBits; % we put message in frequency domain becease it only shift function in fft
    %frequency doomain
    if(rem(noOfBits,2)==0) %% even
        f = ((-(0.5*fs)): df : ((0.5*fs)-df));%% frequency vector if x/f even
    else %% odd
        f = (-(0.5*fs-0.5*df)) : df :(((0.5*fs)+1)-0.5*df); %% frequecy vector if X/f is odd 
    end
    %power spectral of Original Digital Signal
    spectral =abs(Spec_Original_line_coding).^2;
end

function [spectral,f]=Baseband_communication(lineCodeVec,noSamplesPerBit,bitPeriod,bit_stream)
    %calculation to generate frequency domain
    T = length(bit_stream)*bitPeriod; %simulation time
    df=1/T;  %frequency  step
    fs=noSamplesPerBit/bitPeriod; % sampling frequency
    N=noSamplesPerBit*length(bit_stream);
    %spectrum of Original Digital Signal
    Spec_Original_line_coding = (fftshift(fft(lineCodeVec)))/N; 
    % frequency doomain
    if(rem(N,2)==0) %% even
        f = ((-(0.5*fs)): df : ((0.5*fs)-df));%% frequency vector if x/f even
    else %% odd
        f = (-(0.5*fs-0.5*df)) : df :(((0.5*fs)+1)-0.5*df); %% frequecy vector if X/f is odd
    end
    %power spectral of Original Digital Signal
    spectral =abs(Spec_Original_line_coding).^2;
end
