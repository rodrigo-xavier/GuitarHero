function [holding_buttons, holding_times, comandoString] = rastro_play(galileo, pixels_rastro, simple_pixels, color_range, holding_buttons, holding_times, comandoString)
    %tempo de espera
    tempo_espera = 0.35;

    % cores
    red_min = color_range('red_min');
    red_max = color_range('red_max');
    green_min = color_range('green_min');
    green_max = color_range('green_max');
    yellowR_min = color_range('yellowR_min');
    yellowR_max = color_range('yellowR_max');
    yellowG_min = color_range('yellowG_min');
    yellowG_max = color_range('yellowG_max');
    blueG_min = color_range('blueG_min');
    blueG_max = color_range('blueG_max');
    blueB_min = color_range('blueB_min');
    blueB_max = color_range('blueG_max');
    orangeR_min = color_range('orangeR_min');
    orangeR_max = color_range('orangeR_max');
    orangeG_min = color_range('orangeG_min');
    orangeG_max = color_range('orangeR_max');
    
    R = 1;
    G = 2;
    B = 3;

    greenPixel = simple_pixels('greenPixel');
    redPixel = simple_pixels('redPixel');
    yellowPixelR = simple_pixels('yellowPixelR');
    yellowPixelG = simple_pixels('yellowPixelG');
    bluePixelG = simple_pixels('bluePixelG');
    bluePixelB = simple_pixels('bluePixelB');
    orangePixelR = simple_pixels('orangePixelR');
    orangePixelG = simple_pixels('orangePixelG');

    % ------------------------------------------------------------------------- %

    %Green
    %Segura botao no rastro
    %Se nao esta apertando e passa o rastro pela primeira vez
    if( ~holding_buttons('green') && ...
        (pixels_rastro('greenPxRastro0') >= green_min && pixels_rastro('greenPxRastro0') <= green_max) && ...
        (pixels_rastro('greenPxRastro1') >= green_min && pixels_rastro('greenPxRastro1') <= green_max) && ...
        (pixels_rastro('greenPxRastro2') >= green_min && pixels_rastro('greenPxRastro2') <= green_max) && ...
        (pixels_rastro('greenPxRastro3') >= green_min && pixels_rastro('greenPxRastro3') <= green_max) && ...
        (pixels_rastro('greenPxRastro4') >= green_min && pixels_rastro('greenPxRastro4') <= green_max) && ...
        (pixels_rastro('greenPxRastro5') >= green_min && pixels_rastro('greenPxRastro5') <= green_max) && ...
        (pixels_rastro('greenPxRastro6') >= green_min && pixels_rastro('greenPxRastro6') <= green_max) && ...
        (pixels_rastro('greenPxRastro7') >= green_min && pixels_rastro('greenPxRastro7') <= green_max) && ...
        (pixels_rastro('greenPxRastro8') >= green_min && pixels_rastro('greenPxRastro8') <= green_max) && ...
        (pixels_rastro('greenPxRastro9') >= green_min && pixels_rastro('greenPxRastro9') <= green_max) && ...
        (pixels_rastro('greenPxRastro10') >= green_min && pixels_rastro('greenPxRastro10') <= green_max) && ...
        (pixels_rastro('greenPxRastro11') >= green_min && pixels_rastro('greenPxRastro11') <= green_max) && ...
        (pixels_rastro('greenPxRastro12') >= green_min && pixels_rastro('greenPxRastro12') <= green_max) )

        %segura botao
        holding_buttons('green') = true;
        holding_times('green') = tic;
        % fprintf(galileo,'%c', APERTA_SEM_SOLTAR_GREEN); 
        comandoString(11) = '1'; 
    end

    %quando o rastro acaba solta
    %Se esta_apertando e nao ha mais rastro passando
    if( holding_buttons('green') && ...
        ~(greenPixel >= green_min && greenPixel <= green_max) && ...
        toc(holding_times('green')) > tempo_espera)

        holding_buttons('green') = false;
        % fprintf(galileo,'%c', SOLTA_GREEN);  
        comandoString(6) = '1';
    end


    % Red
    %Segura botao no rastro
    %Se nao esta apertando e passa o rastro pela primeira vez
    if( ~holding_buttons('red') && ...
        (pixels_rastro('redPxRastro0') >= red_min && pixels_rastro('redPxRastro0') <= red_max) && ...
        (pixels_rastro('redPxRastro1') >= red_min && pixels_rastro('redPxRastro1') <= red_max) && ...
        (pixels_rastro('redPxRastro2') >= red_min && pixels_rastro('redPxRastro2') <= red_max) && ...
        (pixels_rastro('redPxRastro3') >= red_min && pixels_rastro('redPxRastro3') <= red_max) && ...
        (pixels_rastro('redPxRastro4') >= red_min && pixels_rastro('redPxRastro4') <= red_max) && ...
        (pixels_rastro('redPxRastro5') >= red_min && pixels_rastro('redPxRastro5') <= red_max) && ...
        (pixels_rastro('redPxRastro6') >= red_min && pixels_rastro('redPxRastro6') <= red_max) && ...
        (pixels_rastro('redPxRastro7') >= red_min && pixels_rastro('redPxRastro7') <= red_max) && ...
        (pixels_rastro('redPxRastro8') >= red_min && pixels_rastro('redPxRastro8') <= red_max) && ...
        (pixels_rastro('redPxRastro9') >= red_min && pixels_rastro('redPxRastro9') <= red_max) && ...
        (pixels_rastro('redPxRastro10') >= red_min && pixels_rastro('redPxRastro10') <= red_max) && ...
        (pixels_rastro('redPxRastro11') >= red_min && pixels_rastro('redPxRastro11') <= red_max) && ...
        (pixels_rastro('redPxRastro12') >= red_min && pixels_rastro('redPxRastro12') <= red_max) )

        %segura botao
        holding_buttons('red') = true;
        holding_times('red') = tic;
        
        % fprintf(galileo,'%c', APERTA_SEM_SOLTAR_RED); 
        comandoString(10) = '1'; 
    end

    %quando o rastro acaba solta
    %Se esta_apertando e nao ha mais rastro passando
    if( holding_buttons('red') && ...
        ~(redPixel >= red_min && redPixel <= red_max) && ...
        toc(holding_times('red')) > tempo_espera)

        holding_buttons('red') = false;

        % fprintf(galileo,'%c', SOLTA_RED);  
        comandoString(5) = '1';

    end


    %Yellow
    %Segura botao no rastro
    %Se nao esta apertando e passa o rastro pela primeira vez
    if( ~holding_buttons('yellow') && ...
        (pixels_rastro('yellowPxRastro0R') >= yellowR_min && pixels_rastro('yellowPxRastro0R') <= yellowR_max) && ...
        (pixels_rastro('yellowPxRastro0G') >= yellowG_min && pixels_rastro('yellowPxRastro0G') <= yellowG_max) && ...
        (pixels_rastro('yellowPxRastro1R') >= yellowR_min && pixels_rastro('yellowPxRastro1R') <= yellowR_max) && ...
        (pixels_rastro('yellowPxRastro1G') >= yellowG_min && pixels_rastro('yellowPxRastro1G') <= yellowG_max) && ...
        (pixels_rastro('yellowPxRastro2R') >= yellowR_min && pixels_rastro('yellowPxRastro2R') <= yellowR_max) && ...
        (pixels_rastro('yellowPxRastro2G') >= yellowG_min && pixels_rastro('yellowPxRastro2G') <= yellowG_max) && ...
        (pixels_rastro('yellowPxRastro3R') >= yellowR_min && pixels_rastro('yellowPxRastro3R') <= yellowR_max) && ...
        (pixels_rastro('yellowPxRastro3G') >= yellowG_min && pixels_rastro('yellowPxRastro3G') <= yellowG_max) && ...
        (pixels_rastro('yellowPxRastro4R') >= yellowR_min && pixels_rastro('yellowPxRastro4R') <= yellowR_max) && ...
        (pixels_rastro('yellowPxRastro4G') >= yellowG_min && pixels_rastro('yellowPxRastro4G') <= yellowG_max) && ...
        (pixels_rastro('yellowPxRastro5R') >= yellowR_min && pixels_rastro('yellowPxRastro5R') <= yellowR_max) && ...
        (pixels_rastro('yellowPxRastro5G') >= yellowG_min && pixels_rastro('yellowPxRastro5G') <= yellowG_max) && ...
        (pixels_rastro('yellowPxRastro6R') >= yellowR_min && pixels_rastro('yellowPxRastro6R') <= yellowR_max) && ...
        (pixels_rastro('yellowPxRastro6G') >= yellowG_min && pixels_rastro('yellowPxRastro6G') <= yellowG_max) && ...
        (pixels_rastro('yellowPxRastro7R') >= yellowR_min && pixels_rastro('yellowPxRastro7R') <= yellowR_max) && ...
        (pixels_rastro('yellowPxRastro7G') >= yellowG_min && pixels_rastro('yellowPxRastro7G') <= yellowG_max) && ...
        (pixels_rastro('yellowPxRastro8R') >= yellowR_min && pixels_rastro('yellowPxRastro8R') <= yellowR_max) && ...
        (pixels_rastro('yellowPxRastro8G') >= yellowG_min && pixels_rastro('yellowPxRastro8G') <= yellowG_max) && ...
        (pixels_rastro('yellowPxRastro9R') >= yellowR_min && pixels_rastro('yellowPxRastro9R') <= yellowR_max) && ...
        (pixels_rastro('yellowPxRastro9G') >= yellowG_min && pixels_rastro('yellowPxRastro9G') <= yellowG_max) && ...
        (pixels_rastro('yellowPxRastro10R') >= yellowR_min && pixels_rastro('yellowPxRastro10R') <= yellowR_max) && ...
        (pixels_rastro('yellowPxRastro10G') >= yellowG_min && pixels_rastro('yellowPxRastro10G') <= yellowG_max) && ...
        (pixels_rastro('yellowPxRastro11R') >= yellowR_min && pixels_rastro('yellowPxRastro11R') <= yellowR_max) && ...
        (pixels_rastro('yellowPxRastro11G') >= yellowG_min && pixels_rastro('yellowPxRastro11G') <= yellowG_max) && ...
        (pixels_rastro('yellowPxRastro12R') >= yellowR_min && pixels_rastro('yellowPxRastro12R') <= yellowR_max) && ...
        (pixels_rastro('yellowPxRastro12G') >= yellowG_min && pixels_rastro('yellowPxRastro12G') <= yellowG_max) )
        
        %segura botao
        holding_buttons('yellow') = true;
        holding_times('yellow') = tic;
        % fprintf(galileo,'%c', APERTA_SEM_SOLTAR_YELLOW);
        comandoString(9) = '1';  
    end

    %quando o rastro acaba solta
    %Se esta_apertando e nao ha mais rastro passando
    if( holding_buttons('yellow') && ...
        ~(yellowPixelR >= yellowR_min && yellowPixelR <= yellowR_max && ...
          yellowPixelG >= yellowG_min && yellowPixelG <= yellowG_max) && ...
        toc(holding_times('yellow')) > tempo_espera)

        holding_buttons('yellow') = false;
        % fprintf(galileo,'%c', SOLTA_YELLOW);  
        comandoString(4) = '1';
    end


    %Blue
    %Segura botao no rastro
    %Se nao esta apertando e passa o rastro pela primeira vez
    if( ~holding_buttons('blue') && ...
        (pixels_rastro('bluePxRastro0B') >= blueB_min && pixels_rastro('bluePxRastro0B') <= blueB_max) && ...
        (pixels_rastro('bluePxRastro0G') >= blueG_min && pixels_rastro('bluePxRastro0G') <= blueG_max) && ...
        (pixels_rastro('bluePxRastro1B') >= blueB_min && pixels_rastro('bluePxRastro1B') <= blueB_max) && ...
        (pixels_rastro('bluePxRastro1G') >= blueG_min && pixels_rastro('bluePxRastro1G') <= blueG_max) && ...
        (pixels_rastro('bluePxRastro2B') >= blueB_min && pixels_rastro('bluePxRastro2B') <= blueB_max) && ...
        (pixels_rastro('bluePxRastro2G') >= blueG_min && pixels_rastro('bluePxRastro2G') <= blueG_max) && ...
        (pixels_rastro('bluePxRastro3B') >= blueB_min && pixels_rastro('bluePxRastro3B') <= blueB_max) && ...
        (pixels_rastro('bluePxRastro3G') >= blueG_min && pixels_rastro('bluePxRastro3G') <= blueG_max) && ...
        (pixels_rastro('bluePxRastro4B') >= blueB_min && pixels_rastro('bluePxRastro4B') <= blueB_max) && ...
        (pixels_rastro('bluePxRastro4G') >= blueG_min && pixels_rastro('bluePxRastro4G') <= blueG_max) && ...
        (pixels_rastro('bluePxRastro5B') >= blueB_min && pixels_rastro('bluePxRastro5B') <= blueB_max) && ...
        (pixels_rastro('bluePxRastro5G') >= blueG_min && pixels_rastro('bluePxRastro5G') <= blueG_max) && ...
        (pixels_rastro('bluePxRastro6B') >= blueB_min && pixels_rastro('bluePxRastro6B') <= blueB_max) && ...
        (pixels_rastro('bluePxRastro6G') >= blueG_min && pixels_rastro('bluePxRastro6G') <= blueG_max) && ...
        (pixels_rastro('bluePxRastro7B') >= blueB_min && pixels_rastro('bluePxRastro7B') <= blueB_max) && ...
        (pixels_rastro('bluePxRastro7G') >= blueG_min && pixels_rastro('bluePxRastro7G') <= blueG_max) && ...
        (pixels_rastro('bluePxRastro8B') >= blueB_min && pixels_rastro('bluePxRastro8B') <= blueB_max) && ...
        (pixels_rastro('bluePxRastro8G') >= blueG_min && pixels_rastro('bluePxRastro8G') <= blueG_max) && ...
        (pixels_rastro('bluePxRastro9B') >= blueB_min && pixels_rastro('bluePxRastro9B') <= blueB_max) && ...
        (pixels_rastro('bluePxRastro9G') >= blueG_min && pixels_rastro('bluePxRastro9G') <= blueG_max) && ...
        (pixels_rastro('bluePxRastro10B') >= blueB_min && pixels_rastro('bluePxRastro10B') <= blueB_max) && ...
        (pixels_rastro('bluePxRastro10G') >= blueG_min && pixels_rastro('bluePxRastro10G') <= blueG_max) && ...
        (pixels_rastro('bluePxRastro11B') >= blueB_min && pixels_rastro('bluePxRastro11B') <= blueB_max) && ...
        (pixels_rastro('bluePxRastro11G') >= blueG_min && pixels_rastro('bluePxRastro11G') <= blueG_max) && ...
        (pixels_rastro('bluePxRastro12B') >= blueB_min && pixels_rastro('bluePxRastro12B') <= blueB_max) && ...
        (pixels_rastro('bluePxRastro12G') >= blueG_min && pixels_rastro('bluePxRastro12G') <= blueG_max) )
        
        %segura botao
        holding_buttons('blue') = true;
        holding_times('blue') = tic;
        % fprintf(galileo,'%c', APERTA_SEM_SOLTAR_BLUE); 
        comandoString(8) = '1'; 
    end

    %quando o rastro acaba solta
    %Se esta_apertando e nao ha mais rastro passando
    if( holding_buttons('blue') && ...
        ~(bluePixelB >= blueB_min && bluePixelB <= blueB_max && ...
          bluePixelG >= blueG_min && bluePixelG <= blueG_max) && ...
        toc(holding_times('blue')) > tempo_espera)

        holding_buttons('blue') = false;
        % fprintf(galileo,'%c', SOLTA_BLUE);  
        comandoString(3) = '1';
    end


    %Orange
    %Segura botao no rastro
    %Se nao esta apertando e passa o rastro pela primeira vez
    if( ~holding_buttons('orange') && ...
        (pixels_rastro('orangePxRastro0R') >= orangeR_min && pixels_rastro('orangePxRastro0R') <= orangeR_max) && ...
        (pixels_rastro('orangePxRastro0G') >= orangeG_min && pixels_rastro('orangePxRastro0G') <= orangeG_max) && ...
        (pixels_rastro('orangePxRastro1R') >= orangeR_min && pixels_rastro('orangePxRastro1R') <= orangeR_max) && ...
        (pixels_rastro('orangePxRastro1G') >= orangeG_min && pixels_rastro('orangePxRastro1G') <= orangeG_max) && ...
        (pixels_rastro('orangePxRastro2R') >= orangeR_min && pixels_rastro('orangePxRastro2R') <= orangeR_max) && ...
        (pixels_rastro('orangePxRastro2G') >= orangeG_min && pixels_rastro('orangePxRastro2G') <= orangeG_max) && ...
        (pixels_rastro('orangePxRastro3R') >= orangeR_min && pixels_rastro('orangePxRastro3R') <= orangeR_max) && ...
        (pixels_rastro('orangePxRastro3G') >= orangeG_min && pixels_rastro('orangePxRastro3G') <= orangeG_max) && ...
        (pixels_rastro('orangePxRastro4R') >= orangeR_min && pixels_rastro('orangePxRastro4R') <= orangeR_max) && ...
        (pixels_rastro('orangePxRastro4G') >= orangeG_min && pixels_rastro('orangePxRastro4G') <= orangeG_max) && ...
        (pixels_rastro('orangePxRastro5R') >= orangeR_min && pixels_rastro('orangePxRastro5R') <= orangeR_max) && ...
        (pixels_rastro('orangePxRastro5G') >= orangeG_min && pixels_rastro('orangePxRastro5G') <= orangeG_max) && ...
        (pixels_rastro('orangePxRastro6R') >= orangeR_min && pixels_rastro('orangePxRastro6R') <= orangeR_max) && ...
        (pixels_rastro('orangePxRastro6G') >= orangeG_min && pixels_rastro('orangePxRastro6G') <= orangeG_max) && ...
        (pixels_rastro('orangePxRastro7R') >= orangeR_min && pixels_rastro('orangePxRastro7R') <= orangeR_max) && ...
        (pixels_rastro('orangePxRastro7G') >= orangeG_min && pixels_rastro('orangePxRastro7G') <= orangeG_max) && ...
        (pixels_rastro('orangePxRastro8R') >= orangeR_min && pixels_rastro('orangePxRastro8R') <= orangeR_max) && ...
        (pixels_rastro('orangePxRastro8G') >= orangeG_min && pixels_rastro('orangePxRastro8G') <= orangeG_max) && ...
        (pixels_rastro('orangePxRastro9R') >= orangeR_min && pixels_rastro('orangePxRastro9R') <= orangeR_max) && ...
        (pixels_rastro('orangePxRastro9G') >= orangeG_min && pixels_rastro('orangePxRastro9G') <= orangeG_max) && ...
        (pixels_rastro('orangePxRastro10R') >= orangeR_min && pixels_rastro('orangePxRastro10R') <= orangeR_max) && ...
        (pixels_rastro('orangePxRastro10G') >= orangeG_min && pixels_rastro('orangePxRastro10G') <= orangeG_max) && ...
        (pixels_rastro('orangePxRastro11R') >= orangeR_min && pixels_rastro('orangePxRastro11R') <= orangeR_max) && ...
        (pixels_rastro('orangePxRastro11G') >= orangeG_min && pixels_rastro('orangePxRastro11G') <= orangeG_max) && ...
        (pixels_rastro('orangePxRastro12R') >= orangeR_min && pixels_rastro('orangePxRastro12R') <= orangeR_max) && ...
        (pixels_rastro('orangePxRastro12G') >= orangeG_min && pixels_rastro('orangePxRastro12G') <= orangeG_max) )
        
        %segura botao
        holding_buttons('orange') = true;
        holding_times('orange') = tic;
        % fprintf(galileo,'%c', APERTA_SEM_SOLTAR_ORANGE);
        comandoString(7) = '1';  
    end

    %quando o rastro acaba solta
    %Se esta_apertando e nao ha mais rastro passando
    if( holding_buttons('orange') && ...
        ~(orangePixelR >= orangeR_min && orangePixelR <= orangeR_max && ...
          orangePixelG >= orangeG_min && orangePixelG <= orangeG_max) && ...
        toc(holding_times('orange')) > tempo_espera)

        holding_buttons('orange') = false;
        % fprintf(galileo,'%c', SOLTA_ORANGE);  
        comandoString(2) = '1';
    end

end