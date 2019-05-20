function press_buttons_orange(vid, galileo)
    orangeR_min = 175;
    orangeR_max = 255;
    orangeG_min = 95;
    orangeG_max = 255;

    % acoes
    APERTA_E_SOLTA_ORANGE = char(140);

    % tempos
    
    % envia os tempos para o arduino, ou verifica se os tempos
    % estão corretos, caso o arduino já possua o tempo
    [tempo_simples, tempo_rastro] = detect_times(vid);
    tempo_espera = tempo_rastro - tempo_simples;
    configure_arduino_time(galileo, tempo_simples, tempo_rastro);
    
    R = 1;
    G = 2;

    % situacao de rastro das cores
    keys = {'orange'};
    values = [false];
    holding_buttons = containers.Map(keys, values);

    keys = {'orange'};
    values = [uint64(0)];
    holding_times = containers.Map(keys, values);
    
    orange_time = tic;

    while true
        imgO = getdata(vid,1,'uint8');
        orangePixelR = imgO(311,395,R);
        orangePixelG = imgO(311,395,G);
        
        %Segura botao no rastro
        %Se nao esta apertando e passa o rastro pela primeira vez
        [holding_buttons, holding_times] = rastro_play(galileo, imgO, holding_buttons, holding_times);

        %detect orange
        if(orangePixelR >= orangeR_min && orangePixelR <= orangeR_max && ...
           orangePixelG >= orangeG_min && orangePixelG <= orangeG_max && ...
           toc(orange_time) > tempo_espera &&  ~holding_buttons('orange'))
           fprintf(galileo,'%c', APERTA_E_SOLTA_ORANGE);
           orange_time = tic;
        end
    end
end