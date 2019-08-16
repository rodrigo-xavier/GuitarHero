function [note_time, trail_time] = detect_times(vid)
    disp("Detectando os tempos.");

    % Define number of samples
    note_max        = 20;

    % Initialize zero
    queue_trail     = {};
    queue_note      = {};
    temp            = {};
    timer_of_trail  = 0;
    timer_of_note   = 0;
    note            = 0;

    % Initialize patterns
    R               = 1;
    G               = 2;
    B               = 3;

    red_min         = 175;
    red_max         = 255;
    green_min       = 175;
    green_max       = 255;
    yellowR_min     = 175;
    yellowR_max     = 255;
    yellowG_min     = 150;
    yellowG_max     = 255;
    blueG_min       = 125;
    blueG_max       = 255;
    blueB_min       = 175;
    blueB_max       = 255;
    orangeR_min     = 175;
    orangeR_max     = 255;
    orangeG_min     = 175;
    orangeG_max     = 255;

    % Flags
    counter     = 0;

    while (note < note_max)
        imgO = getdata(vid,1,'uint8');

        % Detecta pixels 1 e 2 com diferença de 6 pixels 
        % para garantir que existe uma única nota, e não 6 notas

        greenPixelUp        = imgO(287,238,G);
        greenPixelUp2        = imgO(293,238,G);
        greenPixelMiddle    = imgO(306,230,G);
        greenPixelMiddle2    = imgO(312,230,G);
        greenPixelDown      = imgO(406,185,G);
        greenPixelDown2      = imgO(412,185,G);

        redPixelUp          = imgO(287,275,R);
        redPixelUp2          = imgO(293,275,R);
        redPixelMiddle      = imgO(305,274,R);
        redPixelMiddle2      = imgO(311,274,R);
        redPixelDown        = imgO(405,250,R);
        redPixelDown2        = imgO(411,250,R);

        yellowPixelRUp      = imgO(287,312,R);
        yellowPixelRUp2      = imgO(293,312,R);
        yellowPixelGUp      = imgO(287,312,G);
        yellowPixelGUp2      = imgO(293,312,G);
        yellowPixelRMiddle  = imgO(306,311,R);
        yellowPixelRMiddle2  = imgO(312,311,R);
        yellowPixelGMiddle  = imgO(306,311,G);
        yellowPixelGMiddle2  = imgO(312,311,G);
        yellowPixelRDown    = imgO(405,313,R);
        yellowPixelRDown2    = imgO(411,313,R);
        yellowPixelGDown    = imgO(405,313,G);
        yellowPixelGDown2    = imgO(411,313,G);

        bluePixelGUp        = imgO(287,349,G);
        bluePixelGUp2        = imgO(293,349,G);
        bluePixelBUp        = imgO(287,349,B);
        bluePixelBUp2        = imgO(293,349,B);
        bluePixelGMiddle    = imgO(306,354,G);
        bluePixelGMiddle2    = imgO(312,354,G);
        bluePixelBMiddle    = imgO(306,354,B);
        bluePixelBMiddle2    = imgO(312,354,B);
        bluePixelGDown      = imgO(405,376,G);
        bluePixelGDown2      = imgO(411,376,G);
        bluePixelBDown      = imgO(405,376,B);
        bluePixelBDown2      = imgO(411,376,B);

        orangePixelRUp      = imgO(287,387,R);
        orangePixelRUp2      = imgO(293,387,R);
        orangePixelGUp      = imgO(287,387,G);
        orangePixelGUp2      = imgO(293,387,G);
        orangePixelRMiddle  = imgO(305,395,R);
        orangePixelRMiddle2  = imgO(311,395,R);
        orangePixelGMiddle  = imgO(305,395,G);
        orangePixelGMiddle2  = imgO(311,395,G);
        orangePixelRDown    = imgO(405,440,R);
        orangePixelRDown2    = imgO(411,440,R);
        orangePixelGDown    = imgO(405,440,G);
        orangePixelGDown2    = imgO(411,440,G);

        % Se passar um rastro em qualquer trilha, então fudeu, apenas inicie do zero
        % Não conteste o ensinamento acima
        % Detect if not a trail then detect if is a note
        if(((imgO(293,238,G) >= green_min && imgO(293,238,G) <= green_max) && ...
        (imgO(292,238,G) >= green_min && imgO(292,238,G) <= green_max) && ...
        (imgO(291,239,G) >= green_min && imgO(291,239,G) <= green_max) && ...
        (imgO(290,239,G) >= green_min && imgO(290,239,G) <= green_max) && ...
        (imgO(289,239,G) >= green_min && imgO(289,239,G) <= green_max) && ...
        (imgO(288,240,G) >= green_min && imgO(288,240,G) <= green_max) && ...
        (imgO(287,240,G) >= green_min && imgO(287,240,G) <= green_max) && ...
        (imgO(286,240,G) >= green_min && imgO(286,240,G) <= green_max) && ...
        (imgO(285,241,G) >= green_min && imgO(285,241,G) <= green_max) && ...
        (imgO(284,241,G) >= green_min && imgO(284,241,G) <= green_max) && ...
        (imgO(283,241,G) >= green_min && imgO(283,241,G) <= green_max) && ...
        (imgO(282,242,G) >= green_min && imgO(282,242,G) <= green_max) && ...
        (imgO(281,243,G) >= green_min && imgO(281,243,G) <= green_max) || ...
        (imgO(293,275,R) >= red_min && imgO(293,275,R) <= red_max) && ...
        (imgO(292,275,R) >= red_min && imgO(292,275,R) <= red_max) && ...
        (imgO(291,275,R) >= red_min && imgO(291,275,R) <= red_max) && ...
        (imgO(290,276,R) >= red_min && imgO(290,276,R) <= red_max) && ...
        (imgO(289,276,R) >= red_min && imgO(289,276,R) <= red_max) && ...
        (imgO(288,276,R) >= red_min && imgO(288,276,R) <= red_max) && ...
        (imgO(287,276,R) >= red_min && imgO(287,276,R) <= red_max) && ...
        (imgO(286,276,R) >= red_min && imgO(286,276,R) <= red_max) && ...
        (imgO(285,277,R) >= red_min && imgO(285,277,R) <= red_max) && ...
        (imgO(284,277,R) >= red_min && imgO(284,277,R) <= red_max) && ...
        (imgO(283,277,R) >= red_min && imgO(283,277,R) <= red_max) && ...
        (imgO(282,277,R) >= red_min && imgO(282,277,R) <= red_max) && ...
        (imgO(281,278,R) >= red_min && imgO(281,278,R) <= red_max) || ...
        (imgO(293,312,R) >= yellowR_min && imgO(293,312,R) <= yellowR_max) && ...
        (imgO(293,312,G) >= yellowG_min && imgO(293,312,G) <= yellowG_max) && ...
        (imgO(292,312,R) >= yellowR_min && imgO(292,312,R) <= yellowR_max) && ...
        (imgO(292,312,G) >= yellowG_min && imgO(292,312,G) <= yellowG_max) && ...
        (imgO(291,312,R) >= yellowR_min && imgO(291,312,R) <= yellowR_max) && ...
        (imgO(291,312,G) >= yellowG_min && imgO(291,312,G) <= yellowG_max) && ...
        (imgO(290,312,R) >= yellowR_min && imgO(290,312,R) <= yellowR_max) && ...
        (imgO(290,312,G) >= yellowG_min && imgO(290,312,G) <= yellowG_max) && ...
        (imgO(289,312,R) >= yellowR_min && imgO(289,312,R) <= yellowR_max) && ...
        (imgO(289,312,G) >= yellowG_min && imgO(289,312,G) <= yellowG_max) && ...
        (imgO(288,312,R) >= yellowR_min && imgO(288,312,R) <= yellowR_max) && ...
        (imgO(288,312,G) >= yellowG_min && imgO(288,312,G) <= yellowG_max) && ...
        (imgO(287,312,R) >= yellowR_min && imgO(287,312,R) <= yellowR_max) && ...
        (imgO(287,312,G) >= yellowG_min && imgO(287,312,G) <= yellowG_max) && ...
        (imgO(286,312,R) >= yellowR_min && imgO(286,312,R) <= yellowR_max) && ...
        (imgO(286,312,G) >= yellowG_min && imgO(286,312,G) <= yellowG_max) && ...
        (imgO(285,312,R) >= yellowR_min && imgO(285,312,R) <= yellowR_max) && ...
        (imgO(285,312,G) >= yellowG_min && imgO(285,312,G) <= yellowG_max) && ...
        (imgO(284,312,R) >= yellowR_min && imgO(284,312,R) <= yellowR_max) && ...
        (imgO(284,312,G) >= yellowG_min && imgO(284,312,G) <= yellowG_max) && ...
        (imgO(283,312,R) >= yellowR_min && imgO(283,312,R) <= yellowR_max) && ...
        (imgO(283,312,G) >= yellowG_min && imgO(283,312,G) <= yellowG_max) && ...
        (imgO(282,312,R) >= yellowR_min && imgO(282,312,R) <= yellowR_max) && ...
        (imgO(282,312,G) >= yellowG_min && imgO(282,312,G) <= yellowG_max) && ...
        (imgO(281,312,R) >= yellowR_min && imgO(281,312,R) <= yellowR_max) && ...
        (imgO(281,312,G) >= yellowG_min && imgO(281,312,G) <= yellowG_max) || ...
        (imgO(291,349,B) >= blueB_min && imgO(291,349,B) <= blueB_max) && ...
        (imgO(291,349,G) >= blueG_min && imgO(291,349,G) <= blueG_max) && ...
        (imgO(290,349,B) >= blueB_min && imgO(290,349,B) <= blueB_max) && ...
        (imgO(290,349,G) >= blueG_min && imgO(290,349,G) <= blueG_max) && ...
        (imgO(289,349,B) >= blueB_min && imgO(289,349,B) <= blueB_max) && ...
        (imgO(289,349,G) >= blueG_min && imgO(289,349,G) <= blueG_max) && ...
        (imgO(288,349,B) >= blueB_min && imgO(288,349,B) <= blueB_max) && ...
        (imgO(288,349,G) >= blueG_min && imgO(288,349,G) <= blueG_max) && ...
        (imgO(287,349,B) >= blueB_min && imgO(287,349,B) <= blueB_max) && ...
        (imgO(287,349,G) >= blueG_min && imgO(287,349,G) <= blueG_max) && ...
        (imgO(286,349,B) >= blueB_min && imgO(286,349,B) <= blueB_max) && ...
        (imgO(286,349,G) >= blueG_min && imgO(286,349,G) <= blueG_max) && ...
        (imgO(285,348,B) >= blueB_min && imgO(285,348,B) <= blueB_max) && ...
        (imgO(285,348,G) >= blueG_min && imgO(285,348,G) <= blueG_max) && ...
        (imgO(284,348,B) >= blueB_min && imgO(284,348,B) <= blueB_max) && ...
        (imgO(284,348,G) >= blueG_min && imgO(284,348,G) <= blueG_max) && ...
        (imgO(283,348,B) >= blueB_min && imgO(283,348,B) <= blueB_max) && ...
        (imgO(283,348,G) >= blueG_min && imgO(283,348,G) <= blueG_max) && ...
        (imgO(282,348,B) >= blueB_min && imgO(282,348,B) <= blueB_max) && ...
        (imgO(282,348,G) >= blueG_min && imgO(282,348,G) <= blueG_max) && ...
        (imgO(281,348,B) >= blueB_min && imgO(281,348,B) <= blueB_max) && ...
        (imgO(281,348,G) >= blueG_min && imgO(281,348,G) <= blueG_max) && ...
        (imgO(280,348,B) >= blueB_min && imgO(280,348,B) <= blueB_max) && ...
        (imgO(280,348,G) >= blueG_min && imgO(280,348,G) <= blueG_max) && ...
        (imgO(279,348,B) >= blueB_min && imgO(279,348,B) <= blueB_max) && ...
        (imgO(279,348,G) >= blueG_min && imgO(279,348,G) <= blueG_max) || ...
        (imgO(294,387,R) >= orangeR_min && imgO(294,387,G) <= orangeR_max) && ...
        (imgO(294,387,G) >= orangeG_min && imgO(294,387,G) <= orangeG_max) && ...
        (imgO(293,387,R) >= orangeR_min && imgO(293,387,R) <= orangeR_max) && ...
        (imgO(293,387,G) >= orangeG_min && imgO(293,387,G) <= orangeG_max) && ...
        (imgO(292,386,R) >= orangeR_min && imgO(292,386,R) <= orangeR_max) && ...
        (imgO(292,386,G) >= orangeG_min && imgO(292,386,G) <= orangeG_max) && ...
        (imgO(291,386,R) >= orangeR_min && imgO(291,386,R) <= orangeR_max) && ...
        (imgO(291,386,G) >= orangeG_min && imgO(291,386,G) <= orangeG_max) && ...
        (imgO(290,386,R) >= orangeR_min && imgO(290,386,R) <= orangeR_max) && ...
        (imgO(290,386,G) >= orangeG_min && imgO(290,386,G) <= orangeG_max) && ...
        (imgO(289,385,R) >= orangeR_min && imgO(289,385,R) <= orangeR_max) && ...
        (imgO(289,385,G) >= orangeG_min && imgO(289,385,G) <= orangeG_max) && ...
        (imgO(288,385,R) >= orangeR_min && imgO(288,385,R) <= orangeR_max) && ...
        (imgO(288,385,G) >= orangeG_min && imgO(288,385,G) <= orangeG_max) && ...
        (imgO(287,385,R) >= orangeR_min && imgO(287,385,R) <= orangeR_max) && ...
        (imgO(287,385,G) >= orangeG_min && imgO(287,385,G) <= orangeG_max) && ...
        (imgO(286,384,R) >= orangeR_min && imgO(286,384,R) <= orangeR_max) && ...
        (imgO(286,384,G) >= orangeG_min && imgO(286,384,G) <= orangeG_max) && ...
        (imgO(285,384,R) >= orangeR_min && imgO(285,384,R) <= orangeR_max) && ...
        (imgO(285,384,G) >= orangeG_min && imgO(285,384,G) <= orangeG_max) && ...
        (imgO(284,384,R) >= orangeR_min && imgO(284,384,R) <= orangeR_max) && ...
        (imgO(284,384,G) >= orangeG_min && imgO(284,384,G) <= orangeG_max) && ...
        (imgO(283,383,R) >= orangeR_min && imgO(283,383,R) <= orangeR_max) && ...
        (imgO(283,383,G) >= orangeG_min && imgO(283,383,G) <= orangeG_max) && ...
        (imgO(282,382,R) >= orangeR_min && imgO(282,382,R) <= orangeR_max) && ...
        (imgO(282,382,G) >= orangeG_min && imgO(282,382,G) <= orangeG_max) ))

            % Initialize zero
            queue_trail = {};
            queue_note = {};
            temp = {};

        else
            flag_green_Up = (greenPixelUp >= green_min && greenPixelUp <= green_max).*true + false;
            flag_red_Up = (redPixelUp >= red_min && redPixelUp <= red_max).*true + false;
            flag_yellow_Up = (yellowPixelRUp >= yellowR_min && yellowPixelRUp <= yellowR_max && yellowPixelGUp >= yellowG_min && yellowPixelGUp <= yellowG_max).*true + false;
            flag_blue_Up = (bluePixelGUp >= blueR_min && bluePixelGUp <= blueR_max && bluePixelBUp >= blueG_min && bluePixelBUp <= blueG_max).*true + false;
            flag_orange_Up = (orangePixelRUp >= orangeR_min && orangePixelRUp <= orangeR_max && orangePixelGUp >= orangeG_min && orangePixelGUp <= orangeG_max).*true + false;

            if(flag_green_Up && ~(greenPixelUp >= green_min && greenPixelUp <= green_max))
                queue_trail{end + 1} = tic;
                flag_green_Up = false;
            end
            if(flag_red_Up && ~(redPixelUp >= red_min && redPixelUp <= red_max))
                queue_trail{end + 1} = tic;
                flag_red_Up = false;
            end
            if(flag_yellow_Up && 
            ~(yellowPixelRUp >= yellowR_min && yellowPixelRUp <= yellowR_max && 
            yellowPixelGUp >= yellowG_min && yellowPixelGUp <= yellowG_max))
                queue_trail{end + 1} = tic;
                flag_yellow_Up = false;
            end
            if(flag_blue_Up && 
            ~(bluePixelGUp >= blueR_min && bluePixelGUp <= blueR_max && 
            bluePixelBUp >= blueG_min && bluePixelBUp <= blueG_max)) ||
                queue_trail{end + 1} = tic;
                flag_blue_Up = false;
            end
            if(flag_orange_Up && 
            ~(orangePixelRUp >= orangeR_min && orangePixelRUp <= orangeR_max && 
            orangePixelGUp >= orangeG_min && orangePixelGUp <= orangeG_max))
                queue_trail{end + 1} = tic;
                flag_orange_Up = false;
            end
            
            flag_green_middle = (greenPixelMiddle >= green_min && greenPixelMiddle <= green_max).*true + false;
            flag_red_middle = (redPixelMiddle >= red_min && redPixelMiddle <= red_max).*true + false;
            flag_yellow_middle = (yellowPixelRMiddle >= yellowR_min && yellowPixelRMiddle <= yellowR_max && yellowPixelGMiddle >= yellowG_min && yellowPixelGMiddle <= yellowG_max).*true + false;
            flag_blue_middle = (bluePixelGMiddle >= blueR_min && bluePixelGMiddle <= blueR_max && bluePixelBMiddle >= blueG_min && bluePixelBMiddle <= blueG_max).*true + false;
            flag_orange_middle = (orangePixelRMiddle >= orangeR_min && orangePixelRMiddle <= orangeR_max && orangePixelGMiddle >= orangeG_min && orangePixelGMiddle <= orangeG_max).*true + false;

            if(flag_green_middle && ~(greenPixelMiddle >= green_min && greenPixelMiddle <= green_max))
                % Push time trail
                temp{end + 1} = toc(queue_trail{1});
                % Pop trail
                queue_trail = queue_trail(2:end);
                % Push note
                queue_note{end + 1} = tic;

                flag_green_middle = false;
            end

            if(flag_red_middle && ~(redPixelMiddle >= red_min && redPixelMiddle <= red_max))
                % Push time trail
                temp{end + 1} = toc(queue_trail{1});
                % Pop trail
                queue_trail = queue_trail(2:end);
                % Push note
                queue_note{end + 1} = tic;

                flag_red_middle = false;
            end

            if(flag_yellow_middle && 
            ~(yellowPixelRMiddle >= yellowR_min && yellowPixelRMiddle <= yellowR_max && 
            yellowPixelGMiddle >= yellowG_min && yellowPixelGMiddle <= yellowG_max))
                % Push time trail
                temp{end + 1} = toc(queue_trail{1});
                % Pop trail
                queue_trail = queue_trail(2:end);
                % Push note
                queue_note{end + 1} = tic;

                flag_yellow_middle = false;
            end

            if(flag_blue_middle && 
            ~(bluePixelGMiddle >= blueR_min && bluePixelGMiddle <= blueR_max && 
            bluePixelBMiddle >= blueG_min && bluePixelBMiddle <= blueG_max)) ||
                % Push time trail
                temp{end + 1} = toc(queue_trail{1});
                % Pop trail
                queue_trail = queue_trail(2:end);
                % Push note
                queue_note{end + 1} = tic;

                flag_blue_middle = false;
            end

            if(flag_orange_middle && 
            ~(orangePixelRMiddle >= orangeR_min && orangePixelRMiddle <= orangeR_max && 
            orangePixelGMiddle >= orangeG_min && orangePixelGMiddle <= orangeG_max))
                % Push time trail
                temp{end + 1} = toc(queue_trail{1});
                % Pop trail
                queue_trail = queue_trail(2:end);
                % Push note
                queue_note{end + 1} = tic;

                flag_orange_middle = false;
            end

            flag_green_Down = (greenPixelDown >= green_min && greenPixelDown <= green_max).*true + false;
            flag_red_Down = (redPixelDown >= red_min && redPixelDown <= red_max).*true + false;
            flag_yellow_Down = (yellowPixelRDown >= yellowR_min && yellowPixelRDown <= yellowR_max && yellowPixelGDown >= yellowG_min && yellowPixelGDown <= yellowG_max).*true + false;
            flag_blue_Down = (bluePixelGDown >= blueR_min && bluePixelGDown <= blueR_max && bluePixelBDown >= blueG_min && bluePixelBDown <= blueG_max).*true + false;
            flag_orange_Down = (orangePixelRDown >= orangeR_min && orangePixelRDown <= orangeR_max && orangePixelGDown >= orangeG_min && orangePixelGDown <= orangeG_max).*true + false;

            if(flag_green_Down && ~(greenPixelDown >= green_min && greenPixelDown <= green_max))
                % Calculate time trail
                timer_of_trail = temp{1} + timer_of_trail;
                % Calculate time note
                timer_of_note = toc(queue_note{1}) + timer_of_note;
                % Pop time trail
                temp = temp(2:end);
                % Pop note
                queue_note = queue_note(2:end);
                % Counter while
                note = note + 1;
                flag_green_Down = false;
            end
            if(flag_red_Down && ~(redPixelDown >= red_min && redPixelDown <= red_max))
                % Calculate time trail
                timer_of_trail = temp{1} + timer_of_trail;
                % Calculate time note
                timer_of_note = toc(queue_note{1}) + timer_of_note;
                % Pop time trail
                temp = temp(2:end);
                % Pop note
                queue_note = queue_note(2:end);
                % Counter while
                note = note + 1;
                flag_red_Down = false;
            end
            if(flag_yellow_Down && 
            ~(yellowPixelRDown >= yellowR_min && yellowPixelRDown <= yellowR_max && 
            yellowPixelGDown >= yellowG_min && yellowPixelGDown <= yellowG_max))
                % Calculate time trail
                timer_of_trail = temp{1} + timer_of_trail;
                % Calculate time note
                timer_of_note = toc(queue_note{1}) + timer_of_note;
                % Pop time trail
                temp = temp(2:end);
                % Pop note
                queue_note = queue_note(2:end);
                % Counter while
                note = note + 1;
                flag_yellow_Down = false;
            end
            if(flag_blue_Down && 
            ~(bluePixelGDown >= blueR_min && bluePixelGDown <= blueR_max && 
            bluePixelBDown >= blueG_min && bluePixelBDown <= blueG_max)) ||
                % Calculate time trail
                timer_of_trail = temp{1} + timer_of_trail;
                % Calculate time note
                timer_of_note = toc(queue_note{1}) + timer_of_note;
                % Pop time trail
                temp = temp(2:end);
                % Pop note
                queue_note = queue_note(2:end);
                % Counter while
                note = note + 1;
                flag_blue_Down = false;
            end
            if(flag_orange_Down && 
            ~(orangePixelRDown >= orangeR_min && orangePixelRDown <= orangeR_max && 
            orangePixelGDown >= orangeG_min && orangePixelGDown <= orangeG_max))
                % Calculate time trail
                timer_of_trail = temp{1} + timer_of_trail;
                % Calculate time note
                timer_of_note = toc(queue_note{1}) + timer_of_note;
                % Pop time trail
                temp = temp(2:end);
                % Pop note
                queue_note = queue_note(2:end);
                % Counter while
                note = note + 1;
                flag_orange_Down = false;
            end
        end
    end

    trail_time = (timer_of_note + timer_of_trail)/note;
    note_time = timer_of_note/note;
end