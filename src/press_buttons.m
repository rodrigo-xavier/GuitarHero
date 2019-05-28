function press_buttons(vid, galileo, color_range, debug_color_pixels)
    % cores
    
    red_min = 175;
    red_max = 255;
    green_min = 175;
    green_max = 255;
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

    values = [uint64(0) uint64(0) uint64(0) uint64(0) uint64(0)];
    holding_times = containers.Map(keys, values);
    
    green_time = tic;
    red_time = tic;
    yellow_time = tic;
    blue_time = tic;
    orange_time = tic;

    while true
        imgO = getdata(vid,1,'uint8');

        simple_pixels = get_pixels(imgO);

        % Reinicia a string de comandos
        comandoString = '0000000000000000';
        
        %Segura botao no rastro
        %Se nao esta apertando e passa o rastro pela primeira vez
        [holding_buttons, holding_times, comandoString] = rastro_play(galileo, imgO, holding_buttons, holding_times, comandoString);
        
        %detect green
        if(simple_pixels('greenPixel') >= green_min && ...
           simple_pixels('greenPixel') <= green_max &&  ...
           ~holding_buttons('green') && ...
           toc(green_time) > tempo_espera )
            comandoString(16) = '1';
            green_time = tic;
        end

        %detect red   
        if(simple_pixels('redPixel') >= red_min && ...
           simple_pixels('redPixel') <= red_max && ...
           ~holding_buttons('red') && ...
           toc(red_time) > tempo_espera )
            comandoString(15) = '1';
            red_time = tic;
        end

        %detect yellow
        if(simple_pixels('yellowPixelR') >= yellowR_min && ...
           simple_pixels('yellowPixelR') <= yellowR_max && ...
           simple_pixels('yellowPixelG') >= yellowG_min && ...
           simple_pixels('yellowPixelG') <= yellowG_max && ...
           toc(yellow_time) > tempo_espera &&  ...
           ~holding_buttons('yellow'))
            comandoString(14) = '1';
            yellow_time = tic;
        end

        %detect blue
        if(simple_pixels('bluePixelG') >= blueG_min && ...
           simple_pixels('bluePixelG') <= blueG_max && ...
           simple_pixels('bluePixelB') >= blueB_min && ...
           simple_pixels('bluePixelB') <= blueB_max && ...
           toc(blue_time) > tempo_espera &&  ~holding_buttons('blue'))
            comandoString(13) = '1';
            blue_time = tic;
        end

        %detect orange
        if(simple_pixels('orangePixelR') >= orangeR_min && ...
           simple_pixels('orangePixelR') <= orangeR_max && ...
           simple_pixels('orangePixelG') >= orangeG_min && ...
           simple_pixels('orangePixelG') <= orangeG_max && ...
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