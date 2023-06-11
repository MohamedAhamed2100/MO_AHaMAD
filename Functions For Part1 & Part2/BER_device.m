function [BER,num_errors]=BER_device(Reciever_output, bit_stream )
    % count the number of errors & calculate BER
    num_errors = sum(Reciever_output~=bit_stream);
    BER = num_errors / length(bit_stream);
end
   