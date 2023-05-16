function [BER,num_errors] = BER_device(o_lineCodeVec ,lineCodeVec)
    % count the number of errors
    num_errors = sum(o_lineCodeVec ~= lineCodeVec);
    BER = num_errors / length(lineCodeVec);
end