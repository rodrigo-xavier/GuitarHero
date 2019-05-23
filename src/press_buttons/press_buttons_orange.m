function press_buttons_orange(vid, galileo)
    orangeR_min = 175;
    orangeR_max = 255;
    orangeG_min = 95;
    orangeG_max = 255;

    % acoes
    APERTA_E_SOLTA_ORANGE = char(140);
    APERTA_SEM_SOLTAR_ORANGE = char(141);
    SOLTA_ORANGE = char(142);

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
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rastro_play %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        if( ~holding_buttons('orange') && ...
            (imgO(294,387,R) >= orangeR_min && imgO(294,387,G) <= orangeR_max) && ...
            (imgO(294,387,G) >= orangeG_min && imgO(294,387,G) <= orangeG_max) && ...
            (imgO(293,387,R) >= orangeR_min && imgO(293,387,R) <= orangeR_max) && ...
            (imgO(293,387,G) >= orangeG_min && imgO(293,387,G) <= orangeG_max) && ...
            (imgO(292,386,R) >= orangeR_min && imgO(292,386,R) <= orangeR_max) && ...
            (imgO(292,386,G) >= orangeG_min && imgO(292,386,G) <= orangeG_max) && ...
            (imgO(291,386,R) >= orangeR_min && imgO(291,386,R) <= orangeR_max) && ...
            (imgO(291,386,G) >= orangeG_min && imgO(291,386,G) <= orangeG_max) && ...
            (imgO(290,386,R) >= orangeR_min && imgO(290,386,R) <= orangeR_max) && ...
            (imgO(290,386,G) >= orangeG_min && imgO(290,386,G) <= orangeG_max) && ...
            (imgO(289,385,R) >= orangeR_min && imgO(289,385,R) <= orangeR_max) && ...
            (imgO(289,385,G) >= orangeG_min && imgO(289,385,G) <= orangeG_max) && ...
            (imgO(288,385,R) >= orangeR_min && imgO(288,385,R) <= orangeR_max) && ...
            (imgO(288,385,G) >= orangeG_min && imgO(288,385,G) <= orangeG_max) && ...
            (imgO(287,385,R) >= orangeR_min && imgO(287,385,R) <= orangeR_max) && ...
            (imgO(287,385,G) >= orangeG_min && imgO(287,385,G) <= orangeG_max) && ...
            (imgO(286,384,R) >= orangeR_min && imgO(286,384,R) <= orangeR_max) && ...
            (imgO(286,384,G) >= orangeG_min && imgO(286,384,G) <= orangeG_max) && ...
            (imgO(285,384,R) >= orangeR_min && imgO(285,384,R) <= orangeR_max) && ...
            (imgO(285,384,G) >= orangeG_min && imgO(285,384,G) <= orangeG_max) && ...
            (imgO(284,384,R) >= orangeR_min && imgO(284,384,R) <= orangeR_max) && ...
            (imgO(284,384,G) >= orangeG_min && imgO(284,384,G) <= orangeG_max) && ...
            (imgO(283,383,R) >= orangeR_min && imgO(283,383,R) <= orangeR_max) && ...
            (imgO(283,383,G) >= orangeG_min && imgO(283,383,G) <= orangeG_max) && ...
            (imgO(282,382,R) >= orangeR_min && imgO(282,382,R) <= orangeR_max) && ...
            (imgO(282,382,G) >= orangeG_min && imgO(282,382,G) <= orangeG_max) )
            
            %segura botao
            holding_buttons('orange') = true;
            holding_times('orange') = tic;
            fprintf(galileo,'%c', APERTA_SEM_SOLTAR_ORANGE);  
        end
    
        %quando o rastro acaba solta
        %Se esta_apertando e nao ha mais rastro passando
        if( holding_buttons('orange') && ...
            ~(imgO(312,311,R) >= orangeR_min && imgO(312,311,R) <= orangeR_max && ...
              imgO(312,311,G) >= orangeG_min && imgO(312,311,G) <= orangeG_max) && ...
            toc(holding_times('orange')) > tempo_espera)
    
            holding_buttons('orange') = false;
            fprintf(galileo,'%c', SOLTA_ORANGE);  
    
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rastro_play %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %detect orange
        if(orangePixelR >= orangeR_min && orangePixelR <= orangeR_max && ...
           orangePixelG >= orangeG_min && orangePixelG <= orangeG_max && ...
           toc(orange_time) > tempo_espera &&  ~holding_buttons('orange'))
           fprintf(galileo,'%c', APERTA_E_SOLTA_ORANGE);
           orange_time = tic;
        end
    end
end