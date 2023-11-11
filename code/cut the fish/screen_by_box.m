function stats = screen_by_box(stats)
valid_indices = [];
for k = 1 : length(stats)
    thisBB = stats(k).BoundingBox;
    if thisBB(3) <= 200 && thisBB(3) * thisBB(4) > 1000
        valid_indices = [valid_indices, k];
    end
end
stats = stats(valid_indices);
end