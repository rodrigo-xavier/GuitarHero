function press_buttons_green(vid, galileo)
    green_min = 175;
    green_max = 255;

    % acoes
    APERTA_E_SOLTA_GREEN = char(110);

    % tempos
    
    % envia os tempos para o arduino, ou verifica se os tempos
    % estão corretos, caso o arduino já possua o tempo
    [tempo_simples, tempo_rastro] = detect_times(vid);
    tempo_espera = tempo_rastro - tempo_simples;
    configure_arduino_time(galileo, tempo_simples, tempo_rastro);
    
    G = 2;

    % situacao de rastro das cores
    keys = {'green'};
    values = [false];
    holding_buttons = containers.Map(keys, values);

    keys = {'green'};
    values = [uint64(0)];
    holding_times = containers.Map(keys, values);
    
    green_time = tic;

    while true
        imgO = getdata(vid,1,'uint8');
        greenPixel = imgO(312,230,G);
        
        [holding_buttons, holding_times] = rastro_play(galileo, imgO, holding_buttons, holding_times);
        
        if( greenPixel >= green_min && greenPixel <= green_max &&  ...
            ~holding_buttons('green') && ...
            toc(green_time) > tempo_espera )
            fprintf(galileo,'%c', APERTA_E_SOLTA_GREEN);
            green_time = tic;
        end
    end
end