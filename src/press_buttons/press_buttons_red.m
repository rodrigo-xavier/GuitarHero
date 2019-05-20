function press_buttons_red(vid, galileo)
    red_min = 175;
    red_max = 255;

    % acoes
    APERTA_E_SOLTA_RED = char(100);
    
    [tempo_simples, tempo_rastro] = detect_times(vid);
    tempo_espera = tempo_rastro - tempo_simples;
    configure_arduino_time(galileo, tempo_simples, tempo_rastro);
    
    R = 1;

    keys = {'red'};
    values = [false];
    holding_buttons = containers.Map(keys, values);

    keys = {'red'};
    values = [uint64(0)];
    holding_times = containers.Map(keys, values);
    
    red_time = tic;

    while true
        imgO = getdata(vid,1,'uint8');
        redPixel = imgO(311,274,R);
        
        [holding_buttons, holding_times] = rastro_play(galileo, imgO, holding_buttons, holding_times);
        
        %detect red   
        if( redPixel >= red_min && redPixel <= red_max && ...
            ~holding_buttons('red') ...
            && toc(red_time) > tempo_espera )
            fprintf(galileo,'%c', APERTA_E_SOLTA_RED);
            red_time = tic;
        end
    end
end