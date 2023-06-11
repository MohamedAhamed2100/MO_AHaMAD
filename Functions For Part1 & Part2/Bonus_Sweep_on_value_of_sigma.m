function[number_of_detected_errors]=Bonus_Sweep_on_value_of_sigma(lineCodeVec,voltage,timeVec,coding_scheme,noSamplesPerBit,noOfBits)
      % generate 10 ranges for sigma that range from 0 to the maximum supply voltage  
        sigma_ranges = linspace(0,voltage,10);
        
      % pre-allocate an vector to store the BER values & num_errors
        number_of_detected_errors = zeros(1, 10);
        
      % loop choose each value of sigma by index i
      for i = 1:10   
         %add noise to signal
         received_signal_with_noise=add_noise_to_linecoding(lineCodeVec,sigma_ranges(i),timeVec );
         
         %path signal through Regenerative_Repeater
         [Repeater_output]=Regenerative_Repeater(received_signal_with_noise,coding_scheme,voltage ,timeVec,noSamplesPerBit,noOfBits);
          
         %calculate number_of_detected_errors for this value of sigma
         number_of_detected_errors(i)=Error_Detection_Circuit(Repeater_output,voltage,noSamplesPerBit,noOfBits);% insert your code for calculating number_of_detected_errors here
      end
end
