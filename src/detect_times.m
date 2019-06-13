function [note_time, trail_time] = detect_times(vid)
    disp("Detectando os tempos.");

    note_max = 10;
    note = 0;

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
    
    t_time          = NaN;
    n_time          = NaN;

    R               = 1;
    G               = 2;
    B               = 3;

    tictoc_min = 0.1
    tictoc_max_trail = 0.75
    tictoc_max_note = 1


    while (note < note_max)
        imgO = getdata(vid,1,'uint8');

        greenPixelUp        = imgO(293,238,G);
        greenPixelMidle     = imgO(312,230,G);
        greenPixelDown      = imgO(412,185,G);

        redPixelUp          = imgO(293,275,R);
        redPixelMidle       = imgO(311,274,R);
        redPixelDown        = imgO(411,250,R);

        yellowPixelRUp      = imgO(293,312,R);
        yellowPixelGUp      = imgO(293,312,G);
        yellowPixelRMidle   = imgO(312,311,R);
        yellowPixelGMidle   = imgO(312,311,G);
        yellowPixelRDown    = imgO(411,313,R);
        yellowPixelGDown    = imgO(411,313,G);

        bluePixelGUp        = imgO(293,349,G);
        bluePixelBUp        = imgO(293,349,B);
        bluePixelGMidle     = imgO(312,354,G);
        bluePixelBMidle     = imgO(312,354,B);
        bluePixelGDown      = imgO(411,376,G);
        bluePixelBDown      = imgO(411,376,B);

        orangePixelRUp      = imgO(293,387,R);
        orangePixelGUp      = imgO(293,387,G);
        orangePixelRMidle   = imgO(311,395,R);
        orangePixelGMidle   = imgO(311,395,G);
        orangePixelRDown    = imgO(411,440,R);
        orangePixelGDown    = imgO(411,440,G);

        % ATENÇÃO: VAI FALHAR NO CASO DE NOTAS MUITO PRÓXIMAS E RASTROS %

        %detect green
        if(greenPixelUp >= green_min && greenPixelUp <= green_max)
            tictoc_g1 = tic;
        end
        if(greenPixelMidle >= green_min && greenPixelMidle <= green_max && ...
            toc(tictoc_g1) > tictoc_min && toc(tictoc_g1) <= tictoc_max_trail) % Condição para eliminar rastros e falsos positivos %
            green_trail = toc(tictoc_g1);
            tictoc_g2 = tic;
        end
        if(greenPixelDown >= green_min && greenPixelDown <= green_max && ...
            toc(tictoc_g2) > tictoc_min && toc(tictoc_g2) <= tictoc_max_note) % Condição para eliminar rastros e falsos positivos %
            green_note = toc(tictoc_g2);
            n_time = mean([n_time, green_note], 'omitnan');
            t_time = mean([(green_note + green_time), t_time], 'omitnan');
            % n_time = [n_time, green_note];
            % n_time = mean(n_time, 'omitnan');
            % t_time = [(green_note + green_time), t_time];
            % t_time = mean(t_time, 'omitnan');
            note = note + 1;
        end
                

        %detect red    
        if(redPixelUp >= red_min && redPixelUp <= red_max)
            tictoc_r1 = tic;;
        end
        if(redPixelMidle >= red_min && redPixelMidle <= red_max && ...
            toc(tictoc_r1) > tictoc_min && toc(tictoc_r1) <= tictoc_max_trail) % Condição para eliminar rastros e falsos positivos %
            red_trail = toc(tictoc_r1);
            tictoc_r2 = tic;
        end
        if(redPixelDown >= red_min && redPixelDown <= red_max && ...
            toc(tictoc_r2) > tictoc_min && toc(tictoc_r2) <= tictoc_max_note) % Condição para eliminar rastros e falsos positivos %
            red_note = toc(tictoc_r2);
            n_time = mean([n_time, red_note], 'omitnan');
            t_time = mean([(red_note + red_time), t_time], 'omitnan');
            % n_time = [n_time, red_note];
            % n_time = mean(n_time, 'omitnan');
            % t_time = [(red_note + red_time), t_time];
            % t_time = mean(t_time, 'omitnan');
            note = note + 1;
        end


        %detect yellow
        if(yellowPixelRUp >= yellowR_min && yellowPixelRUp <= yellowR_max && ...
            yellowPixelGUp >= yellowG_min && yellowPixelGUp <= yellowG_max)
            tictoc_y1 = tic;;
        end
        if(yellowPixelRMidle >= yellowR_min && yellowPixelRMidle <= yellowR_max && ...
            yellowPixelGMidle >= yellowG_min && yellowPixelGMidle <= yellowG_max && ...
            toc(tictoc_y1) > tictoc_min && toc(tictoc_y1) <= tictoc_max_trail) % Condição para eliminar rastros e falsos positivos %
            yellow_trail = toc(tictoc_y1);
            tictoc_y2 = tic;
        end
        if(yellowPixelRDown >= yellowR_min && yellowPixelRDown <= yellowR_max && ...
            yellowPixelGDown >= yellowG_min && yellowPixelGDown <= yellowG_max && ...
            toc(tictoc_y2) > tictoc_min && toc(tictoc_y2) <= tictoc_max_note) % Condição para eliminar rastros e falsos positivos %
            yellow_note = toc(tictoc_y2);
            n_time = mean([n_time, yellow_note], 'omitnan');
            t_time = mean([(yellow_note + yellow_time), t_time], 'omitnan');
            % n_time = [n_time, yellow_note];
            % n_time = mean(n_time, 'omitnan');
            % t_time = [(yellow_note + yellow_time), t_time];
            % t_time = mean(t_time, 'omitnan');
            note = note + 1;
        end
                
                
        %detect blue
        if(bluePixelGUp >= blueG_min && bluePixelGUp <= blueG_max && ...
            bluePixelBUp >= blueB_min && bluePixelBUp <= blueB_max)
            tictoc_b1 = tic;;
        end
        if(bluePixelGMidle >= blueG_min && bluePixelGMidle <= blueG_max && ...
            bluePixelBMidle >= blueB_min && bluePixelBMidle <= blueB_max && ...
            toc(tictoc_b1) > tictoc_min && toc(tictoc_b1) <= tictoc_max_trail) % Condição para eliminar rastros e falsos positivos %
            blue_trail = toc(tictoc_b1);
            tictoc_b2 = tic;
        end
        if(bluePixelGDown >= blueG_min && bluePixelGDown <= blueG_max && ...
            bluePixelBDown >= blueB_min && bluePixelBDown <= blueB_max && ...
            toc(tictoc_b2) > tictoc_min && toc(tictoc_b2) <= tictoc_max_note) % Condição para eliminar rastros e falsos positivos %
            blue_note = toc(tictoc_b2);
            n_time = mean([n_time, blue_note], 'omitnan');
            t_time = mean([(blue_note + blue_time), t_time], 'omitnan');
            note = note + 1;
        end

                
        %detect orange
        if(orangePixelRUp >= orangeR_min && orangePixelRUp <= orangeR_max && ...
            orangePixelGUp >= orangeG_min && orangePixelGUp <= orangeG_max)
            tictoc_o1 = tic;;
        end
        if(orangePixelRMidle >= orangeR_min && orangePixelRMidle <= orangeR_max && ...
            orangePixelGMidle >= orangeG_min && orangePixelGMidle <= orangeG_max && ...
            toc(tictoc_o1) > tictoc_min && toc(tictoc_o1) <= tictoc_max_trail) % Condição para eliminar rastros e falsos positivos %
            orange_trail = toc(tictoc_o1);
            tictoc_o2 = tic;
        end
        if(orangePixelRDown >= orangeR_min && orangePixelRDown <= orangeR_max && ...
            orangePixelGDown >= orangeG_min && orangePixelGDown <= orangeG_max && ...
            toc(tictoc_o2) > tictoc_min && toc(tictoc_o2) <= tictoc_max_note) % Condição para eliminar rastros e falsos positivos %
            orange_note = toc(tictoc_o2);
            n_time = mean([n_time, orange_note], 'omitnan');
            t_time = mean([(orange_note + orange_time), t_time], 'omitnan');
            note = note + 1;
        end
    end

    trail_time = t_time + n_time;
    note_time = n_time;
end