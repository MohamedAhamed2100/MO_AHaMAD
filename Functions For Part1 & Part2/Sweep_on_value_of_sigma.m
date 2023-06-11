function[BER_values , num_errors]=Sweep_on_value_of_sigma(lineCodeVec,voltage,timeVec,coding_scheme,noSamplesPerBit,noOfBits,bit_stream)
      % generate 10 ranges for sigma that range from 0 to the maximum supply voltage  
        sigma_ranges = linspace(0,voltage,10);
        
      % pre-allocate an vector to store the BER values & num_errors
        BER_values= zeros(1, 10);
        num_errors = zeros(1, 10);
        
      % loop choose each value of sigma by index i
      for i = 1:10   
         %add noise to signal
         received_signal_with_noise=add_noise_to_linecoding(lineCodeVec,sigma_ranges(i),timeVec );
         
         %path signal through decision device
         Reciever_output=decision_device(received_signal_with_noise,coding_scheme,voltage,timeVec,noSamplesPerBit,noOfBits);
         
         %this loop used to convert Reciever output into binary data
         binary_data=convert_into_Binary_data(Reciever_output,bit_stream,noSamplesPerBit);
          
         %calculate the BER & num_errors for this value of sigma
         [BER_values(i),num_errors(i)]= BER_device(binary_data,bit_stream); % insert your code for calculating BER & num_errors here
      end
end

   