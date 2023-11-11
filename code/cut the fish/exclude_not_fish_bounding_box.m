function [exclusionMask,isFirstFrame] = exclude_not_fish_bounding_box(isFirstFrame,fishRegion,bounding_box_before_screen)

if isFirstFrame

    fishIndex = find(cellfun(@(elem) isequal(elem, fishRegion), {bounding_box_before_screen.BoundingBox}));

    % Create the exclusion mask
    for k = 1 : length(bounding_box_before_screen)
        if k ~= fishIndex
            thisBB = floor(bounding_box_before_screen(k).BoundingBox);
            for j = 1:4
                if thisBB(j) == 0
                    thisBB(j) = 1;
                end
            end
            exclusionMask(thisBB(2):(thisBB(2)+thisBB(4)), thisBB(1):(thisBB(1)+thisBB(3))) = true;
        end
    end

    isFirstFrame = false;
end

end