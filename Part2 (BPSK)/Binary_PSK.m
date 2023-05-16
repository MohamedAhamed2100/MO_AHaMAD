% MATLAB Script for a Binary PSK with two Phases
% Clear all variables and close all figures
clear all;
close all;

N  = 100;  % number of time samples
% generate bit_stream
bit_stream = generate_random_bits( N );
% Enter the two Phase shifts - in Radians
P1 = 0;          % Phase for 1 bit
P2 = pi;         % Phase for 0 bit

fc = 10^9;   % Frequency of Modulating Signal
fs = 10*fc;  % sampling frequency -Sampling rate - This will define the resoultion 
ts = 1/fs;   % time step    
t = 0:ts:(N-1)*ts;% Time for one bit - time of one bit = 1 second per one bit
T  = (N)*(N*ts); % simulation time 
Rb =  N/T;       %bit rate = N/simulation time
BW =  Rb ;   %polar & nrz
df = 1/T;   % frequency  step
          


% This time variable is just for plot
time = [];
BPSK_signal = [];
Digital_signal = [];

for ii = 1: 1: length(bit_stream)
    
    % The Original Digital Signal
    Digital_signal = [Digital_signal (bit_stream(ii)==0)*...
        (-1*ones(1,length(t))) + (bit_stream(ii)==1)*ones(1,length(t))];
    
     %The BPSK Signal
     BPSK_signal= [BPSK_signal ((bit_stream(ii)==1)*cos(2*pi*fc*t + P1))+...
    ((bit_stream(ii)==0)*cos(2*pi*fc*t + P2))];
   
     time = [time t];
     t =  t + (N-1)*ts ;
 end
 %BPSK_signal=Digital_signal.*cos(2*pi*fc*t);

%% Plot the BPSK Signal (line coding) with time
figure(1);
subplot(2,1,1);
plot(time,BPSK_signal,'LineWidth',2);
xlabel('Time (s)');
ylabel('Amplitude (V)');
title('BPSK Signal with two Phase Shifts');
axis([0 time(end) -1.5 1.5]);
grid  on;

% Plot the Original Digital Signal with time
subplot(2,1,2);
plot(time,Digital_signal,'r','LineWidth',2);
xlabel('Time (S)');
ylabel('Amplitude (V)');
title('Original Digital Signal');
axis([0 time(end) -1.5 1.5]);
grid on;

%% spectrum of Original Digital Signal (baseband signal)
Spec_Original_Digital_Signal = (fftshift(fft(Digital_signal)))/N; % we put message in frequency domain becease it only shift function in fft
if(rem(N,2)==0) %% even
    f = ((-(0.5*fs)): df : ((0.5*fs)-df));%% frequency vector if x/f even
else %% odd
    f = (-(0.5*fs-0.5*df)) : df :(((0.5*fs)+1)-0.5*df); %% frequecy vector if X/f is odd 
end
figure(2);
subplot(1,2,1);
plot(f,abs(Spec_Original_Digital_Signal));
title('spectrum of Original Digital Signal (baseband signal)');
xlabel("frequency (Hz)");
ylabel('Amplitude (V)');
subplot(1,2,2);
plot(f,(abs(Spec_Original_Digital_Signal).^2));
title('power spectrum of Original Digital Signal (baseband signal)');
xlabel("frequency (Hz)");
ylabel('power density');

%% spectrum of modulated BPSK signal
spec_M_BPSK_signal = (fftshift(fft(BPSK_signal)))/N; % we put message in frequency domain becease it only shift function in fft
figure(2);
subplot(1,2,1);
plot(f,abs(spec_M_BPSK_signal));
title("spectrum of modulated BPSK signal");
xlabel("frequency (Hz)");
ylabel('Amplitude (V)');
grid on;
subplot(1,2,2);
plot(f,(abs(spec_M_BPSK_signal).^2));
title("power spectrum of modulated BPSK signal");
xlabel("frequency (Hz)");
ylabel('power density ');
grid on;

