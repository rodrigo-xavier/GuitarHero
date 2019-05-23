function depurate(vid, galileo)
    debug_color_pixels = true;
    debug_color = 'all';
    debug_just_video = false;

    if(~debug_just_video)
        if      (debug_color_pixels)
            color_pixels(vid, galileo);
        elseif  (debug_color == 'all')
            press_buttons(vid, galileo);
        elseif  (debug_color == 'colored_pixels')
            press_buttons_colored_pixels(vid, galileo);
        elseif  (debug_color == 'green')
            press_buttons_green(vid, galileo);
        elseif  (debug_color == 'red')
            press_buttons_red(vid, galileo);
        elseif  (debug_color == 'blue')
            press_buttons_blue(vid, galileo);
        elseif  (debug_color == 'orange')
            press_buttons_orange(vid, galileo);
        else    (debug_color == 'yellow')
            press_buttons_yellow(vid, galileo);
        end
    end
end

function color_pixels(vid, galileo)
    while true
        imgO = getdata(vid,1,'uint8');

        R = 1;
        G = 2;
        B = 3;

        % Colore de verde os pixels que estão sendo utilizados

        % Simple Green
        imgO(312,230,R) = 0;
        imgO(312,230,G) = 255;
        imgO(312,230,B) = 0;

        % Simple Red
        imgO(311,274,R) = 0;
        imgO(311,274,G) = 255;
        imgO(311,274,B) = 0;

        % Simple Yellow
        imgO(312,311,R) = 0;
        imgO(312,311,G) = 255;
        imgO(312,311,B) = 0;

        % Simple Blue
        imgO(312,354,R) = 0;
        imgO(312,354,G) = 255;
        imgO(312,354,B) = 0;

        % Simple Orange
        imgO(311,395,R) = 0;
        imgO(311,395,G) = 255;
        imgO(311,395,B) = 0;

        % Rastro Vermelho
        imgO(293,275,R) = 0;
        imgO(293,275,G) = 255;
        imgO(293,275,B) = 0;
        imgO(292,275,R) = 0;
        imgO(292,275,G) = 255;
        imgO(292,275,B) = 0;
        imgO(291,275,R) = 0;
        imgO(291,275,G) = 255;
        imgO(291,275,B) = 0;
        imgO(290,276,R) = 0;
        imgO(290,276,G) = 255;
        imgO(290,276,B) = 0;
        imgO(289,276,R) = 0;
        imgO(289,276,G) = 255;
        imgO(289,276,B) = 0;
        imgO(288,276,R) = 0;
        imgO(288,276,G) = 255;
        imgO(288,276,B) = 0;
        imgO(287,276,R) = 0;
        imgO(287,276,G) = 255;
        imgO(287,276,B) = 0;
        imgO(286,276,R) = 0;
        imgO(286,276,G) = 255;
        imgO(286,276,B) = 0;
        imgO(285,277,R) = 0;
        imgO(285,277,G) = 255;
        imgO(285,277,B) = 0;
        imgO(284,277,R) = 0;
        imgO(284,277,G) = 255;
        imgO(284,277,B) = 0;
        imgO(283,277,R) = 0;
        imgO(283,277,G) = 255;
        imgO(283,277,B) = 0;
        imgO(282,277,R) = 0;
        imgO(282,277,G) = 255;
        imgO(282,277,B) = 0;
        imgO(281,278,R) = 0;
        imgO(281,278,G) = 255;
        imgO(281,278,B) = 0;
        
        imagesc(imgO);
    end
end