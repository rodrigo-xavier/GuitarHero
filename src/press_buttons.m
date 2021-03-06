function press_buttons(vid, arduino)
    % cores
    % salvar um arquivo em disco com as variaveis
    % para mudar para apenas load('cores.mat')
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
    % [tempo_simples, tempo_rastro] = detect_time(vid);
    % tempo_espera = tempo_rastro - tempo_simples;
    tempo_espera = 0.000001;

    time = 0.480;
    msg = "OFFTIME: ";
    disp(msg + time);
    configure_arduino_time(arduino, time);
    
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

    while true
        % get image from camera
        imgO = getdata(vid,1,'uint8');

        % TODO: Verificar se os pixels estao corretos
        greenPixel = imgO(312,230,G);
        redPixel = imgO(311,274,R);
        yellowPixelR = imgO(312,311,R);
        yellowPixelG = imgO(312,311,G);
        bluePixelG = imgO(312,354,G);
        bluePixelB = imgO(312,354,B);
        orangePixelR = imgO(311,395,R);
        orangePixelG = imgO(311,395,G);

        % Reinicia a string de comandos
        comandoString = '0000000000000000';
        
        %Segura botao no rastro
        %Se nao esta apertando e passa o rastro pela primeira vez
        [holding_buttons, holding_times, comandoString] = rastro_play(imgO, holding_buttons, holding_times, comandoString, tempo_espera);
        
        %detect green
        if( greenPixel >= green_min && greenPixel <= green_max &&  ...
            ~holding_buttons('green') && ...
            toc(green_time) > tempo_espera )
            % fprintf(arduino,'%c', APERTA_E_SOLTA_GREEN);
            comandoString(16) = '1';
            green_time = tic;
        end


        %detect red   
        if( redPixel >= red_min && redPixel <= red_max && ...
            ~holding_buttons('red') ...
            && toc(red_time) > tempo_espera )
            % fprintf(arduino,'%c', APERTA_E_SOLTA_RED);
            comandoString(15) = '1';
            red_time = tic;
        end

        %detect yellow
        if(yellowPixelR >= yellowR_min && yellowPixelR <= yellowR_max && ...
           yellowPixelG >= yellowG_min && yellowPixelG <= yellowG_max && ...
           toc(yellow_time) > tempo_espera &&  ~holding_buttons('yellow'))
        %    fprintf(arduino,'%c', APERTA_E_SOLTA_YELLOW);
            comandoString(14) = '1';
            yellow_time = tic;
        end

        %detect blue
        if(bluePixelG >= blueG_min && bluePixelG <= blueG_max && ...
           bluePixelB >= blueB_min && bluePixelB <= blueB_max && ...
           toc(blue_time) > tempo_espera &&  ~holding_buttons('blue'))
        %    fprintf(arduino,'%c', APERTA_E_SOLTA_BLUE);
            comandoString(13) = '1';
            blue_time = tic;
        end

        %detect orange
        if(orangePixelR >= orangeR_min && orangePixelR <= orangeR_max && ...
           orangePixelG >= orangeG_min && orangePixelG <= orangeG_max && ...
           toc(orange_time) > tempo_espera &&  ~holding_buttons('orange'))
        %    fprintf(arduino,'%c', APERTA_E_SOLTA_ORANGE);
            comandoString(12) = '1';
            orange_time = tic;
        end
        
        envia_comando(arduino, comandoString);
        
    end
end