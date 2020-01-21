classdef Play
    properties (Constant)
        % cores
        R = 1;
        G = 2;
        B = 3;

        % colors configuration
        red_min = 175;
        red_max = 255;
        green_min = 175;
        green_max = 255;
        yellowR_min = 175;
        yellowR_max = 255;
        yellowG_min = 150;
        yellowG_max = 255;
        blueG_min = 125;
        blueG_max = 255;
        blueB_min = 175;
        blueB_max = 255;
        orangeR_min = 175;
        orangeR_max = 255;
        orangeG_min = 95;
        orangeG_max = 255;
    end

    properties (Access = public)
        note_green = false;
        note_red = false;
        note_blue = false;
        note_yellow = false;
        note_orange = false;

        trail_green = false;
        trail_red = false;
        trail_blue = false;
        trail_yellow = false;
        trail_orange = false;

        greenPixel = 0;
        redPixel = 0;
        yellowPixelR = 0;
        yellowPixelG = 0;
        bluePixelG = 0;
        bluePixelB = 0;
        orangePixelR = 0;
        orangePixelG = 0;

        arduino;
        imgO;
    end

    methods
        function arduino = Play(ino)
            play.arduino = ino;
        end

        function imgO = get_pixels(play, video)
            play.imgO = getdata(video,1,'uint8');

            play.greenPixel = play.imgO(312,230,play.G);
            play.redPixel = play.imgO(311,274,play.R);
            play.yellowPixelR = play.imgO(312,311,play.R);
            play.yellowPixelG = play.imgO(312,311,play.G);
            play.bluePixelG = play.imgO(312,354,play.G);
            play.bluePixelB = play.imgO(312,354,play.B);
            play.orangePixelR = play.imgO(311,395,play.R);
            play.orangePixelG = play.imgO(311,395,play.G);
        end

        function set_up(play)
            %detect green
            disp(play);
            if ((play.greenPixel >= play.green_min) && (play.greenPixel <= play.green_max))
                find_trail_green();
                play.note_green = true;
                disp("passando 2");
            end

            %detect red
            if ((play.redPixel >= play.red_min) && (play.redPixel <= play.red_max))
                find_trail_red();
                play.note_red = true;
            end

            %detect yellow
            if ((play.yellowPixelR >= play.yellowR_min) && (play.yellowPixelR <= play.yellowR_max) && ...
                (play.yellowPixelG >= play.yellowG_min) && (play.yellowPixelG <= play.yellowG_max))
                find_trail_yellow();
                play.note_yellow = true;
            end

            %detect blue
            if ((play.bluePixelG >= play.blueG_min) && (play.bluePixelG <= play.blueG_max) && ...
                (play.bluePixelB >= play.blueB_min) && (play.bluePixelB <= play.blueB_max))
                find_trail_blue();
                play.note_blue = true;
            end

            %detect orange
            if ((play.orangePixelR >= play.orangeR_min) && (play.orangePixelR <= play.orangeR_max) && ...
                (play.orangePixelG >= play.orangeG_min) && (play.orangePixelG <= play.orangeG_max))
                find_trail_orange();
                play.note_orange = true;
            end
        end
        
        function find_trail_green()
            if ((play.imgO(293,238,play.G) >= play.green_min) && (play.imgO(293,238,play.G) <= play.green_max) && ...
                (play.imgO(292,238,play.G) >= play.green_min) && (play.imgO(292,238,play.G) <= play.green_max) && ...
                (play.imgO(291,239,play.G) >= play.green_min) && (play.imgO(291,239,play.G) <= play.green_max) && ...
                (play.imgO(290,239,play.G) >= play.green_min) && (play.imgO(290,239,play.G) <= play.green_max) && ...
                (play.imgO(289,239,play.G) >= play.green_min) && (play.imgO(289,239,play.G) <= play.green_max) && ...
                (play.imgO(288,240,play.G) >= play.green_min) && (play.imgO(288,240,play.G) <= play.green_max) && ...
                (play.imgO(287,240,play.G) >= play.green_min) && (play.imgO(287,240,play.G) <= play.green_max) && ...
                (play.imgO(286,240,play.G) >= play.green_min) && (play.imgO(286,240,play.G) <= play.green_max) && ...
                (play.imgO(285,241,play.G) >= play.green_min) && (play.imgO(285,241,play.G) <= play.green_max) && ...
                (play.imgO(284,241,play.G) >= play.green_min) && (play.imgO(284,241,play.G) <= play.green_max) && ...
                (play.imgO(283,241,play.G) >= play.green_min) && (play.imgO(283,241,play.G) <= play.green_max) && ...
                (play.imgO(282,242,play.G) >= play.green_min) && (play.imgO(282,242,play.G) <= play.green_max) && ...
                (play.imgO(281,243,play.G) >= play.green_min) && (play.imgO(281,243,play.G) <= play.green_max))
                send_command(play.arduino, "0000010000000000");
                play.trail_green = true;
            end
        end

        function find_trail_red()
            if ((play.imgO(293,275,play.R) >= play.red_min) && (play.imgO(293,275,play.R) <= play.red_max) && ...
                (play.imgO(292,275,play.R) >= play.red_min) && (play.imgO(292,275,play.R) <= play.red_max) && ...
                (play.imgO(291,275,play.R) >= play.red_min) && (play.imgO(291,275,play.R) <= play.red_max) && ...
                (play.imgO(290,276,play.R) >= play.red_min) && (play.imgO(290,276,play.R) <= play.red_max) && ...
                (play.imgO(289,276,play.R) >= play.red_min) && (play.imgO(289,276,play.R) <= play.red_max) && ...
                (play.imgO(288,276,play.R) >= play.red_min) && (play.imgO(288,276,play.R) <= play.red_max) && ...
                (play.imgO(287,276,play.R) >= play.red_min) && (play.imgO(287,276,play.R) <= play.red_max) && ...
                (play.imgO(286,276,play.R) >= play.red_min) && (play.imgO(286,276,play.R) <= play.red_max) && ...
                (play.imgO(285,277,play.R) >= play.red_min) && (play.imgO(285,277,play.R) <= play.red_max) && ...
                (play.imgO(284,277,play.R) >= play.red_min) && (play.imgO(284,277,play.R) <= play.red_max) && ...
                (play.imgO(283,277,play.R) >= play.red_min) && (play.imgO(283,277,play.R) <= play.red_max) && ...
                (play.imgO(282,277,play.R) >= play.red_min) && (play.imgO(282,277,play.R) <= play.red_max) && ...
                (play.imgO(281,278,play.R) >= play.red_min) && (play.imgO(281,278,play.R) <= play.red_max))
                send_command(play.arduino, "0000001000000000");
                play.trail_red = true;
            end
        end

        function find_trail_yellow()
            if ((play.imgO(293,312,play.R) >= play.yellowR_min) && (play.imgO(293,312,play.R) <= play.yellowR_max) && ...
                (play.imgO(293,312,play.G) >= play.yellowG_min) && (play.imgO(293,312,play.G) <= play.yellowG_max) && ...
                (play.imgO(292,312,play.R) >= play.yellowR_min) && (play.imgO(292,312,play.R) <= play.yellowR_max) && ...
                (play.imgO(292,312,play.G) >= play.yellowG_min) && (play.imgO(292,312,play.G) <= play.yellowG_max) && ...
                (play.imgO(291,312,play.R) >= play.yellowR_min) && (play.imgO(291,312,play.R) <= play.yellowR_max) && ...
                (play.imgO(291,312,play.G) >= play.yellowG_min) && (play.imgO(291,312,play.G) <= play.yellowG_max) && ...
                (play.imgO(290,312,play.R) >= play.yellowR_min) && (play.imgO(290,312,play.R) <= play.yellowR_max) && ...
                (play.imgO(290,312,play.G) >= play.yellowG_min) && (play.imgO(290,312,play.G) <= play.yellowG_max) && ...
                (play.imgO(289,312,play.R) >= play.yellowR_min) && (play.imgO(289,312,play.R) <= play.yellowR_max) && ...
                (play.imgO(289,312,play.G) >= play.yellowG_min) && (play.imgO(289,312,play.G) <= play.yellowG_max) && ...
                (play.imgO(288,312,play.R) >= play.yellowR_min) && (play.imgO(288,312,play.R) <= play.yellowR_max) && ...
                (play.imgO(288,312,play.G) >= play.yellowG_min) && (play.imgO(288,312,play.G) <= play.yellowG_max) && ...
                (play.imgO(287,312,play.R) >= play.yellowR_min) && (play.imgO(287,312,play.R) <= play.yellowR_max) && ...
                (play.imgO(287,312,play.G) >= play.yellowG_min) && (play.imgO(287,312,play.G) <= play.yellowG_max) && ...
                (play.imgO(286,312,play.R) >= play.yellowR_min) && (play.imgO(286,312,play.R) <= play.yellowR_max) && ...
                (play.imgO(286,312,play.G) >= play.yellowG_min) && (play.imgO(286,312,play.G) <= play.yellowG_max) && ...
                (play.imgO(285,312,play.R) >= play.yellowR_min) && (play.imgO(285,312,play.R) <= play.yellowR_max) && ...
                (play.imgO(285,312,play.G) >= play.yellowG_min) && (play.imgO(285,312,play.G) <= play.yellowG_max) && ...
                (play.imgO(284,312,play.R) >= play.yellowR_min) && (play.imgO(284,312,play.R) <= play.yellowR_max) && ...
                (play.imgO(284,312,play.G) >= play.yellowG_min) && (play.imgO(284,312,play.G) <= play.yellowG_max) && ...
                (play.imgO(283,312,play.R) >= play.yellowR_min) && (play.imgO(283,312,play.R) <= play.yellowR_max) && ...
                (play.imgO(283,312,play.G) >= play.yellowG_min) && (play.imgO(283,312,play.G) <= play.yellowG_max) && ...
                (play.imgO(282,312,play.R) >= play.yellowR_min) && (play.imgO(282,312,play.R) <= play.yellowR_max) && ...
                (play.imgO(282,312,play.G) >= play.yellowG_min) && (play.imgO(282,312,play.G) <= play.yellowG_max) && ...
                (play.imgO(281,312,play.R) >= play.yellowR_min) && (play.imgO(281,312,play.R) <= play.yellowR_max) && ...
                (play.imgO(281,312,play.G) >= play.yellowG_min) && (play.imgO(281,312,play.G) <= play.yellowG_max))
                send_command(play.arduino, "0000000100000000");
                play.trail_yellow = true;
            end
        end

        function find_trail_blue()
            if ((play.imgO(291,349,play.B) >= play.blueB_min) && (play.imgO(291,349,play.B) <= play.blueB_max) && ...
                (play.imgO(291,349,play.G) >= play.blueG_min) && (play.imgO(291,349,play.G) <= play.blueG_max) && ...
                (play.imgO(290,349,play.B) >= play.blueB_min) && (play.imgO(290,349,play.B) <= play.blueB_max) && ...
                (play.imgO(290,349,play.G) >= play.blueG_min) && (play.imgO(290,349,play.G) <= play.blueG_max) && ...
                (play.imgO(289,349,play.B) >= play.blueB_min) && (play.imgO(289,349,play.B) <= play.blueB_max) && ...
                (play.imgO(289,349,play.G) >= play.blueG_min) && (play.imgO(289,349,play.G) <= play.blueG_max) && ...
                (play.imgO(288,349,play.B) >= play.blueB_min) && (play.imgO(288,349,play.B) <= play.blueB_max) && ...
                (play.imgO(288,349,play.G) >= play.blueG_min) && (play.imgO(288,349,play.G) <= play.blueG_max) && ...
                (play.imgO(287,349,play.B) >= play.blueB_min) && (play.imgO(287,349,play.B) <= play.blueB_max) && ...
                (play.imgO(287,349,play.G) >= play.blueG_min) && (play.imgO(287,349,play.G) <= play.blueG_max) && ...
                (play.imgO(286,349,play.B) >= play.blueB_min) && (play.imgO(286,349,play.B) <= play.blueB_max) && ...
                (play.imgO(286,349,play.G) >= play.blueG_min) && (play.imgO(286,349,play.G) <= play.blueG_max) && ...
                (play.imgO(285,348,play.B) >= play.blueB_min) && (play.imgO(285,348,play.B) <= play.blueB_max) && ...
                (play.imgO(285,348,play.G) >= play.blueG_min) && (play.imgO(285,348,play.G) <= play.blueG_max) && ...
                (play.imgO(284,348,play.B) >= play.blueB_min) && (play.imgO(284,348,play.B) <= play.blueB_max) && ...
                (play.imgO(284,348,play.G) >= play.blueG_min) && (play.imgO(284,348,play.G) <= play.blueG_max) && ...
                (play.imgO(283,348,play.B) >= play.blueB_min) && (play.imgO(283,348,play.B) <= play.blueB_max) && ...
                (play.imgO(283,348,play.G) >= play.blueG_min) && (play.imgO(283,348,play.G) <= play.blueG_max) && ...
                (play.imgO(282,348,play.B) >= play.blueB_min) && (play.imgO(282,348,play.B) <= play.blueB_max) && ...
                (play.imgO(282,348,play.G) >= play.blueG_min) && (play.imgO(282,348,play.G) <= play.blueG_max) && ...
                (play.imgO(281,348,play.B) >= play.blueB_min) && (play.imgO(281,348,play.B) <= play.blueB_max) && ...
                (play.imgO(281,348,play.G) >= play.blueG_min) && (play.imgO(281,348,play.G) <= play.blueG_max) && ...
                (play.imgO(280,348,play.B) >= play.blueB_min) && (play.imgO(280,348,play.B) <= play.blueB_max) && ...
                (play.imgO(280,348,play.G) >= play.blueG_min) && (play.imgO(280,348,play.G) <= play.blueG_max) && ...
                (play.imgO(279,348,play.B) >= play.blueB_min) && (play.imgO(279,348,play.B) <= play.blueB_max) && ...
                (play.imgO(279,348,play.G) >= play.blueG_min) && (play.imgO(279,348,play.G) <= play.blueG_max))
                send_command(play.arduino, "0000000010000000");
                play.trail_blue = true;
            end
        end

        function find_trail_orange()
            if ((play.imgO(294,387,play.R) >= play.orangeR_min) && (play.imgO(294,387,play.G) <= play.orangeR_max) && ...
                (play.imgO(294,387,play.G) >= play.orangeG_min) && (play.imgO(294,387,play.G) <= play.orangeG_max) && ...
                (play.imgO(293,387,play.R) >= play.orangeR_min) && (play.imgO(293,387,play.R) <= play.orangeR_max) && ...
                (play.imgO(293,387,play.G) >= play.orangeG_min) && (play.imgO(293,387,play.G) <= play.orangeG_max) && ...
                (play.imgO(292,386,play.R) >= play.orangeR_min) && (play.imgO(292,386,play.R) <= play.orangeR_max) && ...
                (play.imgO(292,386,play.G) >= play.orangeG_min) && (play.imgO(292,386,play.G) <= play.orangeG_max) && ...
                (play.imgO(291,386,play.R) >= play.orangeR_min) && (play.imgO(291,386,play.R) <= play.orangeR_max) && ...
                (play.imgO(291,386,play.G) >= play.orangeG_min) && (play.imgO(291,386,play.G) <= play.orangeG_max) && ...
                (play.imgO(290,386,play.R) >= play.orangeR_min) && (play.imgO(290,386,play.R) <= play.orangeR_max) && ...
                (play.imgO(290,386,play.G) >= play.orangeG_min) && (play.imgO(290,386,play.G) <= play.orangeG_max) && ...
                (play.imgO(289,385,play.R) >= play.orangeR_min) && (play.imgO(289,385,play.R) <= play.orangeR_max) && ...
                (play.imgO(289,385,play.G) >= play.orangeG_min) && (play.imgO(289,385,play.G) <= play.orangeG_max) && ...
                (play.imgO(288,385,play.R) >= play.orangeR_min) && (play.imgO(288,385,play.R) <= play.orangeR_max) && ...
                (play.imgO(288,385,play.G) >= play.orangeG_min) && (play.imgO(288,385,play.G) <= play.orangeG_max) && ...
                (play.imgO(287,385,play.R) >= play.orangeR_min) && (play.imgO(287,385,play.R) <= play.orangeR_max) && ...
                (play.imgO(287,385,play.G) >= play.orangeG_min) && (play.imgO(287,385,play.G) <= play.orangeG_max) && ...
                (play.imgO(286,384,play.R) >= play.orangeR_min) && (play.imgO(286,384,play.R) <= play.orangeR_max) && ...
                (play.imgO(286,384,play.G) >= play.orangeG_min) && (play.imgO(286,384,play.G) <= play.orangeG_max) && ...
                (play.imgO(285,384,play.R) >= play.orangeR_min) && (play.imgO(285,384,play.R) <= play.orangeR_max) && ...
                (play.imgO(285,384,play.G) >= play.orangeG_min) && (play.imgO(285,384,play.G) <= play.orangeG_max) && ...
                (play.imgO(284,384,play.R) >= play.orangeR_min) && (play.imgO(284,384,play.R) <= play.orangeR_max) && ...
                (play.imgO(284,384,play.G) >= play.orangeG_min) && (play.imgO(284,384,play.G) <= play.orangeG_max) && ...
                (play.imgO(283,383,play.R) >= play.orangeR_min) && (play.imgO(283,383,play.R) <= play.orangeR_max) && ...
                (play.imgO(283,383,play.G) >= play.orangeG_min) && (play.imgO(283,383,play.G) <= play.orangeG_max) && ...
                (play.imgO(282,382,play.R) >= play.orangeR_min) && (play.imgO(282,382,play.R) <= play.orangeR_max) && ...
                (play.imgO(282,382,play.G) >= play.orangeG_min) && (play.imgO(282,382,play.G) <= play.orangeG_max))
                disp("passando 3");
                send_command(play.arduino, "0000000001000000");
                play.trail_orange = true;
            end
        end

        function tear_down(play)
            %detect green
            disp("passando 1");
            if ((play.note_green) && ...
                ~((play.greenPixel >= play.green_min) && (play.greenPixel <= play.green_max)))
                send_command(play.arduino, "1000000000000000");
                play.note_green = false;
            elseif ((play.trail_green) && ...
                ~((play.greenPixel >= play.green_min) && (play.greenPixel <= play.green_max)))
                send_command(play.arduino, "0000010000000000");
                play.trail_green = false;
            end

            %detect red   
            if ((play.note_red) && ...
                ~((play.redPixel >= play.red_min) && (play.redPixel <= play.red_max)))
                send_command(play.arduino, "0100000000000000");
                play.note_red = false;
            elseif ((play.trail_red) && ...
                ~((play.redPixel >= play.red_min) && (play.redPixel <= play.red_max)))
                send_command(play.arduino, "0000001000000000");
                play.trail_red = false;
            end

            %detect yellow
            if ((play.note_yellow) && ...
                ~((play.yellowPixelR >= play.yellowR_min) && (play.yellowPixelR <= play.yellowR_max) && ...
                (play.yellowPixelG >= play.yellowG_min) && (play.yellowPixelG <= play.yellowG_max)))
                send_command(play.arduino, "0010000000000000");
                play.note_yellow = false;
            elseif ((play.trail_yellow) && ...
                ~((play.yellowPixelR >= play.yellowR_min) && (play.yellowPixelR <= play.yellowR_max) && ...
                (play.yellowPixelG >= play.yellowG_min) && (play.yellowPixelG <= play.yellowG_max)))
                send_command(play.arduino, "0000000100000000");
                play.trail_yellow = false;
            end

            %detect blue
            if ((play.note_blue) && ...
                ~((play.bluePixelG >= play.blueG_min) && (play.bluePixelG <= play.blueG_max) && ...
                (play.bluePixelB >= play.blueB_min) && (play.bluePixelB <= play.blueB_max)))
                send_command(play.arduino, "0001000000000000");
                play.note_blue = false;
            elseif ((play.trail_blue) && ...
                ~((play.bluePixelG >= play.blueG_min) && (play.bluePixelG <= play.blueG_max) && ...
                (play.bluePixelB >= play.blueB_min) && (play.bluePixelB <= play.blueB_max)))
                send_command(play.arduino, "0000000010000000");
                play.trail_blue = false;
            end

            %detect orange
            if ((play.note_orange) && ...
                ~((play.orangePixelR >= play.orangeR_min) && (play.orangePixelR <= play.orangeR_max) && ...
                (play.orangePixelG >= play.orangeG_min) && (play.orangePixelG <= play.orangeG_max)))
                send_command(play.arduino, "0000100000000000");
                play.note_orange = false;
            elseif ((play.trail_orange) && ...
                ~((play.orangePixelR >= play.orangeR_min) && (play.orangePixelR <= play.orangeR_max) && ...
                (play.orangePixelG >= play.orangeG_min) && (play.orangePixelG <= play.orangeG_max)))
                send_command(play.arduino, "0000000001000000");
                play.trail_orange = false;
            end
        end
        % function img = get_imgO(y, x, color)
        %     img = play.imgO(y, x, color);
        % end
    end
end