function configure_video(vid)
    %create video player object
    hvpc = vision.VideoPlayer;

    src = getselectedsource(vid);
    vid.FramesPerTrigger = 1;
    vid.TriggerRepeat = Inf;
    vid.ReturnedColorspace = 'rgb';
    vid.Timeout = 50;
    start(vid)
end