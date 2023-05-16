function [ Reciever_output ] = decision_device( received_signal_with_noise , coding_scheme , voltage  ,timeVec ,noSamplesPerBit , noOfBits)
              switch (coding_scheme)
                case 'UniPolarNRZ'
                      Reciever_output = r_unipolarNRZ(received_signal_with_noise , voltage ,timeVec ,noSamplesPerBit , noOfBits );
                      
                case 'PolarNRZ'
                      Reciever_output = r_polarNRZ(received_signal_with_noise , voltage ,timeVec ,noSamplesPerBit , noOfBits );

                case 'UniPolarRZ'
                      Reciever_output = r_unipolarRZ(received_signal_with_noise , voltage ,timeVec ,noSamplesPerBit , noOfBits );

                case 'BiPolarRZ'
                      Reciever_output = r_bipolarRZ(received_signal_with_noise , voltage ,timeVec ,noSamplesPerBit , noOfBits );

                case 'ManchesterCoding'
                      Reciever_output = r_manchesterCoding(received_signal_with_noise , voltage ,timeVec ,noSamplesPerBit , noOfBits );
              end
end
 
function [Reciever_output] = r_unipolarNRZ(received_signal_with_noise ,  voltage ,timeVec ,noSamplesPerBit , noOfBits)
  % pre-allocate an vector to store the o_lineCodeVec
   Reciever_output = zeros(1, length(timeVec));
   L=1;
   J=noSamplesPerBit;
   M=1;
   P=noSamplesPerBit;
   average=0;
   for i=1:1:noOfBits
       for k=L:1:J
          average=average+received_signal_with_noise(k);
       end
       average=average/noSamplesPerBit;
       L=L+noSamplesPerBit;
       J=J+noSamplesPerBit;
       threshold = voltage/2;
       if(average<threshold)
           for k=M:1:P
               Reciever_output(k)=0;
           end   
       elseif(average>threshold)
           for k=M:1:P
               Reciever_output(k)=voltage;
           end
       end
       M=M+noSamplesPerBit;
       P=P+noSamplesPerBit;
       average=0;
   end    
end

function [Reciever_output] = r_polarNRZ(received_signal_with_noise ,  voltage ,timeVec ,noSamplesPerBit , noOfBits )
   % pre-allocate an vector to store the o_lineCodeVec
   Reciever_output = zeros(1, length(timeVec));
   threshold = (voltage+(-1*(voltage)))/2;
   L=1;
   J=noSamplesPerBit;
   M=1;
   P=noSamplesPerBit;
   average=0;
   for i=1:1:noOfBits
       for k=L:1:J
          average=average+received_signal_with_noise(k);
       end
       average=average/noSamplesPerBit;
       L=L+noSamplesPerBit;
       J=J+noSamplesPerBit;
       if (average<threshold)
           for k=M:1:P
               Reciever_output(k)=-1*voltage;
           end   
       elseif (average>threshold)
           for k=M:1:P
               Reciever_output(k)=voltage;
           end
       end
       M=M+noSamplesPerBit;
       P=P+noSamplesPerBit;
       average=0;
   end    
end

function [Reciever_output] = r_unipolarRZ(received_signal_with_noise ,  voltage ,timeVec ,noSamplesPerBit , noOfBits )
   % pre-allocate an vector to store the o_lineCodeVec
  Reciever_output = zeros(1, length(timeVec));
   threshold = voltage/2;
   L=1;
   J=noSamplesPerBit/2;
   M=1;
   P=noSamplesPerBit/2;
   average=0;
   for i=1:1:(2*noOfBits)
       for k=L:1:J
          average=average+received_signal_with_noise(k);
       end
       average=average/(noSamplesPerBit/2);
       L=L+(noSamplesPerBit/2);
       J=J+(noSamplesPerBit/2);
       if (average<threshold)
           for k=M:1:P
               Reciever_output(k)=0;
           end   
       elseif (average>threshold)
           for k=M:1:P
               Reciever_output(k)=voltage;
           end
       end
       M=M+(noSamplesPerBit/2);
       P=P+(noSamplesPerBit/2);
       average=0;
   end    
end

function [Reciever_output] = r_bipolarRZ(received_signal_with_noise ,  voltage ,timeVec ,noSamplesPerBit , noOfBits )
   % pre-allocate an vector to store the o_lineCodeVec
   Reciever_output = zeros(1, length(timeVec));
   threshold_1 = voltage/2;
   threshold_2 =(-1*(voltage))/2;
   L=1;
   J=noSamplesPerBit/2;
   M=1;
   P=noSamplesPerBit/2;
   average=0;
   for i=1:1:(2*noOfBits)
       for k=L:1:J
          average=average+received_signal_with_noise(k);
       end
       average=average/(noSamplesPerBit/2);
       L=L+noSamplesPerBit/2;
       J=J+noSamplesPerBit/2;
       if (average<threshold_2)
           for k=M:1:P
               Reciever_output(k)=-1*voltage;
           end   
       elseif (average>threshold_1)
           for k=M:1:P
               Reciever_output(k)=voltage;
           end
       elseif (average<threshold_1 && average>threshold_2)
           for k=M:1:P
               Reciever_output(k)=0;
           end   
       end
       M=M+noSamplesPerBit/2;
       P=P+noSamplesPerBit/2;
       average=0;
   end    
end

function [Reciever_output] = r_manchesterCoding(received_signal_with_noise ,  voltage ,timeVec,noSamplesPerBit , noOfBits )
   % pre-allocate an vector to store the o_lineCodeVec
   Reciever_output = zeros(1, length(timeVec));
   threshold = (voltage+(-1*(voltage)))/2;
   L=1;
   J=noSamplesPerBit/2;
   M=1;
   P=noSamplesPerBit/2;
   average=0;
   for i=1:1:2*noOfBits
       for k=L:1:J
          average=average+received_signal_with_noise(k);
       end
       average=average/(noSamplesPerBit/2);
       L=L+noSamplesPerBit/2;
       J=J+noSamplesPerBit/2;
       if (average<threshold)
           for k=M:1:P
               Reciever_output(k)=-1*voltage;
           end   
       elseif (average>threshold)
           for k=M:1:P
               Reciever_output(k)=voltage;
           end
       end
       M=M+noSamplesPerBit/2;
       P=P+noSamplesPerBit/2;
       average=0;
   end     
end

