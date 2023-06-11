  %% octave Script for a Binary PSK (passband communication)

  % Clear all variables and close all figures
  clear all;
  close all;

%%
noOfBits = 100; % Number of time samples

  
%% Generate bit stream
  bit_stream = generate_random_bits(noOfBits);
  
  %% Calculations
  fc = 10^9;   % Frequency of Modulating Signal
  fs = 10 * fc;  % Sampling frequency - Sampling rate - This will define the resolution
  ts = 1 / fs;   % Time step
  t = 0:ts:(noOfBits - 1) * ts;   % Time for one bit - Time of one bit = 1 second per one bit
  T = (noOfBits) * (noOfBits * ts);   % Simulation time
  Rb = noOfBits / T;   % Bit rate = N / simulation time

  voltage = 1;
  bitPeriod = t(end);
  noSamplesPerBit = length(t);
  coding_scheme = 'PolarNRZ';

  %% The PolarNRZ Signal
  [PolarNRZ, timeVec] = line_coding(bit_stream, coding_scheme, voltage, bitPeriod, noSamplesPerBit, fc);

  %% Plot the PolarNRZ Signal with time
  figure(1);
  plot(timeVec, PolarNRZ, 'r', 'LineWidth', 2);
  xlabel('Time (s)');
  ylabel('Amplitude (V)');
  title('PolarNRZ Signal');
  axis([0 timeVec(end) -1.5 1.5]);
  grid on;

  %% Spectrum & Spectral of PolarNRZ Signal
  [spectral_PolarNRZ_Signal, f, BW, Spec_PolarNRZ_Signal] = spectral_domain(PolarNRZ, bit_stream, noSamplesPerBit, bitPeriod, fc);
  figure(2);
  grid on;
  plot(f, abs(Spec_PolarNRZ_Signal));
  title('Spectrum of Original PolarNRZ Signal');
  xlabel("Frequency (Hz)");
  ylabel('Amplitude (V)');
  figure(3);
  plot(f, spectral_PolarNRZ_Signal);
  title('Power Spectral Density of PolarNRZ Signal');
  xlabel("Frequency (Hz)");
  ylabel('Power Spectral Density');

  %% The BPSK Signal (modulated signal of PolarNRZ Signal after product modulator in transmitter circuit)
  BPSK_signal = PolarNRZ .* cos(2 * pi * fc * timeVec);

  %% Plot the BPSK Signal (line coding) with time
  figure(4);
  plot(timeVec, BPSK_signal, 'LineWidth', 2);
  xlabel('Time (s)');
  ylabel('Amplitude (V)');
  title('BPSK Signal with Two Phase Shifts');
  axis([0 timeVec(end) -1.5 1.5]);
  grid on;

  %% Spectrum & Spectral of BPSK signal
  [spectral_BPSK_signal, f, BW, spec_BPSK_signal] = spectral_domain(BPSK_signal, bit_stream, noSamplesPerBit, bitPeriod, fc);
  figure(5);
  grid on;
  subplot(1, 2, 1);
  plot(f, abs(spec_BPSK_signal));
  title("Spectrum of Modulated BPSK Signal");
  xlabel("Frequency (Hz)");
  ylabel('Amplitude (V)');
  subplot(1, 2, 2);
  plot(f, spectral_BPSK_signal);
  title("Power Spectral Density of Modulated BPSK Signal");
  xlabel("Frequency (Hz)");
  ylabel('Power Spectral Density');

   %% demodulated signal (demodulation for BPSK signal after product modulator in recivied circuit)
   demodulated_BPSK_signal = BPSK_signal .* cos(2 * pi * fc * timeVec);

   %% specterum & spectral of recieved signal (demodulated BPSK signal) after product modulator in reciver circuit
   [spectral_demodulated_BPSK_signal,f,BW,spec_demodulated_BPSK_signal] = spectral_domain(demodulated_BPSK_signal, bit_stream, noSamplesPerBit, bitPeriod, fc);
   figure(6);
   grid on;
   subplot(1,2,1);
   plot(f, abs(spec_demodulated_BPSK_signal));
   title("specterum of recieved signal after product modulator in reciver circuit ");
   xlabel("frequency (Hz)");
   ylabel("Amplitude (V)");
   subplot(1,2,2);
   plot(f, spectral_demodulated_BPSK_signal);
   title("power spectral density of demodulated BPSK signal");
   xlabel("frequency (Hz)");
   ylabel("power spectral density ");

   %% LPF (Ideal)
   H = abs(f) < (BW);

   %% specterum &spectral of demodulated BPSK signal After LPF
   demodulated_BPSK_signal_After_Lpf = abs(real(H .* spec_demodulated_BPSK_signal));
   figure(7);
   grid on;
   subplot(1,2,1);
   plot(f, demodulated_BPSK_signal_After_Lpf);
   title("spectrum of demodulated BPSK signal After Lpf");
   xlabel("frequency (Hz)");
   ylabel("Amplitude (V)");
   subplot(1,2,2);
   plot(f, (demodulated_BPSK_signal_After_Lpf .^ 2));
   title("power spectral density of demodulated BPSK signal After Lpf");
   xlabel("frequency (Hz)");
   ylabel("power spectral density ");

   %% demodulated BPSK signal AFTER LPF in time domain
   demodulated_BPSK_signal_After_Lpf_t = real(ifft(fftshift(H .* spec_demodulated_BPSK_signal) * noOfBits)); %1/N
   figure(8);
   grid on;
   subplot(2,1,1);
   plot(timeVec, demodulated_BPSK_signal_After_Lpf_t, 'LineWidth', 2);
   axis([0 timeVec(end) -1*voltage voltage]);
   title("demodulated BPSK signal After LPF in time domain");
   xlabel("time(s)");
   ylabel("Amplitude (V)");

   %% decision device circuit give wave form in ones and zeros and remove effect of LPF
   [Reciever_output] = decision_device(demodulated_BPSK_signal_After_Lpf_t, coding_scheme, voltage, timeVec, noSamplesPerBit, noOfBits);
   subplot(2,1,2);
   plot(timeVec, Reciever_output, 'color', [0.6350 0.0780 0.1840], 'LineWidth', 2);
   axis([0 timeVec(end) 0 voltage]);
   title("Reciever output");
   xlabel("time(s)");
   ylabel("Amplitude (V)");

   %% return reciever output in form of binary data
   binary_data = convert_into_Binary_data(Reciever_output, bit_stream, noSamplesPerBit);

   %% calculate BER & num_errors
   [BER, num_errors] = BER_device(binary_data, bit_stream);
