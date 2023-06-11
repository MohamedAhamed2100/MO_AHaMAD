## line coding system & Binary Phase Shift Keying (BPSK)

from May 2023 - Jun 2023

Associated with Faculty Of Engineering Ain Shams University

## Project Description:

part1:
You are looking for a simulation project using Octave or Matlab for line coding system. Here are the steps you need to follow:

Transmitter:

1. Generate stream of random bits (10,000 bit) (This bit stream should be selected to be random, which means that the type of each bit is randomly selected by the program code to be either ‘1’ or ‘0’).
2. Line code the stream of bits(pulse shape) according to Uni-polar non return to zero (Supply voltages are: +1.2 V and -1.2V).
3. Plot the corresponding Eye diagram.
3. Plot the spectral domains of the pulses (square of the Fourier transform).

Receiver: 

5. Design a receiver which consists of a decision device. (The decision device has two inputs: received waveform). 
6. Compare the output of the decision level with the generated stream of bits in the transmitter. The comparison is performed by comparing the value of each received bit with the corresponding transmitted bit (step 1) and count number of errors. Then calculate bit error rate (BER) = number of error bits/ Total number of bits. 
7. Repeat the previous steps for different line coding (Polar non return to zero, Uni-polar return to zero, Bipolar return to zero and Manchester coding) 
8. Add noise to the received signal (Hint: use n = sigma * randn(1,length(t) ),where t is time vector and sigma is the noise rms value). 
9. Sweep on the value of sigma (10 values ranges from 0 to the maximum supply voltage) and calculate the corresponding BER for each value of sigma. 
10.Repeat the previous steps for different line coding and plot BER versus sigma for the different line coding in the same figure, where y-axis is in the log scale (Hint: use semilogy). 
11.(Bonus) For the case of Bipolar return to zero , design an error detection circuit. Count the number of detected errors in case of different number of sigma (Use the output of step 8).

part2:

You are looking for a simulation project using Octave forcode for BPSK transmitter and receiver .

Transmitter:

1. Generates a stream of random bits (100 bit) and line codes the stream of bits (pulse shape) according to Polar non return to zero (Maximum voltage +1, Minimum voltage -1). 
2. It then plots the spectral domains and time domain of the modulated BPSK signal (𝑓𝑐 = 1𝐺𝐻𝑧) as well as the spectrum of the modulated BPSK signal. 

Receiver:

3. The receiver consists of modulator, integrator (simply LPF) and decision device. 
4. The output of decision level is compared with the generated stream of bits in the transmitter. The comparison is performed by comparing the value of each received bit with the corresponding transmitted bit (step 1) and count number of errors. Then calculate bit error rate (BER) = number of error bits/ Total number of bits 1.

## Tool Used

Octave is a free software licensed under the GNU General Public License (GPL) 1. It is a powerful mathematics-oriented syntax with built-in 2D/3D plotting and visualization tools. You can download it from the official website https://octave.org/ or use the package manager of your operating system.

![image](https://github.com/MohamedAhamed2100/MO_AHaMAD/assets/107947222/9746b463-f58e-4987-a81e-64aab0c1bbb0)

and MATLAB is a programming and numeric computing platform used by millions of engineers and scientists to analyze data, develop algorithms, and create models.

![image](https://github.com/MohamedAhamed2100/communication-project/assets/107947222/6f44daf8-5e52-4ebf-b623-43f503462d84)

## Credits

This Team project is part of the requiremtents of "ECE252s - Fundamentals of Communication Systems" course.

## Team 8 members

  Abdelrhman Ahmed Sayed Ahmed 
  
  mohamed Ahmed Sayed Ahmed 
  
  Eslam Mohamed Marzouk Abdelaziz
  
  Youssef Hassanin Mahmoud Hassanin

  Karim Ibrahim Saad Abd-Elrazek Elshehawy

  Abdelrhman Elsayed Ahemd Mohamed 

  Muhammad AbdelKhaleq Muhammad

  Ahmed Nader Ahmed Mohamed

  Yasmeen Mahmoud Hassan Mahmoud

  Ahmed Ali Abd Elhakeem Hassan
