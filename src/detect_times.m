function [note_time, trail_time] = detect_times(vid)

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
    orangeG_min     = 95;
    orangeG_max     = 255;

    timer_of_trail = 0;
    timer_of_note = 0;

    tictoc_min = 0.01;
    tictoc_max = 1.85;

    queue_trail = {};
    queue_note = {};

    while (note < note_max)
        imgO = getdata(vid,1,'uint8');

        greenPixelUp        = imgO(293,238,G);
        greenPixelMiddle    = imgO(312,230,G);
        greenPixelDown      = imgO(412,185,G);

        redPixelUp          = imgO(293,275,R);
        redPixelMiddle      = imgO(311,274,R);
        redPixelDown        = imgO(411,250,R);

        yellowPixelRUp      = imgO(293,312,R);
        yellowPixelGUp      = imgO(293,312,G);
        yellowPixelRMiddle  = imgO(312,311,R);
        yellowPixelGMiddle  = imgO(312,311,G);
        yellowPixelRDown    = imgO(411,313,R);
        yellowPixelGDown    = imgO(411,313,G);

        bluePixelGUp        = imgO(293,349,G);
        bluePixelBUp        = imgO(293,349,B);
        bluePixelGMiddle    = imgO(312,354,G);
        bluePixelBMiddle    = imgO(312,354,B);
        bluePixelGDown      = imgO(411,376,G);
        bluePixelBDown      = imgO(411,376,B);

        orangePixelRUp      = imgO(293,387,R);
        orangePixelGUp      = imgO(293,387,G);
        orangePixelRMiddle  = imgO(311,395,R);
        orangePixelGMiddle  = imgO(311,395,G);
        orangePixelRDown    = imgO(411,440,R);
        orangePixelGDown    = imgO(411,440,G);

        % Implementar um for para cada if pode resolver o problema do rastro

        %detect green
        if(greenPixelUp     >= green_min    && greenPixelUp     <= green_max    || ...
            redPixelUp      >= red_min      && redPixelUp       <= red_max      || ...
            yellowPixelRUp  >= yellowR_min  && yellowPixelRUp   <= yellowR_max  && ...
            yellowPixelGUp  >= yellowG_min  && yellowPixelGUp   <= yellowG_max  || ...
            bluePixelGUp    >= blueG_min    && bluePixelGUp     <= blueG_max    && ...
            bluePixelBUp    >= blueB_min    && bluePixelBUp     <= blueB_max    || ...
            orangePixelRUp  >= orangeR_min  && orangePixelRUp   <= orangeR_max  && ...
            orangePixelGUp  >= orangeG_min  && orangePixelGUp   <= orangeG_max  )

            queue_trail{end + 1} = tic;
            
        end

        for i:length(queue_trail)
            if((greenPixelMiddle    >= green_min    && greenPixelMiddle     <= green_max   || ...
                redPixelMiddle      >= red_min      && redPixelMiddle       <= red_max      || ...
                yellowPixelRMiddle  >= yellowR_min  && yellowPixelRMiddle   <= yellowR_max  && ...
                yellowPixelGMiddle  >= yellowG_min  && yellowPixelGMiddle   <= yellowG_max  || ...
                bluePixelGMiddle    >= blueG_min    && bluePixelGMiddle     <= blueG_max    && ...
                bluePixelBMiddle    >= blueB_min    && bluePixelBMiddle     <= blueB_max    || ...
                orangePixelRMiddle  >= orangeR_min  && orangePixelRMiddle   <= orangeR_max  && ...
                orangePixelGMiddle  >= orangeG_min  && orangePixelGMiddle   <= orangeG_max) && ...
                toc(queue_trail[0]) >= tictoc_min   && toc(queue_trail[0])  <= tictoc_max   )

                temp = toc(queue_trail[0]);
                queue_trail = queue_trail(2:end);
                queue_note{end + 1} = tic;

            end
        end

        for i:length(queue_note)
            if((greenPixelDown      >= green_min    && greenPixelDown       <= green_max   || ...
                redPixelDown        >= red_min      && redPixelDown         <= red_max      || ...
                yellowPixelRDown    >= yellowR_min  && yellowPixelRDown     <= yellowR_max  && ...
                yellowPixelGDown    >= yellowG_min  && yellowPixelGDown     <= yellowG_max  || ...
                bluePixelGDown      >= blueG_min    && bluePixelGDown       <= blueG_max    && ...
                bluePixelBDown      >= blueB_min    && bluePixelBDown       <= blueB_max    || ...
                orangePixelRDown    >= orangeR_min  && orangePixelRDown     <= orangeR_max  && ...
                orangePixelGDown    >= orangeG_min  && orangePixelGDown     <= orangeG_max) && ...
                toc(queue_trail[0]) >= tictoc_min   && toc(queue_trail[0])  <= tictoc_max   )

                timer_of_trail = temp + timer_of_trail;
                timer_of_note = toc(queue_note[0]) + timer_of_note;
                note = note + 1;

                queue_note = queue_note(2:end);
            end
        end
    end

    trail_time = (timer_of_note + timer_of_trail)/note;
    note_time = n_time/note;
