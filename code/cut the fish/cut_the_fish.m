clc;clear;close all

for i = 1:7

    % read
    folder_name = 'F:\1_learning\class\10_2023_Spring\System Biology\final project\videos of zebrafish\training-videos\mp4';
    file_name = ['0' num2str(i) '.mp4'];
    full_path = fullfile(folder_name,file_name);
    video = VideoReader(full_path);

    % save
    outputVideoFile = strrep(full_path,'.','_cut.');
    outputVideo = VideoWriter(outputVideoFile, 'MPEG-4');
    open(outputVideo);

    % video properties
    videoWidth = video.Width;
    videoHeight = video.Height;
    N_Frames = video.NumFrames;
    fishRegion_all = cell(N_Frames,1);

    % the size of the video after cut
    standardSize = [300 300];

    %% set the boundaries as exclusion mask
    exclusionMask = createExclusionMask(video);
    figure; % let the user check
    imshow(exclusionMask);

    % let the user choose
    response = input('Press Enter to continue after checking the image or type q to quit: ', 's');
    if strcmp(response, 'q') || strcmp(response, 'Q') % If user types q or Q
        return; % Exit the script or function
    end

    video = VideoReader(full_path); % reset video

    % Loop through each frame of the video
    count_all = 0;
    count_recognized = 0;
    count_not_recognized = 0;
    while hasFrame(video)

        %% pre-process

        count_all = count_all + 1;

        % read frame
        frame = readFrame(video);

        % rgb to gray
        grayFrame = rgb2gray(frame);

        % gray to binary
        threshold = 0.3; % super-parameter % u can use graythresh to get the threshold
        binaryFrame = imbinarize(grayFrame, threshold);

        % apply the exclusion mask
        binaryFrame(exclusionMask) = 0;

        %% get bounding boxes

        % find the region properties of the binary image
        bounding_box = regionprops(binaryFrame, 'BoundingBox');

        % screen the bounding box by its size
        % bounding_box = screen_by_box(bounding_box_before_screen);

        % screen the bounding box by min dist to edge
        % minDistFromEdge = 100; % super-parameter
        % bounding_box = screen_by_edge(bounding_box,videoWidth,videoHeight,minDistFromEdge);

        % compute areas for all bounding boxes
        areas = zeros(1, length(bounding_box));
        for k = 1 : length(bounding_box)
            thisBB = bounding_box(k).BoundingBox;
            areas(k) = thisBB(3) * thisBB(4);
        end

        % Assume the fish region is the largest bounding box
        [~, index] = max(areas);
        try
            % areas has at least 1 element

            % extend the bounding box
            fishRegion = bounding_box(index).BoundingBox;
            count_recognized = count_recognized + 1;
            extended_fishRegion = extend_fish_region(fishRegion,videoWidth,videoHeight,standardSize);
            fishRegion_all{count_recognized} = extended_fishRegion;

            % extract the extended bounding box
            fishFrame = imcrop(frame, extended_fishRegion);

            % % show some images to the user
            if ismember(count_recognized, 1:100:N_Frames)
                figure(count_recognized);
                imshow(fishFrame);
            end

            % Write the fish frame to the output video
            writeVideo(outputVideo, fishFrame);

        catch
            % areas has 0 element

            count_not_recognized = count_not_recognized + 1;
        end

    end
    close(outputVideo);
    close all;
end