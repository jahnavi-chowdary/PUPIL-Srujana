function play2videos(vid1 , vid2)

% This function concatenates the right and left videos side by side so that
% the person analysing the patients data can see the reaction of both the
% eyes simultaneously.

display('Saving Concatenated Videos...')

mr_no = evalin('base','mr_no');
attempt = evalin('base','attempt');    

% mkdir('./Concatenated_Videos');

videoPlayer = vision.VideoPlayer;

% Concatenating the Videos and generating a New Video
video_filename = strcat(mr_no,'_',num2str(attempt),'.avi');
outputVideo = VideoWriter(fullfile('./Concatenated_Videos',video_filename));
outputVideo1 = VideoWriter('new_concatenated_video.avi');

outputVideo.FrameRate = vid1.FrameRate;
outputVideo1.FrameRate = vid1.FrameRate;

open(outputVideo);
open(outputVideo1);

while hasFrame(vid1) && hasFrame(vid2)
    img1 = readFrame(vid1);
    img2 = readFrame(vid2);

    imgt = horzcat(img1, img2);

    % Play Concatenated Video
    % step(videoPlayer, imgt);

    % Record New video
    writeVideo(outputVideo, imgt);
    writeVideo(outputVideo1, imgt);
end

release(videoPlayer);
close(outputVideo);
close(outputVideo1);

display('Concatenated Videos Saved!!!')

end
