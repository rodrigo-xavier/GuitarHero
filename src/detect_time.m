function [time, trail_time] = detect_times(vid)
    disp("Detectando os tempos.");

    % Define o número de notas para calcular o tempo médio
    number_of_notes = 10;

    % Initialize zero
    queue_trail     = {};
    queue_note      = {};
    temp            = {};
    timer_of_trail  = 0;
    timer_of_note   = 0;
    note           = 0;

    % Inicializam os parâmetros das cores
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

    time_trail_green = 0;
    time_trail_red = 0;
    time_trail_yellow = 0;
    time_trail_blue = 0;
    time_trail_orange = 0;

    time_note_green = 0;
    time_note_red = 0;
    time_note_yellow = 0;
    time_note_blue = 0;
    time_note_orange = 0;

    tictoc_green_up = tic;
    tictoc_red_up = tic;
    tictoc_yellow_up = tic;
    tictoc_blue_up = tic;
    tictoc_orange_up = tic;

    tictoc_green_middle = tic;
    tictoc_red_middle = tic;
    tictoc_yellow_middle = tic;
    tictoc_blue_middle = tic;
    tictoc_orange_middle = tic;

    % Inicializam as flags

    flag_green_Up = false; 
    flag_red_Up = false;
    flag_yellow_Up = false;
    flag_blue_Up = false;
    flag_orange_Up = false;
    flag_green_Middle = false; 
    flag_red_Middle = false;
    flag_yellow_Middle = false;
    flag_blue_Middle = false;
    flag_orange_Middle = false;
    flag_green_Down = false; 
    flag_red_Down = false;
    flag_yellow_Down = false;
    flag_blue_Down = false;
    flag_orange_Down = false;
    
    % flag_trail_green_Up = false; 
    % flag_trail_red_Up = false;
    % flag_trail_yellow_Up = false;
    % flag_trail_blue_Up = false;
    % flag_trail_orange_Up = false;
    % flag_trail_green_Middle = false; 
    % flag_trail_red_Middle = false;
    % flag_trail_yellow_Middle = false;
    % flag_trail_blue_Middle = false;
    % flag_trail_orange_Middle = false;
    % flag_trail_green_Down = false; 
    % flag_trail_red_Down = false;
    % flag_trail_yellow_Down = false;
    % flag_trail_blue_Down = false;
    % flag_trail_orange_Down = false;

    % flag_passed_in_green_Up = false;
    % flag_passed_in_red_Up = false;
    % flag_passed_in_yellow_Up = false;
    % flag_passed_in_blue_Up = false;
    % flag_passed_in_orange_Up = false;

    % flag_passed_in_green_Middle = false;
    % flag_passed_in_red_Middle = false;
    % flag_passed_in_yellow_Middle = false;
    % flag_passed_in_blue_Middle = false;
    % flag_passed_in_orange_Middle = false;

    % flag_detected_trail_Up = false;
    % flag_detected_trail_Middle = false;
    
    % flag_initial_note = true;

    while (note < number_of_notes)
        imgO = getdata(vid,1,'uint8');

        % Detecta pixels

        greenPixelUp        = imgO(287,238,G);
        greenPixelMiddle    = imgO(306,230,G);
        greenPixelDown      = imgO(406,185,G);

        redPixelUp          = imgO(287,275,R);
        redPixelMiddle      = imgO(305,274,R);
        redPixelDown        = imgO(405,250,R);

        yellowPixelRUp      = imgO(287,312,R);
        yellowPixelGUp      = imgO(287,312,G);
        yellowPixelRMiddle  = imgO(306,311,R);
        yellowPixelGMiddle  = imgO(306,311,G);
        yellowPixelRDown    = imgO(405,313,R);
        yellowPixelGDown    = imgO(405,313,G);

        bluePixelGUp        = imgO(287,349,G);
        bluePixelBUp        = imgO(287,349,B);
        bluePixelGMiddle    = imgO(306,354,G);
        bluePixelBMiddle    = imgO(306,354,B);
        bluePixelGDown      = imgO(405,376,G);
        bluePixelBDown      = imgO(405,376,B);

        orangePixelRUp      = imgO(287,387,R);
        orangePixelGUp      = imgO(287,387,G);
        orangePixelRMiddle  = imgO(305,395,R);
        orangePixelGMiddle  = imgO(305,395,G);
        orangePixelRDown    = imgO(405,440,R);
        orangePixelGDown    = imgO(405,440,G);

        % UP

        % Flags que retornam os valores lógicos true para determinar se foi identificada uma nota
        if(greenPixelUp >= green_min && greenPixelUp <= green_max) 
            flag_green_Up = true;
        end
        if(redPixelUp >= red_min && redPixelUp <= red_max) 
            flag_red_Up = true;
        end
        if(yellowPixelRUp >= yellowR_min && yellowPixelRUp <= yellowR_max && yellowPixelGUp >= yellowG_min && yellowPixelGUp <= yellowG_max) 
            flag_yellow_Up = true;
        end
        if(bluePixelGUp >= blueG_min && bluePixelGUp <= blueG_max && bluePixelBUp >= blueB_min && bluePixelBUp <= blueB_max) 
            flag_blue_Up = true;
        end
        if(orangePixelRUp >= orangeR_min && orangePixelRUp <= orangeR_max && orangePixelGUp >= orangeG_min && orangePixelGUp <= orangeG_max) 
            flag_orange_Up = true;
        end

        if(flag_green_Up && ...
        ~(greenPixelUp >= green_min && greenPixelUp <= green_max))
            tictoc_green_up = tic;
            flag_green_Up = false;
        end
        if(flag_red_Up && ...
        ~(redPixelUp >= red_min && redPixelUp <= red_max))
            tictoc_red_up = tic;
            flag_red_Up = false;
        end
        if(flag_yellow_Up && ...
        ~(yellowPixelRUp >= yellowR_min && yellowPixelRUp <= yellowR_max && ...
        yellowPixelGUp >= yellowG_min && yellowPixelGUp <= yellowG_max))
            tictoc_yellow_up = tic;
            flag_yellow_Up = false;
        end
        if(flag_blue_Up && ...
        ~(bluePixelGUp >= blueG_min && bluePixelGUp <= blueG_max && ...
        bluePixelBUp >= blueB_min && bluePixelBUp <= blueB_max)) 
            tictoc_blue_up = tic;
            flag_blue_Up = false;
        end
        if(flag_orange_Up && ...
        ~(orangePixelRUp >= orangeR_min && orangePixelRUp <= orangeR_max && ...
        orangePixelGUp >= orangeG_min && orangePixelGUp <= orangeG_max))
            tictoc_orange_up = tic;
            flag_orange_Up = false;
        end

        % MIDDLE

        if(greenPixelMiddle >= green_min && greenPixelMiddle <= green_max) 
            flag_green_Middle = true;
        end
        if(redPixelMiddle >= red_min && redPixelMiddle <= red_max) 
            flag_red_Middle = true;
        end
        if(yellowPixelRMiddle >= yellowR_min && yellowPixelRMiddle <= yellowR_max && yellowPixelGMiddle >= yellowG_min && yellowPixelGMiddle <= yellowG_max) 
            flag_yellow_Middle = true;
        end
        if(bluePixelGMiddle >= blueG_min && bluePixelGMiddle <= blueG_max && bluePixelBMiddle >= blueB_min && bluePixelBMiddle <= blueB_max) 
            flag_blue_Middle = true;
        end
        if(orangePixelRMiddle >= orangeR_min && orangePixelRMiddle <= orangeR_max && orangePixelGMiddle >= orangeG_min && orangePixelGMiddle <= orangeG_max) 
            flag_orange_Middle = true;
        end

        if(flag_green_Middle && ...
        ~(greenPixelMiddle >= green_min && greenPixelMiddle <= green_max))
            time_trail_green = toc(tictoc_green_up) + time_trail_green;
            tictoc_green_middle = tic;
            flag_green_Middle = false;
        end
        if(flag_red_Middle && ...
        ~(redPixelMiddle >= red_min && redPixelMiddle <= red_max))
            time_trail_red = toc(tictoc_red_up) + time_trail_red;
            tictoc_red_middle = tic;
            flag_red_Middle = false;
        end
        if(flag_yellow_Middle && ...
        ~(yellowPixelRMiddle >= yellowR_min && yellowPixelRMiddle <= yellowR_max && ...
        yellowPixelGMiddle >= yellowG_min && yellowPixelGMiddle <= yellowG_max))
            time_trail_yellow = toc(tictoc_yellow_up) + time_trail_yellow;
            tictoc_yellow_middle = tic;
            flag_yellow_Middle = false;
        end
        if(flag_blue_Middle && ...
        ~(bluePixelGMiddle >= blueG_min && bluePixelGMiddle <= blueG_max && ...
        bluePixelBMiddle >= blueB_min && bluePixelBMiddle <= blueB_max)) 
            time_trail_blue = toc(tictoc_blue_up) + time_trail_blue;
            tictoc_blue_middle = tic;
            flag_blue_Middle = false;
        end
        if(flag_orange_Middle && ...
        ~(orangePixelRMiddle >= orangeR_min && orangePixelRMiddle <= orangeR_max && ...
        orangePixelGMiddle >= orangeG_min && orangePixelGMiddle <= orangeG_max))
            time_trail_orange = toc(tictoc_orange_up) + time_trail_orange;
            tictoc_orange_middle = tic;
            flag_orange_Middle = false;
        end

        % DOWN

        if(greenPixelDown >= green_min && greenPixelDown <= green_max) 
            flag_green_Down = true;
        end
        if(redPixelDown >= red_min && redPixelDown <= red_max) 
            flag_red_Down = true;
        end
        if(yellowPixelRDown >= yellowR_min && yellowPixelRDown <= yellowR_max && yellowPixelGDown >= yellowG_min && yellowPixelGDown <= yellowG_max) 
            flag_yellow_Down = true;
        end
        if(bluePixelGDown >= blueG_min && bluePixelGDown <= blueG_max && bluePixelBDown >= blueB_min && bluePixelBDown <= blueB_max) 
            flag_blue_Down = true;
        end
        if(orangePixelRDown >= orangeR_min && orangePixelRDown <= orangeR_max && orangePixelGDown >= orangeG_min && orangePixelGDown <= orangeG_max) 
            flag_orange_Down = true;
        end

        if(flag_green_Down && ...
        ~(greenPixelDown >= green_min && greenPixelDown <= green_max))
            time_note_green = toc(tictoc_red_up) + time_note_green;
            flag_green_Down = false;
            note = note + 1;
        end
        if(flag_red_Down && ...
        ~(redPixelDown >= red_min && redPixelDown <= red_max))
            time_note_red = toc(tictoc_red_up) + time_note_red;
            flag_red_Down = false;
            note = note + 1;
        end
        if(flag_yellow_Down && ...
        ~(yellowPixelRDown >= yellowR_min && yellowPixelRDown <= yellowR_max && ...
        yellowPixelGDown >= yellowG_min && yellowPixelGDown <= yellowG_max))
            time_note_yellow = toc(tictoc_red_up) + time_note_yellow;
            flag_yellow_Down = false;
            note = note + 1;
        end
        if(flag_blue_Down && ...
        ~(bluePixelGDown >= blueG_min && bluePixelGDown <= blueG_max && ...
        bluePixelBDown >= blueB_min && bluePixelBDown <= blueB_max)) 
            time_note_blue = toc(tictoc_red_up) + time_note_blue;
            flag_blue_Down = false;
            note = note + 1;
        end
        if(flag_orange_Down && ...
        ~(orangePixelRDown >= orangeR_min && orangePixelRDown <= orangeR_max && ...
        orangePixelGDown >= orangeG_min && orangePixelGDown <= orangeG_max))
            time_note_orange = toc(tictoc_red_up) + time_note_orange;
            flag_orange_Down = false;
            note = note + 1;
        end
    end

    time = (time_note_green + time_note_red + time_note_yellow + time_note_blue + time_note_orange)/number_of_notes;
    trail_time = (time + ((time_trail_green + time_trail_red + time_trail_yellow + time_trail_blue + time_trail_orange)/number_of_notes))/3;
end