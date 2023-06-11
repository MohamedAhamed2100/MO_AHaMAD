function [binary_data]=convert_into_Binary_data(Reciever_output,bit_stream,noSamplesPerBit)
%pre-allocate an vector to store the binary_data 
         binary_data = zeros(1, length(bit_stream));
         L=noSamplesPerBit/2;
         for P=1:1:length(bit_stream)
             if(Reciever_output(L)==0)
                binary_data(P)=0;
             elseif(Reciever_output(L)==1)
                binary_data(P)=1;
              end
              L=L+noSamplesPerBit;
         end  
end         