end



% function [note_time, trail_time] = detect_times(vid)

%     note_max = 10;
%     note = 0;

%     R               = 1;
%     G               = 2;
%     B               = 3;

%     red_min         = 175;
%     red_max         = 255;
%     green_min       = 175;
%     green_max       = 255;
%     yellowR_min     = 175;
%     yellowR_max     = 255;
%     yellowG_min     = 150;
%     yellowG_max     = 255;
%     blueG_min       = 125;
%     blueG_max       = 255;
%     blueB_min       = 175;
%     blueB_max       = 255;
%     orangeR_min     = 175;
%     orangeR_max     = 255;
%     orangeG_min     = 95;
%     orangeG_max     = 255;

%     timer_of_trail = 0;
%     timer_of_note = 0;

%     tictoc_min_trail = 0.06;
%     tictoc_min_note = 0.1;
%     tictoc_max_trail = 0.75;
%     tictoc_max_note = 1.25;
%     tictoc_g1 = tic;
%     tictoc_g2 = tic;
%     tictoc_r1 = tic;
%     tictoc_r2 = tic;
%     tictoc_y1 = tic;
%     tictoc_y2 = tic;
%     tictoc_b1 = tic;
%     tictoc_b2 = tic;
%     tictoc_o1 = tic;
%     tictoc_o2 = tic;

%     while (note < note_max)
%         imgO = getdata(vid,1,'uint8');

%         greenPixelUp        = imgO(293,238,G);
%         greenPixelMidle     = imgO(312,230,G);
%         greenPixelDown      = imgO(412,185,G);

%         redPixelUp          = imgO(293,275,R);
%         redPixelMidle       = imgO(311,274,R);
%         redPixelDown        = imgO(411,250,R);

%         yellowPixelRUp      = imgO(293,312,R);
%         yellowPixelGUp      = imgO(293,312,G);
%         yellowPixelRMidle   = imgO(312,311,R);
%         yellowPixelGMidle   = imgO(312,311,G);
%         yellowPixelRDown    = imgO(411,313,R);
%         yellowPixelGDown    = imgO(411,313,G);

%         bluePixelGUp        = imgO(293,349,G);
%         bluePixelBUp        = imgO(293,349,B);
%         bluePixelGMidle     = imgO(312,354,G);
%         bluePixelBMidle     = imgO(312,354,B);
%         bluePixelGDown      = imgO(411,376,G);
%         bluePixelBDown      = imgO(411,376,B);

%         orangePixelRUp      = imgO(293,387,R);
%         orangePixelGUp      = imgO(293,387,G);
%         orangePixelRMidle   = imgO(311,395,R);
%         orangePixelGMidle   = imgO(311,395,G);
%         orangePixelRDown    = imgO(411,440,R);
%         orangePixelGDown    = imgO(411,440,G);


%         %detect green
%         if(greenPixelUp >= green_min && greenPixelUp <= green_max)

%             tictoc_g1 = tic;
%         end
%         if(greenPixelMidle >= green_min && greenPixelMidle <= green_max && ...
%             toc(tictoc_g1) >= tictoc_min_trail && toc(tictoc_g1) <= tictoc_max_trail)

%             temp = toc(tictoc_g1);
%             tictoc_g2 = tic;
%         end
%         if(greenPixelDown >= green_min && greenPixelDown <= green_max && ...
%             toc(tictoc_g2) >= tictoc_min && toc(tictoc_g2) <= tictoc_max_note)

%             timer_of_trail = temp + timer_of_trail;
%             timer_of_note = toc(tictoc_g2) + timer_of_note;
%             note = note + 1;
%         end
                

%         %detect red    
%         if(redPixelUp >= red_min && redPixelUp <= red_max)

