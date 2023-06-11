function plot_eye_diagram(noBitsPerSegments , noSamplePerBit , lineCodeVec , bitPeriod)
    % segment is a colliction of no bits we need to shift them to create the eye diagram
    % segmentLength : total samples in a segment
    segmentLength = noSamplePerBit * noBitsPerSegments;
    % periodic time of the samples
    samplePeriod = bitPeriod / noSamplePerBit;
    % time vector is created with a step of samplePeriod, and the end is the total time a segment
    % coulde be calculated using using noBitsPerSegments and Bit periodic time and the samplePeriod...
    % with a step = sample period
    timeVec = (0 : segmentLength - 1) * samplePeriod;
    % to center the zero in the mid
    timeVec = timeVec - (noBitsPerSegments * bitPeriod / 2);
    % total no of total segment layers to place in top of each other
    % segment layers = total no of samples in line code / total no of samples in the segment
    % it's rounded down to the nearest integer, as we nee to keep the size of the segment ...
    % equal to the size of time vector in terms of the samples
    segmentLayers = floor(length(lineCodeVec) / segmentLength);
    for i = 1 : segmentLayers
         % find the start and end points of the segment in the line code
        % it's multiplies in the no of bits per segment
        segmentStart = (i - 1)*segmentLength + 1;
        segmentEnd = i * segmentLength ;
        % x axis is the time vector, and the y axis is the amlitude of each bit
        plot(timeVec , lineCodeVec(segmentStart : segmentEnd),'LineWidth',2);
        % hold to plot all the segments on top of each other
        hold on;
    end
    axis([-1 1 -bitPeriod bitPeriod]);
end