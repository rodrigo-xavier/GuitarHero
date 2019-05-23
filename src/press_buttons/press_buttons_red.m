function press_buttons_red(vid, galileo)
    red_min = 175;
    red_max = 255;

    % acoes
    APERTA_E_SOLTA_RED = char(100);
    APERTA_SEM_SOLTAR_RED = char(101);
    SOLTA_RED = char(102);
    
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
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rastro_play %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        if( ~holding_buttons('red') && ...
            (imgO(293,275,R) >= red_min && imgO(293,275,R) <= red_max) && ...
            (imgO(292,275,R) >= red_min && imgO(292,275,R) <= red_max) && ...
            (imgO(291,275,R) >= red_min && imgO(291,275,R) <= red_max) && ...
            (imgO(290,276,R) >= red_min && imgO(290,276,R) <= red_max) && ...
            (imgO(289,276,R) >= red_min && imgO(289,276,R) <= red_max) && ...
            (imgO(288,276,R) >= red_min && imgO(288,276,R) <= red_max) && ...
            (imgO(287,276,R) >= red_min && imgO(287,276,R) <= red_max) && ...
            (imgO(286,276,R) >= red_min && imgO(286,276,R) <= red_max) && ...
            (imgO(285,277,R) >= red_min && imgO(285,277,R) <= red_max) && ...
            (imgO(284,277,R) >= red_min && imgO(284,277,R) <= red_max) && ...
            (imgO(283,277,R) >= red_min && imgO(283,277,R) <= red_max) && ...
            (imgO(282,277,R) >= red_min && imgO(282,277,R) <= red_max) && ...
            (imgO(281,278,R) >= red_min && imgO(281,278,R) <= red_max) )
    
            %segura botao
            holding_buttons('red') = true;
            holding_times('red') = tic;
            
            fprintf(galileo,'%c', APERTA_SEM_SOLTAR_RED);  
        end
    
        %quando o rastro acaba solta
        %Se esta_apertando e nao ha mais rastro passando
        if( holding_buttons('red') && ...
            ~(imgO(311,274,R) >= red_min && imgO(311,274,R) <= red_max) && ...
            toc(holding_times('red')) > tempo_espera)
    
            holding_buttons('red') = false;
    
            fprintf(galileo,'%c', SOLTA_RED);  
    
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rastro_play %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %detect red   
        if( redPixel >= red_min && redPixel <= red_max && ...
            ~holding_buttons('red') ...
            && toc(red_time) > tempo_espera )
            fprintf(galileo,'%c', APERTA_E_SOLTA_RED);
            red_time = tic;
        end
    end
end