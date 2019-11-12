function press_buttons(vid, arduino)
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

    detected_image = DetectedImage();

    while true

        % get image from camera
        imgO = getdata(vid,1,'uint8');

        detected_image.setSimpleDetection(imgO);
        detected_image.setTrailDetection(imgO);

        % Reinicia a string de comandos
        comandoString = '0000000000000000';
        
        %Segura botao no rastro
        %Se nao esta apertando e passa o rastro pela primeira vez
        [holding_buttons, holding_times, comandoString] = rastro_play(detected_image, holding_buttons, holding_times, comandoString, tempo_espera);
        [holding_buttons, holding_times, comandoString] = simple_note(detected_image, holding_buttons, green_time, red_time, yellow_time, blue_time, orange_time, comandoString, tempo_espera);
        
        envia_comando(arduino, comandoString);
        
    end
end