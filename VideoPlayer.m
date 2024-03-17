function displayVideoGUI()
    % Create figure
    fig = uifigure('Name', 'Video Player', 'Position', [100 100 1280 480]);

    % Create axes for displaying videos
    ax1 = uiaxes(fig, 'Position', [10 50 620 420]);
    ax2 = uiaxes(fig, 'Position', [650 50 620 420]);

    % Create button to select video files
    uibutton(fig, 'Text', 'Select Videos', 'Position', [10 10 100 30], 'ButtonPushedFcn', @selectVideos);

    % Callback function for the 'Select Videos' button
    function selectVideos(~, ~)
        % Open a file dialog to select the first video file
        [filename1, pathname] = uigetfile({'D:\*.mp4'}, 'Select First Video File');

        % Check if a file was selected
        if isequal(filename1,0) || isequal(pathname,0)
            return; % User canceled
        end

        % Open a file dialog to select the second video file
        [filename2, pathname] = uigetfile({'D:\*.mp4'}, 'Select Second Video File');

        % Check if a file was selected
        if isequal(filename2,0) || isequal(pathname,0)
            return; % User canceled
        end

        % Create VideoReader objects for both videos
        video1 = VideoReader(fullfile(pathname, filename1));
        video2 = VideoReader(fullfile(pathname, filename2));
       
        % Set the desired frame rate
        desiredFrameRate = 100;

        % Get the frame rate of the first video
        frameRate1 = video1.FrameRate;
        disp(['Frame rate of the first video: ' num2str(frameRate1) ' frames per second']);

        % Get the frame rate of the second video
        frameRate2 = video2.FrameRate;
        disp(['Frame rate of the second video: ' num2str(frameRate2) ' frames per second']);

        % Calculate the frame skip factor to achieve the desired frame rate
        frameSkipFactor1 = video1.FrameRate / desiredFrameRate;
        frameSkipFactor2 = video2.FrameRate / desiredFrameRate;
        
        % Display the frame skip factors
        disp(['Frame skip factor for video 1: ' num2str(frameSkipFactor1)]);
        disp(['Frame skip factor for video 2: ' num2str(frameSkipFactor2)]);

        

        % Display both videos side by side
        while hasFrame(video1) && hasFrame(video2)
            frame1 = readFrame(video1);
            frame2 = readFrame(video2);
            imshow(frame1, 'Parent', ax1);
            imshow(frame2, 'Parent', ax2);
            drawnow;
        end
    end
end
