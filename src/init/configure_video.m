function configure_video(video)
    % create video player object
    hvpc = vision.VideoPlayer;

    src = getselectedsource(video);
    video.FramesPerTrigger = 1;
    video.TriggerRepeat = Inf;
    video.ReturnedColorspace = 'rgb';
    video.Timeout = 50;
    start(video)
end