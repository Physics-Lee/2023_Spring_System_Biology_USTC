function expandedRegion = extend_fish_region(fishRegion,videoWidth,videoHeight,standardSize)

    % Calculate the margins required to expand the region
    xMargin = (standardSize(2) - fishRegion(3)) / 2;
    yMargin = (standardSize(1) - fishRegion(4)) / 2;

    % Calculate the expanded region coordinates
    xMin = max(fishRegion(1) - xMargin, 1);
    yMin = max(fishRegion(2) - yMargin, 1);
    xMax = min(xMin + standardSize(2), videoWidth);
    yMax = min(yMin + standardSize(1), videoHeight);
    
    % If exceeding the video boundaries, shift the region
    if xMax - xMin < standardSize(2)
        if xMin == 1
            xMax = xMin + standardSize(2);
        else
            xMin = xMax - standardSize(2);
        end
    end
    if yMax - yMin < standardSize(1)
        if yMin == 1
            yMax = yMin + standardSize(1);
        else
            yMin = yMax - standardSize(1);
        end
    end
    
    % Define the expanded region
    expandedRegion = [xMin, yMin, xMax-xMin, yMax-yMin];
    
end