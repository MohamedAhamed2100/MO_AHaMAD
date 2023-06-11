%% octave Script for a Line coding system (base band communication) that use in data center or networks or ethernet or telephone lines
% Clear all variables and close all figures
clear all;
close all;

%% set values
voltage=1.2;

noOfBits=10000;
bitPeriod=1;
noSamplesPerBit=200;
noBitsPerSegments=3;

coding_scheme1='UniPolarNRZ';
coding_scheme2='PolarNRZ';
coding_scheme3='UniPolarRZ';
coding_scheme4='BiPolarRZ';
coding_scheme5='ManchesterCoding';


%% generate bit_stream
bit_stream = generate_random_bits( noOfBits );

%% generate 5 line coding in time domain
[lineCodeVec1, timeVec1] = line_coding(bit_stream, coding_scheme1, voltage, bitPeriod, noSamplesPerBit);
[lineCodeVec2, timeVec2] = line_coding(bit_stream, coding_scheme2, voltage, bitPeriod, noSamplesPerBit);
[lineCodeVec3, timeVec3] = line_coding(bit_stream, coding_scheme3, voltage, bitPeriod, noSamplesPerBit);
[lineCodeVec4, timeVec4] = line_coding(bit_stream, coding_scheme4, voltage, bitPeriod, noSamplesPerBit);
[lineCodeVec5, timeVec5] = line_coding(bit_stream, coding_scheme5, voltage, bitPeriod, noSamplesPerBit);

%% plot 5 line coding in time domain
% UniPolarNRZ line coding
figure(1);
plot(timeVec1, lineCodeVec1, 'color', [0.4940 0.1840 0.5560], 'LineWidth', 2);
axis([0 timeVec1(end) 0 - voltage/2 voltage*3/2]);
title("UniPolarNRZ line coding");
legend('UniPolarNRZ');

% Zoomed
figure(2);
plot(timeVec1, lineCodeVec1, 'color', [0.4940 0.1840 0.5560], 'LineWidth', 2);
axis([0 100*bitPeriod 0 - voltage/2 voltage*3/2]);
title("UniPolarNRZ line coding (zoomed to first 100 bits)");
legend('UniPolarNRZ');
grid on;


% PolarNRZ line coding
figure(3);
plot(timeVec2, lineCodeVec2, 'color', [1 0 0], 'LineWidth', 2);
axis([0 timeVec2(end) -3*voltage/2 3*voltage/2]);
title("PolarNRZ line coding");
legend('PolarNRZ');

% Zoomed
figure(4);
plot(timeVec2, lineCodeVec2, 'color', [1 0 0], 'LineWidth', 2);
axis([0 100*bitPeriod -3*voltage/2 3*voltage/2]);
title("PolarNRZ line coding (zoomed to first 100 bits)");
legend('PolarNRZ');
grid on;

% UniPolarRZ line coding
figure(5);
plot(timeVec3, lineCodeVec3, 'color', [0.8500 0.3250 0.0980], 'LineWidth', 2);
axis([0 timeVec3(end) 0 - voltage/2 voltage*3/2]);
title("UniPolarRZ line coding");
legend('UniPolarRZ');

% Zoomed
figure(6);
plot(timeVec3, lineCodeVec3, 'color', [0.8500 0.3250 0.0980], 'LineWidth', 2);
axis([0 100*bitPeriod 0 - voltage/2 voltage*3/2]);
title("UniPolarRZ line coding (zoomed to first 100 bits)");
legend('UniPolarRZ');

% BiPolarRZ line coding
figure(7);
plot(timeVec4, lineCodeVec4, 'color', [0 0.4470 0.7410], 'LineWidth', 2);
axis([0 timeVec4(end) -3*voltage/2 3*voltage/2]);
title("BiPolarRZ line coding");
legend('BiPolarRZ');

% Zoomed
figure(8);
plot(timeVec4, lineCodeVec4, 'color', [0 0.4470 0.7410], 'LineWidth', 2);
axis([0 100*bitPeriod -3*voltage/2 3*voltage/2]);
title("BiPolarRZ line coding (zoomed to first 100 bits)");
legend('BiPolarRZ');
grid on;

