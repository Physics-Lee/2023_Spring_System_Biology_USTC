function exclusionMask = createExclusionMask(video)

    % Number of frames to sample
    numSampleFrames = 10;

    % Select frames
    frameNumbers = round(linspace(1, video.NumFrames, numSampleFrames));

    % Initialize mask
    exclusionMask = true(video.Height, video.Width);

    for f = 1 : length(frameNumbers)

        % Set current time of video object
        video.CurrentTime = (frameNumbers(f)-1) / video.FrameRate;

        % Read frame
        frame = readFrame(video);

        % Pre-process
        grayFrame = rgb2gray(frame);
        threshold = 0.3; 
        binaryFrame = imbinarize(grayFrame, threshold);

        % Merge this frame's binary image with the overall mask
        exclusionMask = exclusionMask & binaryFrame;

    end

end
