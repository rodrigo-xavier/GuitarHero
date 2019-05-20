function press_buttons_yellow(vid, galileo)
    yellowR_min = 175;
    yellowR_max = 255;
    yellowG_min = 150;
    yellowG_max = 255;

    APERTA_E_SOLTA_YELLOW = char(120);

    [tempo_simples, tempo_rastro] = detect_times(vid);
    tempo_espera = tempo_rastro - tempo_simples;
    configure_arduino_time(galileo, tempo_simples, tempo_rastro);
    
    R = 1;
    G = 2;

    % situacao de rastro das cores
    keys = {'yellow'};
    values = [false];
    holding_buttons = containers.Map(keys, values);

    keys = {'yellow'};
    values = [uint64(0)];
    holding_times = containers.Map(keys, values);
    
    yellow_time = tic;

    while true
        imgO = getdata(vid,1,'uint8');
        yellowPixelR = imgO(312,311,R);
        yellowPixelG = imgO(312,311,G);

        [holding_buttons, holding_times] = rastro_play(galileo, imgO, holding_buttons, holding_times);

        %detect yellow
        if(yellowPixelR >= yellowR_min && yellowPixelR <= yellowR_max && ...
           yellowPixelG >= yellowG_min && yellowPixelG <= yellowG_max && ...
           toc(yellow_time) > tempo_espera &&  ~holding_buttons('yellow'))
           fprintf(galileo,'%c', APERTA_E_SOLTA_YELLOW);
           yellow_time = tic;
        end
    end
end