% ManchesterCoding line coding
figure(9);
plot(timeVec5, lineCodeVec5, 'color', [0.6350 0.0780 0.1840], 'LineWidth', 2);
axis([0 timeVec5(end) -3*voltage/2 3*voltage/2]);
title("ManchesterCoding line coding");
legend('ManchesterCoding');

% Zoomed
figure(10);
plot(timeVec5, lineCodeVec5, 'color', [0.6350 0.0780 0.1840], 'LineWidth', 2);
axis([0 100*bitPeriod -3*voltage/2 3*voltage/2]);
title("ManchesterCoding line coding (zoomed to first 100 bits)");
legend('ManchesterCoding');
grid on;

%% plot eye diagram of 5 line coding(transmitted signal)
% UniPolarNRZ
figure(11);
subplot(1,5,1);
plot_eye_diagram(noBitsPerSegments , noSamplesPerBit , lineCodeVec1 , bitPeriod);
title("eye diagram of UniPolarNRZ");
legend('UniPolarNRZ');
ylim([0-voltage/4 3*voltage/2]);
grid on;

% PolarNRZ
subplot(1,5,2);
plot_eye_diagram(noBitsPerSegments , noSamplesPerBit , lineCodeVec2 , bitPeriod);
title("eye diagram of PolarNRZ");
legend('PolarNRZ');
ylim([-3*voltage/2 3*voltage/2]);
grid on;

% UniPolarRZ
subplot(1,5,3);
plot_eye_diagram(noBitsPerSegments , noSamplesPerBit , lineCodeVec3 , bitPeriod);
title("eye diagram of UniPolarRZ");
legend('UniPolarRZ');
ylim([0-voltage/4 3*voltage/2]);
grid on;

% BiPolarRZ
subplot(1,5,4);
plot_eye_diagram(noBitsPerSegments , noSamplesPerBit , lineCodeVec4 , bitPeriod);
title("eye diagram of BiPolarRZ");
legend('BiPolarRZ');
ylim([-3*voltage/2 3*voltage/2]);
grid on;

% ManchesterCoding
subplot(1,5,5);
plot_eye_diagram(noBitsPerSegments , noSamplesPerBit , lineCodeVec5 , bitPeriod);
title("eye diagram of ManchesterCoding");
legend('ManchesterCoding');
ylim([-3*voltage/2 3*voltage/2]);
grid on;

%% get power spectrum of line coding (transmitted signal)
[spectral_of_lineCodeVec1,f1] = spectral_domain(lineCodeVec1,noSamplesPerBit,bitPeriod,bit_stream);
[spectral_of_lineCodeVec2,f2] = spectral_domain(lineCodeVec2,noSamplesPerBit,bitPeriod,bit_stream);
[spectral_of_lineCodeVec3,f3] = spectral_domain(lineCodeVec3,noSamplesPerBit,bitPeriod,bit_stream);
[spectral_of_lineCodeVec4,f4] = spectral_domain(lineCodeVec4,noSamplesPerBit,bitPeriod,bit_stream);
[spectral_of_lineCodeVec5,f5] = spectral_domain(lineCodeVec5,noSamplesPerBit,bitPeriod,bit_stream);

%% plot power spectrum of any type of line coding
% UniPolarNRZ
figure(12);
plot(f1,spectral_of_lineCodeVec1,'color',[0.4940 0.1840 0.5560],'LineWidth',2);
title("power spectral of UniPolarNRZ");
xlabel("frequency (Hz)");
ylabel('power spectral density');
legend('UniPolarNRZ');
grid on;

% Zoomed UniPolarNRZ
figure(13);
plot(f1,spectral_of_lineCodeVec1,'color',[0.4940 0.1840 0.5560],'LineWidth',2);
title("power spectral of UniPolarNRZ (zoomed)");
xlabel("frequency (Hz)");
ylabel('power spectral density');
legend('UniPolarNRZ');
axis([-3 3 0 0.0003]);
grid on;

