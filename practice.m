% Open a GUI window to select videos
[files, folder] = uigetfile('D:\*.mp4', 'Select two video files', 'MultiSelect', 'on');

% Check if the user selected two files
if ~iscell(files) || numel(files) ~= 2
    error('Please select exactly two video files.');
end

% Load the videos
video1 = VideoReader(fullfile(folder, files{1}));
video2 = VideoReader(fullfile(folder, files{2}));

% Create figure for displaying videos side by side
figure;

% TODO: check the framerate

% Get the frame rate
frameRate = video1.FrameRate;

% Display the frame rate
disp(['Frame rate of the video: ' num2str(frameRate) ' frames per second']);

% Display first video
subplot(1,2,1);
while hasFrame(video1)
    frame = readFrame(video1);
    imshow(frame);
    drawnow;
    title('Video 1');
end


% Display second video
subplot(1,2,2);
while hasFrame(video2)
    frame = readFrame(video2);
    imshow(frame);
    drawnow;
    title('Video 2');
end