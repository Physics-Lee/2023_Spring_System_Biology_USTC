function stats = screen_by_edge(stats,Width,Height,minDistFromEdge)

% Compute areas for all bounding boxes, delete the ones with width > 200, or near the edge
valid_indices = [];
for k = 1 : length(stats)
    thisBB = stats(k).BoundingBox;
    if thisBB(1) >= minDistFromEdge && ...
            thisBB(1) + thisBB(3) <= Width - minDistFromEdge
        valid_indices = [valid_indices, k];
    end
end
stats = stats(valid_indices);

end