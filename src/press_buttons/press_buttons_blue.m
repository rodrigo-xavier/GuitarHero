function press_buttons_blue(vid, galileo)
    blueG_min = 125;
    blueG_max = 255;
    blueB_min = 175;
    blueB_max = 255;

    % acoes
    APERTA_E_SOLTA_BLUE = char(130);

    % tempos
    
    % envia os tempos para o arduino, ou verifica se os tempos
    % estão corretos, caso o arduino já possua o tempo
    [tempo_simples, tempo_rastro] = detect_times(vid);
    tempo_espera = tempo_rastro - tempo_simples;
    configure_arduino_time(galileo, tempo_simples, tempo_rastro);
    
    G = 2;
    B = 3;

    % situacao de rastro das cores
    keys = {'blue'};
    values = [false];
    holding_buttons = containers.Map(keys, values);

    keys = {'blue'};
    values = [uint64(0)];
    holding_times = containers.Map(keys, values);
    
    green_time = tic;
    red_time = tic;
    yellow_time = tic;
    blue_time = tic;
    orange_time = tic;

    while true
        imgO = getdata(vid,1,'uint8');
        bluePixelG = imgO(312,354,G);
        bluePixelB = imgO(312,354,B);
        
        [holding_buttons, holding_times] = rastro_play(galileo, imgO, holding_buttons, holding_times);

        %detect blue
        if(bluePixelG >= blueG_min && bluePixelG <= blueG_max && ...
           bluePixelB >= blueB_min && bluePixelB <= blueB_max && ...
           toc(blue_time) > tempo_espera &&  ~holding_buttons('blue'))
           fprintf(galileo,'%c', APERTA_E_SOLTA_BLUE);
           blue_time = tic;
        end
    end
end