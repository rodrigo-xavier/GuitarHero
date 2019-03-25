function [note_time, trail_time] = detect_level(vid) % Colocar variável que diz se é rastro ou nota

    % Salvar dados de tempo de rastro para cada nível, futuramente essa funcionalidade inteira pode ser convertida em
    % note_time x constante = trail_time
    % Existe uma constante para cada nível, e no momento ela é desconhecida, mas é possível calcula-la da seguinte forma
    % constante = MÉDIA(trail_time)/MÉDIA(note_time)

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

    % Alterar condição para passar 10 notas para pegar o tempo médio
    while (note != 0 && trail != 0)

        imgO = getdata(vid,1,'uint8');

        R = 1;
        G = 2;
        B = 3;

        greenPixelUp1 = imgO(260,238,G);
        redPixelUp1 = imgO(286,237,R);
        yellowPixelRUp1 = imgO(313,237,R);
        yellowPixelGUp1 = imgO(313,237,G);
        bluePixelGUp1 = imgO(343,237,G);
        bluePixelBUp1 = imgO(343,237,B);
        orangePixelRUp1 = imgO(367,238,R);
        orangePixelGUp1 = imgO(367,238,G);

        % Alterar valores dos pixels up 2
        greenPixelUp2 = imgO(260,238,G);
        redPixelUp2 = imgO(286,237,R);
        yellowPixelRUp2 = imgO(313,237,R);
        yellowPixelGUp2 = imgO(313,237,G);
        bluePixelGUp2 = imgO(343,237,G);
        bluePixelBUp2 = imgO(343,237,B);
        orangePixelRUp2 = imgO(367,238,R);
        orangePixelGUp2 = imgO(367,238,G);

        if(~is_trail)
            %detect green
            if(greenPixelUp1 >= green_min && greenPixelUp1 <= green_max)
                tic;

                while (time == 0)
                    imgO = getdata(vid,1,'uint8');
                    greenPixelDown = imgO(241,287,G);

                    if(greenPixelDown >= green_min && greenPixelDown <= green_max)
                        time = toc;
                    end
                end

            %detect red    
            elseif(redPixelUp1 >= red_min && redPixelUp1 <= red_max)
                tic;

                while (time == 0)
                    imgO = getdata(vid,1,'uint8');
                    redPixelDown = imgO(273,287,R);

                    if(redPixelDown >= red_min && redPixelDown <= red_max)
                        time = toc;
                    end
                end

            %detect yellow
            elseif(yellowPixelRUp1 >= yellowR_min && yellowPixelRUp1 <= yellowR_max && ...
            yellowPixelGUp1 >= yellowG_min && yellowPixelGUp1 <= yellowG_max )
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
            elseif(bluePixelGUp1 >= blueG_min && bluePixelGUp1 <= blueG_max && ...
                bluePixelBUp1 >= blueB_min && bluePixelBUp1 <= blueB_max )
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
            elseif(orangePixelRUp1 >= orangeR_min && orangePixelRUp1 <= orangeR_max && ...
                orangePixelGUp1 >= orangeG_min && orangePixelGUp1 <= orangeG_max )
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
            note_time = (note_time + time)/2;
            note--;


        else
        
            %detect green
            if(greenPixelUp2 >= green_min && greenPixelUp2 <= green_max)
                tic;

                while (time == 0)
                    imgO = getdata(vid,1,'uint8');
                    greenPixelDown = imgO(241,287,G);

                    if(greenPixelDown >= green_min && greenPixelDown <= green_max)
                        time = toc;
                    end
                end

            %detect red    
            elseif(redPixelUp2 >= red_min && redPixelUp2 <= red_max)
                tic;

                while (time == 0)
                    imgO = getdata(vid,1,'uint8');
                    redPixelDown = imgO(273,287,R);

                    if(redPixelDown >= red_min && redPixelDown <= red_max)
                        time = toc;
                    end
                end

            %detect yellow
            elseif(yellowPixelRUp2 >= yellowR_min && yellowPixelRUp2 <= yellowR_max && ...
            yellowPixelGUp2 >= yellowG_min && yellowPixelGUp2 <= yellowG_max )
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
            elseif(bluePixelGUp2 >= blueG_min && bluePixelGUp2 <= blueG_max && ...
                bluePixelBUp2 >= blueB_min && bluePixelBUp2 <= blueB_max )
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
            else (orangePixelRUp2 >= orangeR_min && orangePixelRUp2 <= orangeR_max && ...
                orangePixelGUp2 >= orangeG_min && orangePixelGUp2 <= orangeG_max )
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
            trail_time = (trail_time + time)/2;
            trail--;
        end
    end
end