%% product modulator of recivied circuit
t_2 = 0: ts :(N-1)*ts ;
time_2 = [];
BPSK_signal_2 = [];
for ii = 1: 1: length(bit_stream)
    
    % The PSK Signal
     BPSK_signal_2= [BPSK_signal_2 (bit_stream(ii)==1)*cos(2*pi*fc*t_2 ).^2+...
        (bit_stream(ii)==0)*cos(2*pi*fc*t_2+P2).*cos(2*pi*fc*t_2)];
   
     time_2 = [time_2 t_2];
     t_2 =  t_2 + (N-1)*ts;
end
%BPSK_signal_2=BPSK_signal*cos(2*pi*fc*t_2 );
%% specterum of recieved signal after product modulator in reciver circuit  
spec_2_M_BPSK_signal = (fftshift(fft(BPSK_signal_2)))/N; % we put message in frequency domain becease it only shift function in fft

figure(3);

subplot(1,2,1);
plot(f,abs(spec_2_M_BPSK_signal));
title("specterum of recieved signal after product modulator in reciver circuit ");
xlabel("frequency (Hz)");
ylabel("Amplitude (V)");
grid on ;
subplot(1,2,2);
plot(f,(abs(spec_2_M_BPSK_signal).^2));
title("power specterum of recieved signal after product modulator in reciver circuit ");
xlabel("frequency (Hz)");
ylabel("power density ");
grid on ;
%% LPF (Ideal)
H = abs(f)< (BW) ;

%% spectrum AFTER LPF 
BPSK_signal_After_Lpf = abs(real(H.*spec_2_M_BPSK_signal));
figure(4);
subplot(1,2,1);
plot(f,BPSK_signal_After_Lpf);
title("spectrum_of_BPSK_signal_After_Lpf");
xlabel("frequency (Hz)");
ylabel("Amplitude (V)");
subplot(1,2,2);
plot(f,(BPSK_signal_After_Lpf.^2));
title("power spectrum_of_BPSK_signal_After_Lpf");
xlabel("frequency (Hz)");
ylabel("power density ");

%% AFTER LPF 
BPSK_signal_After_Lpf_t = real(ifft(fftshift(H.*spec_2_M_BPSK_signal)*N));%1/N periodic signal 
figure(5);
subplot(2,1,1),plot(time,BPSK_signal_After_Lpf_t,'LineWidth',2);
title("BPSK_signal_After_Lpf");
xlabel("time(s)");
ylabel("Amplitude (V)");
grid  on;

%% decision device circuit
   threshold = 0;
   L=1;
   J=length(t);
   M=1;
   P=length(t);
   average=0;
   for i=1:1:N
       for k=L:1:J
          average=average+BPSK_signal_After_Lpf_t(k);
       end
       average=average/length(t);
       L=L+length(t);
       J=J+length(t);
       if (average<threshold)
           for k=M:1:P
               Digital_signal_2(k)=-1;
           end   
       elseif (average>threshold)
           for k=M:1:P
               Digital_signal_2(k)=1;
           end
       end
       M=M+length(t);
       P=P+length(t);
       average=0;
   end       
subplot(2,1,2), plot(time,Digital_signal_2,'k','LineWidth',2);
title("output_BPSK_signal_from_recieved circuit");
xlabel("time(s)");
ylabel("Amplitude (V)");
grid on;

%% error
error=[];
for ii = 1: 1: length(time)
        error(ii) = Digital_signal(ii)- Digital_signal_2(ii);
end
count=0;
for ii = 1: 1: length(error)
    if (error(ii)~=0)
        count = count+1;
    end
end    
number_of_error_bits = count;
[BER,num_errors] = BER_device(Digital_signal_2 , Digital_signal);
figure;
plot(time, error)
title("error");
xlabel("time(s)");
ylabel("Amplitude (V)");
grid on;