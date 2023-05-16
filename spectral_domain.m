function  [spectral,f]=spectral_domain(lineCodeVec,noSamplesPerBit,bitPeriod,bit_stream)
    T = length(bit_stream)*bitPeriod;
    df=1/T;
    fs=noSamplesPerBit/bitPeriod;
    N=noSamplesPerBit*length(bit_stream);
    %spectrum of Original Digital Signal (baseband signal)
    Spec_Original_line_coding = (fftshift(fft(lineCodeVec)))/N; % we put message in frequency domain becease it only shift function in fft
    if(rem(N,2)==0) %% even
        f = ((-(0.5*fs)): df : ((0.5*fs)-df));%% frequency vector if x/f even
    else %% odd
        f = (-(0.5*fs-0.5*df)) : df :(((0.5*fs)+1)-0.5*df); %% frequecy vector if X/f is odd
    end
    spectral =(abs(Spec_Original_line_coding)).^2;
end
