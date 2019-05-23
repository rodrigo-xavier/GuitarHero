function press_buttons_green(vid, galileo)
    green_min = 175;
    green_max = 255;

    % acoes
    APERTA_E_SOLTA_GREEN = char(110);
    APERTA_SEM_SOLTAR_GREEN = char(111);
    SOLTA_GREEN = char(112);

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
        

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rastro_play %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        if( ~holding_buttons('green') && ...
            (imgO(293,238,G) >= green_min && imgO(293,238,G) <= green_max) && ...
            (imgO(292,238,G) >= green_min && imgO(292,238,G) <= green_max) && ...
            (imgO(291,239,G) >= green_min && imgO(291,239,G) <= green_max) && ...
            (imgO(290,239,G) >= green_min && imgO(290,239,G) <= green_max) && ...
            (imgO(289,239,G) >= green_min && imgO(289,239,G) <= green_max) && ...
            (imgO(288,240,G) >= green_min && imgO(288,240,G) <= green_max) && ...
            (imgO(287,240,G) >= green_min && imgO(287,240,G) <= green_max) && ...
            (imgO(286,240,G) >= green_min && imgO(286,240,G) <= green_max) && ...
            (imgO(285,241,G) >= green_min && imgO(285,241,G) <= green_max) && ...
            (imgO(284,241,G) >= green_min && imgO(284,241,G) <= green_max) && ...
            (imgO(283,241,G) >= green_min && imgO(283,241,G) <= green_max) && ...
            (imgO(282,242,G) >= green_min && imgO(282,242,G) <= green_max) && ...
            (imgO(281,243,G) >= green_min && imgO(281,243,G) <= green_max) )
    
            %segura botao
            holding_buttons('green') = true;
            holding_times('green') = tic;
            fprintf(galileo,'%c', APERTA_SEM_SOLTAR_GREEN);  
        end
    
        %quando o rastro acaba solta
        %Se esta_apertando e nao ha mais rastro passando
        if( holding_buttons('green') && ...
            ~(imgO(312,230,G) >= green_min && imgO(312,230,G) <= green_max) && ...
            toc(holding_times('green')) > tempo_espera)
    
            holding_buttons('green') = false;
            fprintf(galileo,'%c', SOLTA_GREEN);  
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rastro_play %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        if( greenPixel >= green_min && greenPixel <= green_max &&  ...
            ~holding_buttons('green') && ...
            toc(green_time) > tempo_espera )
            fprintf(galileo,'%c', APERTA_E_SOLTA_GREEN);
            green_time = tic;
        end
    end
end