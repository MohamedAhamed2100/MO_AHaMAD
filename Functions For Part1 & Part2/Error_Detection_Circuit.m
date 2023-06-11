function [number_of_detected_errors]=Error_Detection_Circuit(Repeater_output,voltage,noSamplesPerBit,noOfBits)
      %error detection circuit for (Bipolar return to zero)
      number_of_detected_errors=0;
      L=noSamplesPerBit/4; 
      for i=1:1:noOfBits
          if(L>=noOfBits*noSamplesPerBit||(L+noSamplesPerBit)>=noOfBits*noSamplesPerBit)
             break;
          end
          %1000000000...01
          if(Repeater_output(L)==voltage&&Repeater_output(L+noSamplesPerBit)==0)
                 if(L>=noOfBits*noSamplesPerBit||(L+noSamplesPerBit)>=noOfBits*noSamplesPerBit)
                     break;
                 else  
                     L=L+noSamplesPerBit; 
                 end
                 
                 while(Repeater_output(L)==0)
                     if(L>=noOfBits*noSamplesPerBit||(L+noSamplesPerBit)>=noOfBits*noSamplesPerBit)
                        break;
                     else  
                        L=L+noSamplesPerBit; 
                     end
                 end
                 
                 if(Repeater_output(L)==voltage)
                    number_of_detected_errors= number_of_detected_errors+1;
                 end  
         %-100000000...0-1
         elseif(Repeater_output(L)==-1*voltage&&Repeater_output(L+noSamplesPerBit)==0)
                 if(L>=noOfBits*noSamplesPerBit||(L+noSamplesPerBit)>=noOfBits*noSamplesPerBit)
                    break;
                 else
                     L=L+noSamplesPerBit;
                 end 
                 
                 while(Repeater_output(L)==0)
                     if(L>=noOfBits*noSamplesPerBit||(L+noSamplesPerBit)>=noOfBits*noSamplesPerBit)
                        break;
                     else
                     L=L+noSamplesPerBit;
                     end
                 end
                 
                 if(Repeater_output(L)==-1*voltage)
                    number_of_detected_errors= number_of_detected_errors+1;
                 end
          %-1-1       
          elseif(Repeater_output(L)==-1*voltage&&Repeater_output(L+noSamplesPerBit)==-1*voltage)
                    number_of_detected_errors= number_of_detected_errors+1;
                    if(L>=noOfBits*noSamplesPerBit||(L+noSamplesPerBit)>=noOfBits*noSamplesPerBit)
                       break;
                    else
                     L=L+noSamplesPerBit;
                    end

          %11   
          elseif(Repeater_output(L)==voltage&&Repeater_output(L+noSamplesPerBit)==voltage)
                    number_of_detected_errors= number_of_detected_errors+1;
                    if(L>=noOfBits*noSamplesPerBit||(L+noSamplesPerBit)>=noOfBits*noSamplesPerBit)
                       break;
                    else
                     L=L+noSamplesPerBit;
                    end
          end
          
          if(L>=noOfBits*noSamplesPerBit||(L+noSamplesPerBit)>=noOfBits*noSamplesPerBit)
             break;
          else
             L=L+noSamplesPerBit;
          end
      end
end  