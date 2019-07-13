function [note_time, trail_time] = detect_times(vid)
    disp("Pegando os tempos")

    note_max = 10;
    note = 0;

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

    timer_of_trail = 0;
    timer_of_note = 0;

    tictoc_min = 0.01;
    tictoc_max = 1.85;

    queue_trail = {};
    queue_note = {};
    temp = {};

    while (note < note_max)
        imgO = getdata(vid,1,'uint8');

        greenPixelUp1        = imgO(289,238,G);
        greenPixelUp2        = imgO(293,238,G);
        greenPixelMiddle1    = imgO(308,230,G);
        greenPixelMiddle2    = imgO(312,230,G);
        greenPixelDown1      = imgO(408,185,G);
        greenPixelDown2      = imgO(412,185,G);

        redPixelUp1          = imgO(289,275,R);
        redPixelUp2          = imgO(293,275,R);
        redPixelMiddle1      = imgO(307,274,R);
        redPixelMiddle2      = imgO(311,274,R);
        redPixelDown1        = imgO(407,250,R);
        redPixelDown2        = imgO(411,250,R);

        yellowPixelRUp1      = imgO(289,312,R);
        yellowPixelRUp2      = imgO(293,312,R);
        yellowPixelGUp1      = imgO(289,312,G);
        yellowPixelGUp2      = imgO(293,312,G);
        yellowPixelRMiddle1  = imgO(308,311,R);
        yellowPixelRMiddle2  = imgO(312,311,R);
        yellowPixelGMiddle1  = imgO(308,311,G);
        yellowPixelGMiddle2  = imgO(312,311,G);
        yellowPixelRDown1    = imgO(407,313,R);
        yellowPixelRDown2    = imgO(411,313,R);
        yellowPixelGDown1    = imgO(407,313,G);
        yellowPixelGDown2    = imgO(411,313,G);

        bluePixelGUp1        = imgO(289,349,G);
        bluePixelGUp2        = imgO(293,349,G);
        bluePixelBUp1        = imgO(289,349,B);
        bluePixelBUp2        = imgO(293,349,B);
        bluePixelGMiddle1    = imgO(308,354,G);
        bluePixelGMiddle2    = imgO(312,354,G);
        bluePixelBMiddle1    = imgO(308,354,B);
        bluePixelBMiddle2    = imgO(312,354,B);
        bluePixelGDown1      = imgO(407,376,G);
        bluePixelGDown2      = imgO(411,376,G);
        bluePixelBDown1      = imgO(407,376,B);
        bluePixelBDown2      = imgO(411,376,B);

        orangePixelRUp1      = imgO(293,387,R);
        orangePixelRUp2      = imgO(293,387,R);
        orangePixelGUp1      = imgO(293,387,G);
        orangePixelGUp2      = imgO(293,387,G);
        orangePixelRMiddle1  = imgO(311,395,R);
        orangePixelRMiddle2  = imgO(311,395,R);
        orangePixelGMiddle1  = imgO(311,395,G);
        orangePixelGMiddle2  = imgO(311,395,G);
        orangePixelRDown1    = imgO(411,440,R);
        orangePixelRDown2    = imgO(411,440,R);
        orangePixelGDown1    = imgO(411,440,G);
        orangePixelGDown2    = imgO(411,440,G);

        if( (imgO(293,238,G) >= green_min && imgO(293,238,G) <= green_max) && ...
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
            (imgO(282,382,G) >= orangeG_min && imgO(282,382,G) <= orangeG_max) )

            queue_trail = {};
            queue_note = {};
            temp = {};
        end

        if( greenPixelUp1    >= green_min    && greenPixelUp1     <= green_max    && ...
            greenPixelUp2    >= green_min    && greenPixelUp2     <= green_max    || ...
            redPixelUp1      >= red_min      && redPixelUp1       <= red_max      && ...
            redPixelUp2      >= red_min      && redPixelUp2       <= red_max      || ...
            yellowPixelRUp1  >= yellowR_min  && yellowPixelRUp1   <= yellowR_max  && ...
            yellowPixelRUp2  >= yellowR_min  && yellowPixelRUp2   <= yellowR_max  && ...
            yellowPixelGUp1  >= yellowG_min  && yellowPixelGUp1   <= yellowG_max  && ...
            yellowPixelGUp2  >= yellowG_min  && yellowPixelGUp2   <= yellowG_max  || ...
            bluePixelGUp1    >= blueG_min    && bluePixelGUp1     <= blueG_max    && ...
            bluePixelGUp2    >= blueG_min    && bluePixelGUp2     <= blueG_max    && ...
            bluePixelBUp1    >= blueB_min    && bluePixelBUp1     <= blueB_max    && ...
            bluePixelBUp2    >= blueB_min    && bluePixelBUp2     <= blueB_max    || ...
            orangePixelRUp1  >= orangeR_min  && orangePixelRUp1   <= orangeR_max  && ...
            orangePixelRUp2  >= orangeR_min  && orangePixelRUp2   <= orangeR_max  && ...
            orangePixelGUp1  >= orangeG_min  && orangePixelGUp1   <= orangeG_max  && ...
            orangePixelGUp2  >= orangeG_min  && orangePixelGUp2   <= orangeG_max  )

            queue_trail{end + 1} = tic;
        end

    try
        if(toc(queue_trail{1})   >= tictoc_min   && toc(queue_trail{1})   <= tictoc_max   && ...
            (greenPixelMiddle1   >= green_min    && greenPixelMiddle1     <= green_max    && ...
            greenPixelMiddle2    >= green_min    && greenPixelMiddle2     <= green_max    || ...
            redPixelMiddle1      >= red_min      && redPixelMiddle1       <= red_max      && ...
            redPixelMiddle2      >= red_min      && redPixelMiddle2       <= red_max      || ...
            yellowPixelRMiddle1  >= yellowR_min  && yellowPixelRMiddle1   <= yellowR_max  && ...
            yellowPixelRMiddle2  >= yellowR_min  && yellowPixelRMiddle2   <= yellowR_max  && ...
            yellowPixelGMiddle1  >= yellowG_min  && yellowPixelGMiddle1   <= yellowG_max  && ...
            yellowPixelGMiddle2  >= yellowG_min  && yellowPixelGMiddle2   <= yellowG_max  || ...
            bluePixelGMiddle1    >= blueG_min    && bluePixelGMiddle1     <= blueG_max    && ...
            bluePixelGMiddle2    >= blueG_min    && bluePixelGMiddle2     <= blueG_max    && ...
            bluePixelBMiddle1    >= blueB_min    && bluePixelBMiddle1     <= blueB_max    && ...
            bluePixelBMiddle2    >= blueB_min    && bluePixelBMiddle2     <= blueB_max    || ...
            orangePixelRMiddle1  >= orangeR_min  && orangePixelRMiddle1   <= orangeR_max  && ...
            orangePixelRMiddle2  >= orangeR_min  && orangePixelRMiddle2   <= orangeR_max  && ...
            orangePixelGMiddle1  >= orangeG_min  && orangePixelGMiddle1   <= orangeG_max  && ...
            orangePixelGMiddle2  >= orangeG_min  && orangePixelGMiddle2   <= orangeG_max  ))

            temp{end + 1} = toc(queue_trail{1});
            queue_trail = queue_trail(2:end);
            queue_note{end + 1} = tic;
        end

        if(toc(queue_note{1})  >= tictoc_min   && toc(queue_note{1})  <= tictoc_max   && ...
            (greenPixelDown1   >= green_min    && greenPixelDown1     <= green_max    && ...
            greenPixelDown2    >= green_min    && greenPixelDown2     <= green_max    || ...
            redPixelDown1      >= red_min      && redPixelDown1       <= red_max      && ...
            redPixelDown2      >= red_min      && redPixelDown2       <= red_max      || ...
            yellowPixelRDown1  >= yellowR_min  && yellowPixelRDown1   <= yellowR_max  && ...
            yellowPixelRDown2  >= yellowR_min  && yellowPixelRDown2   <= yellowR_max  && ...
            yellowPixelGDown1  >= yellowG_min  && yellowPixelGDown1   <= yellowG_max  && ...
            yellowPixelGDown2  >= yellowG_min  && yellowPixelGDown2   <= yellowG_max  || ...
            bluePixelGDown1    >= blueG_min    && bluePixelGDown1     <= blueG_max    && ...
            bluePixelGDown2    >= blueG_min    && bluePixelGDown2     <= blueG_max    && ...
            bluePixelBDown1    >= blueB_min    && bluePixelBDown1     <= blueB_max    && ...
            bluePixelBDown2    >= blueB_min    && bluePixelBDown2     <= blueB_max    || ...
            orangePixelRDown1  >= orangeR_min  && orangePixelRDown1   <= orangeR_max  && ...
            orangePixelRDown2  >= orangeR_min  && orangePixelRDown2   <= orangeR_max  && ...
            orangePixelGDown1  >= orangeG_min  && orangePixelGDown1   <= orangeG_max  && ...
            orangePixelGDown2  >= orangeG_min  && orangePixelGDown2   <= orangeG_max  ))
            
            timer_of_trail = temp(1) + timer_of_trail
            timer_of_note = toc(queue_note{1}) + timer_of_note
            temp = temp(2:end);
            queue_note = queue_note(2:end);
            note = note + 1;
        end
    end
end

    trail_time = (timer_of_note + timer_of_trail)/note;
    note_time = timer_of_note/note;
end