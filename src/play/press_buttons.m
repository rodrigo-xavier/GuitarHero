function press_buttons(video, arduino)

    playgame = Play(arduino);

    while true
        playgame.get_pixels(video);
        playgame.set_up();
        playgame.tear_down();
    end
end