function [note_time, trail_time] = detect_level(vid) % Colocar variável que diz se é rastro ou nota

    time = 0;
    note = 10;
    trail = 5;

    red_min = 175;
    red_max = 255;
    green_min = 175;
    green_max = 175;
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


    % Tempo médio das notas
    while (note != 0)
        imgO = getdata(vid,1,'uint8');

        R = 1;
        G = 2;
        B = 3;

        greenPixelUp = imgO(260,238,G);
        redPixelUp = imgO(286,237,R);
        yellowPixelRUp = imgO(313,237,R);
        yellowPixelGUp = imgO(313,237,G);
        bluePixelGUp = imgO(343,237,G);
        bluePixelBUp = imgO(343,237,B);
        orangePixelRUp = imgO(367,238,R);
        orangePixelGUp = imgO(367,238,G);

        %detect green
        if(greenPixelUp >= green_min && greenPixelUp <= green_max)
            tic;

            while (time == 0)
                imgO = getdata(vid,1,'uint8');
                greenPixelDown = imgO(241,287,G);

                if(greenPixelDown >= green_min && greenPixelDown <= green_max)
                    time = toc;
                end
            end

        %detect red    
        elseif(redPixelUp >= red_min && redPixelUp <= red_max)
            tic;

            while (time == 0)
                imgO = getdata(vid,1,'uint8');
                redPixelDown = imgO(273,287,R);

                if(redPixelDown >= red_min && redPixelDown <= red_max)
                    time = toc;
                end
            end

        %detect yellow
        elseif(yellowPixelRUp >= yellowR_min && yellowPixelRUp <= yellowR_max && ...
        yellowPixelGUp >= yellowG_min && yellowPixelGUp <= yellowG_max )
            tic;

            while (time == 0)
                imgO = getdata(vid,1,'uint8');
                yellowPixelRDown = imgO(311,288,R);
                yellowPixelGDown = imgO(311,288,G);

                if(yellowPixelRDown >= yellowR_min && yellowPixelRDown <= yellowR_max && ...
                yellowPixelGDown >= yellowG_min && yellowPixelGDown <= yellowG_max )
                    time = toc;
                end
            end

        %detect blue
        elseif(bluePixelGUp >= blueG_min && bluePixelGUp <= blueG_max && ...
            bluePixelBUp >= blueB_min && bluePixelBUp <= blueB_max )
            tic;

            while (time == 0)
                imgO = getdata(vid,1,'uint8');
                bluePixelGDown = imgO(354,287,G);
                bluePixelBDown = imgO(354,287,B);

                if(bluePixelGDown >= blueG_min && bluePixelGDown <= blueG_max && ...
                bluePixelBDown >= blueB_min && bluePixelBDown <= blueB_max )
                    time = toc;
                end
            end

        %detect orange
        elseif(orangePixelRUp >= orangeR_min && orangePixelRUp <= orangeR_max && ...
            orangePixelGUp >= orangeG_min && orangePixelGUp <= orangeG_max )
            tic;

            while (time == 0)
                imgO = getdata(vid,1,'uint8');
                orangePixelRDown = imgO(388,286,R);
                orangePixelGDown = imgO(388,286,G);

            if(orangePixelRDown >= orangeR_min && orangePixelRDown <= orangeR_max && ...
                orangePixelGDown >= orangeG_min && orangePixelGDown <= orangeG_max )
                    time = toc;
                end
            end
        end

        average_note_time = average(average_note_time, time)
        note--;
    end

    note_time = average_note_time;


    % Tempo médio dos rastros
    while (trail != 0)
        imgO = getdata(vid,1,'uint8');

        R = 1;
        G = 2;
        B = 3;

        greenPixelUp = imgO(260,238,G);
        redPixelUp = imgO(286,237,R);
        yellowPixelRUp = imgO(313,237,R);
        yellowPixelGUp = imgO(313,237,G);
        bluePixelGUp = imgO(343,237,G);
        bluePixelBUp = imgO(343,237,B);
        orangePixelRUp = imgO(367,238,R);
        orangePixelGUp = imgO(367,238,G);

        %detect green
        if(greenPixelUp >= green_min && greenPixelUp <= green_max)
            tic;

            while (time == 0)
                imgO = getdata(vid,1,'uint8');
                greenPixelDown = imgO(241,287,G);

                if(greenPixelDown >= green_min && greenPixelDown <= green_max)
                    time = toc;
                end
            end

        %detect red    
        elseif(redPixelUp >= red_min && redPixelUp <= red_max)
            tic;

            while (time == 0)
                imgO = getdata(vid,1,'uint8');
                redPixelDown = imgO(273,287,R);

                if(redPixelDown >= red_min && redPixelDown <= red_max)
                    time = toc;
                end
            end

        %detect yellow
        elseif(yellowPixelRUp >= yellowR_min && yellowPixelRUp <= yellowR_max && ...
        yellowPixelGUp >= yellowG_min && yellowPixelGUp <= yellowG_max )
            tic;

            while (time == 0)
                imgO = getdata(vid,1,'uint8');
                yellowPixelRDown = imgO(311,288,R);
                yellowPixelGDown = imgO(311,288,G);

                if(yellowPixelRDown >= yellowR_min && yellowPixelRDown <= yellowR_max && ...
                yellowPixelGDown >= yellowG_min && yellowPixelGDown <= yellowG_max )
                    time = toc;
                end
            end

        %detect blue
        elseif(bluePixelGUp >= blueG_min && bluePixelGUp <= blueG_max && ...
            bluePixelBUp >= blueB_min && bluePixelBUp <= blueB_max )
            tic;

            while (time == 0)
                imgO = getdata(vid,1,'uint8');
                bluePixelGDown = imgO(354,287,G);
                bluePixelBDown = imgO(354,287,B);

                if(bluePixelGDown >= blueG_min && bluePixelGDown <= blueG_max && ...
                bluePixelBDown >= blueB_min && bluePixelBDown <= blueB_max )
                    time = toc;
                end
            end

        %detect orange
        elseif(orangePixelRUp >= orangeR_min && orangePixelRUp <= orangeR_max && ...
            orangePixelGUp >= orangeG_min && orangePixelGUp <= orangeG_max )
            tic;

            while (time == 0)
                imgO = getdata(vid,1,'uint8');
                orangePixelRDown = imgO(388,286,R);
                orangePixelGDown = imgO(388,286,G);

            if(orangePixelRDown >= orangeR_min && orangePixelRDown <= orangeR_max && ...
                orangePixelGDown >= orangeG_min && orangePixelGDown <= orangeG_max )
                    time = toc;
                end
            end
        end

        average_trail_time = average(average_trail_time, time)
        trail--;
    end

    trail_time = average_trail_time;
end

function average_time = average(previous_time, posterior_time)
    average_time = (previous_time + posterior_time)/2
end