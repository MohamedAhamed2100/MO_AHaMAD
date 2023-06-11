function [Reciever_output]=decision_device(received_signal_with_noise,coding_scheme,voltage ,timeVec,noSamplesPerBit,noOfBits)
             %to select the type of line coding by coding scheme
             switch (coding_scheme)
                case 'UniPolarNRZ'
                      Reciever_output=r_unipolarNRZ(received_signal_with_noise,voltage,timeVec,noSamplesPerBit,noOfBits );
                      
                case 'PolarNRZ'
                      Reciever_output=r_polarNRZ(received_signal_with_noise,voltage,timeVec,noSamplesPerBit,noOfBits );

                case 'UniPolarRZ'
                      Reciever_output=r_unipolarRZ(received_signal_with_noise,voltage,timeVec,noSamplesPerBit,noOfBits );

                case 'BiPolarRZ'
                      Reciever_output=r_bipolarRZ(received_signal_with_noise,voltage,timeVec,noSamplesPerBit,noOfBits );

                case 'ManchesterCoding'
                      Reciever_output=r_manchesterCoding(received_signal_with_noise,voltage,timeVec,noSamplesPerBit,noOfBits );
              end
end

function [Reciever_output]=Master_source_and_comparator(received_signal_with_noise,noOfBits,noSamplesPerBit,timeVec,L,M,P,threshold_1,threshold_2)
   % pre-allocate an vector to store the Reciever_output
   Reciever_output = zeros(1, length(timeVec));
   switch nargin
        case 8
            for i=1:1:noOfBits
                   if(received_signal_with_noise(L)<threshold_1)
                       for k=M:1:P
                           Reciever_output(k)=0;
                       end   
                   elseif(received_signal_with_noise(L)>threshold_1)
                       for k=M:1:P
                           Reciever_output(k)=1;
                       end
                   end
                   M=M+noSamplesPerBit;
                   P=P+noSamplesPerBit;
                   L=L+noSamplesPerBit;
            end  
        
        case 9 
             for i=1:1:(noOfBits)
                 if (received_signal_with_noise(L)<threshold_2)
                    for k=M:1:P
                        Reciever_output(k)=1;
                    end   
                 elseif (received_signal_with_noise(L)>threshold_1)
                    for k=M:1:P
                        Reciever_output(k)=1;
                    end
                 elseif (received_signal_with_noise(L)<threshold_1&&received_signal_with_noise(L)>threshold_2)
                    for k=M:1:P
                        Reciever_output(k)=0;
                    end   
                 end
             M=M+noSamplesPerBit;
             P=P+noSamplesPerBit;
             L=L+noSamplesPerBit;
             end
    end
end

 
function [Reciever_output] = r_unipolarNRZ(received_signal_with_noise ,  voltage ,timeVec ,noSamplesPerBit , noOfBits)
   % L decision level of timing ciruit 
   % M,P time of bit in our time vector  
   threshold = voltage/2;
   L=noSamplesPerBit/2;
   M=1;
   P=noSamplesPerBit;
   [Reciever_output]=Master_source_and_comparator(received_signal_with_noise,noOfBits,noSamplesPerBit,timeVec,L,M,P,threshold);
end

function [Reciever_output] = r_polarNRZ(received_signal_with_noise ,  voltage ,timeVec ,noSamplesPerBit , noOfBits )
   % L decision level of timing ciruit 
   % M,P time of bit in our time vector
   threshold = (voltage+(-1*(voltage)))/2;
   L=noSamplesPerBit/2;
   M=1;
   P=noSamplesPerBit;
  Reciever_output=Master_source_and_comparator(received_signal_with_noise,noOfBits,noSamplesPerBit,timeVec,L,M,P,threshold);
end

function [Reciever_output] = r_unipolarRZ(received_signal_with_noise ,  voltage ,timeVec ,noSamplesPerBit , noOfBits )
   % L decision level of timing ciruit 
   % M,P time of bit in our time vector
   threshold = voltage/2;
   L=noSamplesPerBit/4;
   M=1;
   P=noSamplesPerBit;
   Reciever_output=Master_source_and_comparator(received_signal_with_noise,noOfBits,noSamplesPerBit,timeVec,L,M,P,threshold);   
end

function [Reciever_output] = r_bipolarRZ(received_signal_with_noise ,  voltage ,timeVec ,noSamplesPerBit , noOfBits )
   % L decision level of timing ciruit 
   % M,P time of bit in our time vector
   threshold_1 = voltage/2;
   threshold_2 =(-1*(voltage))/2;
   L=noSamplesPerBit/4;
   M=1;
   P=noSamplesPerBit;
   Reciever_output=Master_source_and_comparator(received_signal_with_noise,noOfBits,noSamplesPerBit,timeVec,L,M,P,threshold_1,threshold_2);   
end

function [Reciever_output] = r_manchesterCoding(received_signal_with_noise,voltage,timeVec,noSamplesPerBit,noOfBits )
   % L decision level of timing ciruit 
   % M,P time of bit in our time vector
   threshold = (voltage+(-1*(voltage)))/2;
   L=noSamplesPerBit/4;
   M=1;
   P=noSamplesPerBit;
   Reciever_output=Master_source_and_comparator(received_signal_with_noise,noOfBits,noSamplesPerBit,timeVec,L,M,P,threshold);   
end