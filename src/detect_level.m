function [note_time, trail_time] = detect_level(vid) % Colocar variável que diz se é rastro ou nota

    time = 0;
    note = 2;
    trail = 2;

    average_note_time = 0;
    average_trail_time = 0;

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
    while ((note > 0) && (trail > 0))
        imgO = getdata(vid,1,'uint8');

        R = 1;
        G = 2;
        B = 3;

        note_greenPixelUp = imgO(260,238,G);
        note_redPixelUp = imgO(286,237,R);
        note_yellowPixelRUp = imgO(313,237,R);
        note_yellowPixelGUp = imgO(313,237,G);
        note_bluePixelGUp = imgO(343,237,G);
        note_bluePixelBUp = imgO(343,237,B);
        note_orangePixelRUp = imgO(367,238,R);
        note_orangePixelGUp = imgO(367,238,G);

        if(note > 0)

            %detect green
            if(note_greenPixelUp >= green_min && note_greenPixelUp <= green_max)
                
                note = note - 1;
                tic;

                while (time == 0)
                    imgO = getdata(vid,1,'uint8');
                    note_greenPixelDown = imgO(241,287,G);

                    if(note_greenPixelDown >= green_min && note_greenPixelDown <= green_max)
                        time = toc;
                    end
                end

            %detect red    
            elseif(note_redPixelUp >= red_min && note_redPixelUp <= red_max)
                
                note = note - 1;
                tic;

                while (time == 0)
                    imgO = getdata(vid,1,'uint8');
                    note_redPixelDown = imgO(273,287,R);

                    if(note_redPixelDown >= red_min && note_redPixelDown <= red_max)
                        time = toc;
                    end
                end

            %detect yellow
            elseif(note_yellowPixelRUp >= yellowR_min && note_yellowPixelRUp <= yellowR_max && ...
                note_yellowPixelGUp >= yellowG_min && note_yellowPixelGUp <= yellowG_max )
                
                note = note - 1;
                tic;

                while (time == 0)
                    imgO = getdata(vid,1,'uint8');
                    note_yellowPixelRDown = imgO(311,288,R);
                    note_yellowPixelGDown = imgO(311,288,G);

                    if(note_yellowPixelRDown >= yellowR_min && note_yellowPixelRDown <= yellowR_max && ...
                    note_yellowPixelGDown >= yellowG_min && note_yellowPixelGDown <= yellowG_max )
                        time = toc;
                    end
                end

            %detect blue
            elseif(note_bluePixelGUp >= blueG_min && note_bluePixelGUp <= blueG_max && ...
                note_bluePixelBUp >= blueB_min && note_bluePixelBUp <= blueB_max )
                
                note = note - 1;
                tic;

                while (time == 0)
                    imgO = getdata(vid,1,'uint8');
                    note_bluePixelGDown = imgO(354,287,G);
                    note_bluePixelBDown = imgO(354,287,B);

                    if(note_bluePixelGDown >= blueG_min && note_bluePixelGDown <= blueG_max && ...
                    note_bluePixelBDown >= blueB_min && note_bluePixelBDown <= blueB_max )
                        time = toc;
                    end
                end

            %detect orange
            elseif(note_orangePixelRUp >= orangeR_min && note_orangePixelRUp <= orangeR_max && ...
                note_orangePixelGUp >= orangeG_min && note_orangePixelGUp <= orangeG_max )
                
                note = note - 1;
                tic;

                while (time == 0)
                    imgO = getdata(vid,1,'uint8');
                    note_orangePixelRDown = imgO(388,286,R);
                    note_orangePixelGDown = imgO(388,286,G);

                if(note_orangePixelRDown >= orangeR_min && note_orangePixelRDown <= orangeR_max && ...
                    note_orangePixelGDown >= orangeG_min && note_orangePixelGDown <= orangeG_max )
                        time = toc;
                    end
                end
            end
            average_note_time = average(average_note_time, time);
        
        elseif (trail > 0)

            % Tempo médio dos rastros

            trail_greenPixelUp = imgO(260,238,G);
            trail_redPixelUp = imgO(286,237,R);
            trail_yellowPixelRUp = imgO(313,237,R);
            trail_yellowPixelGUp = imgO(313,237,G);
            trail_bluePixelGUp = imgO(343,237,G);
            trail_bluePixelBUp = imgO(343,237,B);
            trail_orangePixelRUp = imgO(367,238,R);
            trail_orangePixelGUp = imgO(367,238,G);

            %detect green
            if(trail_greenPixelUp >= green_min && trail_greenPixelUp <= green_max)
                
                trail = trail - 1;
                tic;

                while (time == 0)
                    imgO = getdata(vid,1,'uint8');
                    trail_greenPixelDown = imgO(241,287,G);

                    if(trail_greenPixelDown >= green_min && trail_greenPixelDown <= green_max)
                        time = toc;
                    end
                end

            %detect red    
            elseif(trail_redPixelUp >= red_min && trail_redPixelUp <= red_max)
                
                trail = trail - 1;
                tic;

                while (time == 0)
                    imgO = getdata(vid,1,'uint8');
                    trail_redPixelDown = imgO(273,287,R);

                    if(trail_redPixelDown >= red_min && trail_redPixelDown <= red_max)
                        time = toc;
                    end
                end

            %detect yellow
            elseif(trail_yellowPixelRUp >= yellowR_min && trail_yellowPixelRUp <= yellowR_max && ...
                trail_yellowPixelGUp >= yellowG_min && trail_yellowPixelGUp <= yellowG_max )
                
                trail = trail - 1;
                tic;

                while (time == 0)
                    imgO = getdata(vid,1,'uint8');
                    trail_yellowPixelRDown = imgO(311,288,R);
                    trail_yellowPixelGDown = imgO(311,288,G);

                    if(trail_yellowPixelRDown >= yellowR_min && trail_yellowPixelRDown <= yellowR_max && ...
                    trail_yellowPixelGDown >= yellowG_min && trail_yellowPixelGDown <= yellowG_max )
                        time = toc;
                    end
                end

            %detect blue
            elseif(trail_bluePixelGUp >= blueG_min && trail_bluePixelGUp <= blueG_max && ...
                trail_bluePixelBUp >= blueB_min && trail_bluePixelBUp <= blueB_max )
                
                trail = trail - 1;
                tic;

                while (time == 0)
                    imgO = getdata(vid,1,'uint8');
                    trail_bluePixelGDown = imgO(354,287,G);
                    trail_bluePixelBDown = imgO(354,287,B);

                    if(trail_bluePixelGDown >= blueG_min && trail_bluePixelGDown <= blueG_max && ...
                    trail_bluePixelBDown >= blueB_min && trail_bluePixelBDown <= blueB_max )
                        time = toc;
                    end
                end

            %detect orange
            elseif(trail_orangePixelRUp >= orangeR_min && trail_orangePixelRUp <= orangeR_max && ...
                trail_orangePixelGUp >= orangeG_min && trail_orangePixelGUp <= orangeG_max )
                
                trail = trail - 1;
                tic;

                while (time == 0)
                    imgO = getdata(vid,1,'uint8');
                    trail_orangePixelRDown = imgO(388,286,R);
                    trail_orangePixelGDown = imgO(388,286,G);

                if(trail_orangePixelRDown >= orangeR_min && trail_orangePixelRDown <= orangeR_max && ...
                    trail_orangePixelGDown >= orangeG_min && trail_orangePixelGDown <= orangeG_max )
                        time = toc;
                    end
                end
            end
            average_trail_time = average(average_trail_time, time);
        end
        time = 0;
    end
    % fprintf("average: %f", average_trail_time)
    note_time = average_note_time;
    trail_time = average_trail_time;
end

function average_time = average(previous_time, posterior_time)
    average_time = (previous_time + posterior_time)/2;
end