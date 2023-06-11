function received_signal_with_noise = add_noise_to_linecoding( lineCode ,sigma ,Vectime )
  %this function simulate external noise from communication channel (telephone line) or noise from reciever add to transmitted line coding 
  % define your time vector 
  t = Vectime;
  % noise
  n = sigma*randn(1,length(t));     
  % add the noise to your received signal
  received_signal_with_noise = lineCode + n;
end