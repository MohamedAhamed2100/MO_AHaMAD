function received_signal_with_noise = add_noise_to_linecoding( lineCode ,sigma ,Vectime )
  % define your time vector and maximum supply voltage
  t = Vectime;
  % noise
  n = sigma*randn(1,length(t));     
  % add the noise to your received signal
  received_signal_with_noise = lineCode + n;
end