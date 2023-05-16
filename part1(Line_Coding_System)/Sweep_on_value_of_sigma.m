function Sweep_on_value_of_sigma(lineCodeVec,voltage,timeVec ,coding_scheme,color ,noSamplesPerBit , noOfBits)
      % generate 10 ranges for sigma that range from 0 to the maximum supply voltage  
      sigma_ranges = linspace(0,voltage , 10);
      % pre-allocate an array to store the BER values
      BER_values = zeros(1, 10);
      % loop over each value of sigma
      for i = 1:10   
         %add noise to signal
         received_signal_with_noise = add_noise_to_linecoding( lineCodeVec ,sigma_ranges(i) ,timeVec );
         %path signal through decision device
         Reciever_output = decision_device( received_signal_with_noise , coding_scheme , voltage , timeVec ,noSamplesPerBit , noOfBits);
         % calculate the BER for this value of sigma
         BER_values(i) = BER_device(Reciever_output , lineCodeVec); % insert your code for calculating BER here
      end
     semilogy(sigma_ranges,BER_values,color,'LineWidth',3);
     xlabel('Sigma');
     ylabel('BER');
end