function bit_stream = generate_random_bits( noOfBits )
  % generate random sequence of binary data zeros and ones
  bit_stream = randi( [ 0 , 1 ] , 1 , noOfBits );
end
