function press_all_buttons(vid, galileo, color_range, debug_color_pixels)

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

    % tempos
    
    % envia os tempos para o arduino, ou verifica se os tempos
    % estão corretos, caso o arduino já possua o tempo
    [tempo_simples, tempo_rastro] = detect_times(vid);
    tempo_espera = tempo_rastro - tempo_simples;
    configure_arduino_time(galileo, tempo_simples, tempo_rastro);
    
    R = 1;
    G = 2;
    B = 3;

    % situacao de rastro das cores
    keys = {'green', 'red', 'yellow', 'blue', 'orange'};
    values = [false false false false false];
    holding_buttons = containers.Map(keys, values);

    keys = {'green', 'red', 'yellow', 'blue', 'orange'};
    values = [uint64(0) uint64(0) uint64(0) uint64(0) uint64(0)];
    holding_times = containers.Map(keys, values);
    
    green_time = tic;
    red_time = tic;
    yellow_time = tic;
    blue_time = tic;
    orange_time = tic;

    preview(vid);
    while true
        % get image from camera
        imgO = getdata(vid,1,'uint8');
        [simple_pixels, pixels_rastro] = get_pixels(imgO);

        % Reinicia a string de comandos
        comandoString = '0000000000000000';

        % TODO: Verificar se os pixels estao corretos
        greenPixel = simple_pixels('greenPixel');
        redPixel = simple_pixels('redPixel');
        yellowPixelR = simple_pixels('yellowPixelR');
        yellowPixelG = simple_pixels('yellowPixelG');
        bluePixelG = simple_pixels('bluePixelG');
        bluePixelB = simple_pixels('bluePixelB');
        orangePixelR = simple_pixels('orangePixelR');
        orangePixelG = simple_pixels('orangePixelG');
        
        %Segura botao no rastro
        %Se nao esta apertando e passa o rastro pela primeira vez
        [holding_buttons, holding_times, comandoString] = rastro_play(galileo, pixels_rastro, simple_pixels, color_range, holding_buttons, holding_times, comandoString);
        
        %detect green
        if( greenPixel >= green_min && greenPixel <= green_max &&  ...
            ~holding_buttons('green') && ...
            toc(green_time) > tempo_espera )
            comandoString(16) = '1';
            green_time = tic;
        end


        %detect red   
        if( redPixel >= red_min && redPixel <= red_max && ...
            ~holding_buttons('red') ...
            && toc(red_time) > tempo_espera )
            comandoString(15) = '1';
            red_time = tic;
        end

        %detect yellow
        if(yellowPixelR >= yellowR_min && yellowPixelR <= yellowR_max && ...
           yellowPixelG >= yellowG_min && yellowPixelG <= yellowG_max && ...
           toc(yellow_time) > tempo_espera &&  ~holding_buttons('yellow'))
           comandoString(14) = '1';
           yellow_time = tic;
        end

        %detect blue
        if(bluePixelG >= blueG_min && bluePixelG <= blueG_max && ...
           bluePixelB >= blueB_min && bluePixelB <= blueB_max && ...
           toc(blue_time) > tempo_espera &&  ~holding_buttons('blue'))
           comandoString(13) = '1';
           blue_time = tic;
        end

        %detect orange
        if(orangePixelR >= orangeR_min && orangePixelR <= orangeR_max && ...
           orangePixelG >= orangeG_min && orangePixelG <= orangeG_max && ...
           toc(orange_time) > tempo_espera &&  ~holding_buttons('orange'))
           comandoString(12) = '1';
           orange_time = tic;
        end
        
        envia_comando(galileo, comandoString);
        
        if(debug_color_pixels)
            % Colore de verde os pixels que estão sendo utilizados

            % Simple Green
            imgO(312,230,R) = 0;
            imgO(312,230,G) = 255;
            imgO(312,230,B) = 0;

            % Simple Red
            imgO(311,274,R) = 0;
            imgO(311,274,G) = 255;
            imgO(311,274,B) = 0;

            % Simple Yellow
            imgO(312,311,R) = 0;
            imgO(312,311,G) = 255;
            imgO(312,311,B) = 0;

            % Simple Blue
            imgO(312,354,R) = 0;
            imgO(312,354,G) = 255;
            imgO(312,354,B) = 0;

            % Simple Orange
            imgO(311,395,R) = 0;
            imgO(311,395,G) = 255;
            imgO(311,395,B) = 0;

            % Rastro Vermelho
            imgO(293,275,R) = 0;
            imgO(293,275,G) = 255;
            imgO(293,275,B) = 0;
            imgO(292,275,R) = 0;
            imgO(292,275,G) = 255;
            imgO(292,275,B) = 0;
            imgO(291,275,R) = 0;
            imgO(291,275,G) = 255;
            imgO(291,275,B) = 0;
            imgO(290,276,R) = 0;
            imgO(290,276,G) = 255;
            imgO(290,276,B) = 0;
            imgO(289,276,R) = 0;
            imgO(289,276,G) = 255;
            imgO(289,276,B) = 0;
            imgO(288,276,R) = 0;
            imgO(288,276,G) = 255;
            imgO(288,276,B) = 0;
            imgO(287,276,R) = 0;
            imgO(287,276,G) = 255;
            imgO(287,276,B) = 0;
            imgO(286,276,R) = 0;
            imgO(286,276,G) = 255;
            imgO(286,276,B) = 0;
            imgO(285,277,R) = 0;
            imgO(285,277,G) = 255;
            imgO(285,277,B) = 0;
            imgO(284,277,R) = 0;
            imgO(284,277,G) = 255;
            imgO(284,277,B) = 0;
            imgO(283,277,R) = 0;
            imgO(283,277,G) = 255;
            imgO(283,277,B) = 0;
            imgO(282,277,R) = 0;
            imgO(282,277,G) = 255;
            imgO(282,277,B) = 0;
            imgO(281,278,R) = 0;
            imgO(281,278,G) = 255;
            imgO(281,278,B) = 0;

            imagesc(imgO);
        end
    end
end