% PolarNRZ
figure(14);
plot(f2,spectral_of_lineCodeVec2,'color',[1 0 0],'LineWidth',2);
title("power spectral of PolarNRZ");
xlabel("frequency (Hz)");
ylabel('power spectral density');
legend('PolarNRZ');
grid on;
axis([-5 5 0 0.0012]);

% UniPolarRZ
figure(15);
plot(f3,spectral_of_lineCodeVec3,'color',[0.8500 0.3250 0.0980],'LineWidth',2);
title("power spectral of UniPolarRZ");
xlabel("frequency (Hz)");
ylabel('power spectral density');
legend('UniPolarRZ');
grid on;

% Zoomed UniPolarRZ
figure(16);
plot(f3,spectral_of_lineCodeVec3,'color',[0.8500 0.3250 0.0980],'LineWidth',2);
title("power spectral of UniPolarRZ (zoomed)");
xlabel("frequency (Hz)");
ylabel('power spectral density');
legend('UniPolarRZ');
grid on;
axis([-6 6 0 0.0001]);

% BiPolarRZ
figure(17);
plot(f4,spectral_of_lineCodeVec4,'color',[0 0.4470 0.7410],'LineWidth',2);
title("power spectral of BiPolarRZ");
xlabel("frequency (Hz)");
ylabel('power spectral density');
legend('BiPolarRZ');
axis([-15 15 0 0.00025]);
grid on;

% ManchesterCoding
figure(18);
plot(f5,spectral_of_lineCodeVec5,'color',[0.6350 0.0780 0.1840],'LineWidth',2);
title("power spectral of ManchesterCoding");
xlabel("frequency (Hz)");
ylabel('power spectral density');
legend('ManchesterCoding');
axis([-10 10 0 0.0008]);

%% semilogy for 5 types of line coding BER versus sigma
figure(19);
sigma_ranges = linspace(0, voltage, 10);
[BER_values1, num_errors1] = Sweep_on_value_of_sigma(lineCodeVec1, voltage, timeVec1, coding_scheme1, noSamplesPerBit, noOfBits, bit_stream);
[BER_values2, num_errors2] = Sweep_on_value_of_sigma(lineCodeVec2, voltage, timeVec2, coding_scheme2, noSamplesPerBit, noOfBits, bit_stream);
[BER_values3, num_errors3] = Sweep_on_value_of_sigma(lineCodeVec3, voltage, timeVec3, coding_scheme3, noSamplesPerBit, noOfBits, bit_stream);
[BER_values4, num_errors4] = Sweep_on_value_of_sigma(lineCodeVec4, voltage, timeVec4, coding_scheme4, noSamplesPerBit, noOfBits, bit_stream);
[BER_values5, num_errors5] = Sweep_on_value_of_sigma(lineCodeVec5, voltage, timeVec5, coding_scheme5, noSamplesPerBit, noOfBits, bit_stream);

semilogy(sigma_ranges, BER_values1,sigma_ranges,BER_values2,sigma_ranges,BER_values3,sigma_ranges,BER_values4,sigma_ranges,BER_values5,'LineWidth',2);

grid on;
xlabel('Sigma');
ylabel('BER');
legend({'UniPolarNRZ', 'PolarNRZ', 'UniPolarRZ', 'BiPolarRZ', 'ManchesterCoding'});

%% BONUS
%[number_of_detected_errors]=Bonus_Sweep_on_value_of_sigma(lineCodeVec4,voltage,timeVec4,coding_scheme4,noSamplesPerBit,noOfBits);


%% 
figure(20);
eyediagram(lineCodeVec1,400,2,0);
figure(21);
eyediagram(lineCodeVec2,400,2,0);
figure(22);
eyediagram(lineCodeVec3,400,2,0);
figure(23);
eyediagram(lineCodeVec4,400,2,0);
figure(24);
eyediagram(lineCodeVec5,400,2,0);