%             tictoc_r1 = tic;
%         end
%         if(redPixelMidle >= red_min && redPixelMidle <= red_max && ...
%             toc(tictoc_r1) >= tictoc_min_trail && toc(tictoc_r1) <= tictoc_max_trail)

%             temp = toc(tictoc_r1);
%             tictoc_r2 = tic;
%         end
%         if(redPixelDown >= red_min && redPixelDown <= red_max && ...
%             toc(tictoc_r2) >= tictoc_min_note && toc(tictoc_r2) <= tictoc_max_note)

%             timer_of_trail = temp + timer_of_trail;
%             timer_of_note = toc(tictoc_r2) + timer_of_note;
%             note = note + 1;
%         end


%         %detect yellow
%         if(yellowPixelRUp >= yellowR_min && yellowPixelRUp <= yellowR_max && ...
%             yellowPixelGUp >= yellowG_min && yellowPixelGUp <= yellowG_max)

%             tictoc_y1 = tic;
%         end
%         if(yellowPixelRMidle >= yellowR_min && yellowPixelRMidle <= yellowR_max && ...
%             yellowPixelGMidle >= yellowG_min && yellowPixelGMidle <= yellowG_max && ...
%             toc(tictoc_y1) >= tictoc_min_trail && toc(tictoc_y1) <= tictoc_max_trail)

%             temp = toc(tictoc_y1);
%             tictoc_y2 = tic;
%         end
%         if(yellowPixelRDown >= yellowR_min && yellowPixelRDown <= yellowR_max && ...
%             yellowPixelGDown >= yellowG_min && yellowPixelGDown <= yellowG_max && ...
%             toc(tictoc_y2) >= tictoc_min_note && toc(tictoc_y2) <= tictoc_max_note)

%             timer_of_trail = temp + timer_of_trail;
%             timer_of_note = toc(tictoc_y2) + timer_of_note;
%             note = note + 1;
%         end
                
                
%         %detect blue
%         if(bluePixelGUp >= blueG_min && bluePixelGUp <= blueG_max && ...
%             bluePixelBUp >= blueB_min && bluePixelBUp <= blueB_max)

%             tictoc_b1 = tic;
%         end
%         if(bluePixelGMidle >= blueG_min && bluePixelGMidle <= blueG_max && ...
%             bluePixelBMidle >= blueB_min && bluePixelBMidle <= blueB_max && ...
%             toc(tictoc_b1) >= tictoc_min_trail && toc(tictoc_b1) <= tictoc_max_trail)

%             temp = toc(tictoc_b1);
%             tictoc_b2 = tic;
%         end
%         if(bluePixelGDown >= blueG_min && bluePixelGDown <= blueG_max && ...
%             bluePixelBDown >= blueB_min && bluePixelBDown <= blueB_max && ...
%             toc(tictoc_b2) >= tictoc_min_note && toc(tictoc_b2) <= tictoc_max_note)

%             timer_of_trail = temp + timer_of_trail;
%             timer_of_note = toc(tictoc_b2) + timer_of_note;
%             note = note + 1;
%         end

                
%         %detect orange
%         if(orangePixelRUp >= orangeR_min && orangePixelRUp <= orangeR_max && ...
%             orangePixelGUp >= orangeG_min && orangePixelGUp <= orangeG_max)

%             tictoc_o1 = tic;
%         end
%         if(orangePixelRMidle >= orangeR_min && orangePixelRMidle <= orangeR_max && ...
%             orangePixelGMidle >= orangeG_min && orangePixelGMidle <= orangeG_max && ...
%             toc(tictoc_o1) >= tictoc_min_trail && toc(tictoc_o1) <= tictoc_max_trail)

%             temp = toc(tictoc_o1);
%             tictoc_o2 = tic;
%         end
%         if(orangePixelRDown >= orangeR_min && orangePixelRDown <= orangeR_max && ...
%             orangePixelGDown >= orangeG_min && orangePixelGDown <= orangeG_max && ...
%             toc(tictoc_o2) >= tictoc_min_note && toc(tictoc_o2) <= tictoc_max_note)

%             timer_of_trail = temp + timer_of_trail;
%             timer_of_note = toc(tictoc_o2) + timer_of_note;
%             note = note + 1;
%         end
%     end

%     trail_time = (timer_of_note + timer_of_trail)/note;
%     note_time = n_time/note;
% end