function press_buttons(video, arduino)

    % cores
    R = 1;
    G = 2;
    B = 3;

    playgame = Playgame();
    playgame.arduino = arduino;

    while true
        imgO = getdata(video,1,'uint8');

        playgame.greenPixel     = imgO(312,230,playgame.G);
        playgame.redPixel       = imgO(311,274,playgame.R);
        playgame.yellowPixelR   = imgO(312,311,playgame.R);
        playgame.yellowPixelG   = imgO(312,311,playgame.G);
        playgame.bluePixelG     = imgO(312,354,playgame.G);
        playgame.bluePixelB     = imgO(312,354,playgame.B);
        playgame.orangePixelR   = imgO(311,395,playgame.R);
        playgame.orangePixelG   = imgO(311,395,playgame.G);

        playgame.set_up();
        playgame.tear_down();
    end
end