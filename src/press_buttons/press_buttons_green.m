function press_buttons_green(vid, galileo, color_range, debug_color_pixels)
    green_min = color_range('green_min');
    green_max = color_range('green_max');

    % tempos
    
    % envia os tempos para o arduino, ou verifica se os tempos
    % estão corretos, caso o arduino já possua o tempo
    [tempo_simples, tempo_rastro] = detect_times(vid);
    tempo_espera = tempo_rastro - tempo_simples;
    configure_arduino_time(galileo, tempo_simples, tempo_rastro);
    
    R = 1;
    G = 2;
    B = 3;

    % situacao de rastro das cores
    green_holding_button = false;
    
    green_time = tic;
    green_holding_time = uint64(0);

    while true
        imgO = getdata(vid,1,'uint8');
        [simple_pixels, pixels_rastro] = get_pixels(imgO);
        greenPixel = simple_pixels('greenPixel');

        % Reinicia a string de comandos
        comandoString = '0000000000000000';

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rastro_play %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        if( ~green_holding_button && ...
            (pixels_rastro('greenPxRastro0') >= green_min && pixels_rastro('greenPxRastro0') <= green_max) && ...
            (pixels_rastro('greenPxRastro1') >= green_min && pixels_rastro('greenPxRastro1') <= green_max) && ...
            (pixels_rastro('greenPxRastro2') >= green_min && pixels_rastro('greenPxRastro2') <= green_max) && ...
            (pixels_rastro('greenPxRastro3') >= green_min && pixels_rastro('greenPxRastro3') <= green_max) && ...
            (pixels_rastro('greenPxRastro4') >= green_min && pixels_rastro('greenPxRastro4') <= green_max) && ...
            (pixels_rastro('greenPxRastro5') >= green_min && pixels_rastro('greenPxRastro5') <= green_max) && ...
            (pixels_rastro('greenPxRastro6') >= green_min && pixels_rastro('greenPxRastro6') <= green_max) && ...
            (pixels_rastro('greenPxRastro7') >= green_min && pixels_rastro('greenPxRastro7') <= green_max) && ...
            (pixels_rastro('greenPxRastro8') >= green_min && pixels_rastro('greenPxRastro8') <= green_max) && ...
            (pixels_rastro('greenPxRastro9') >= green_min && pixels_rastro('greenPxRastro9') <= green_max) && ...
            (pixels_rastro('greenPxRastro10') >= green_min && pixels_rastro('greenPxRastro10') <= green_max) && ...
            (pixels_rastro('greenPxRastro11') >= green_min && pixels_rastro('greenPxRastro11') <= green_max) && ...
            (pixels_rastro('greenPxRastro12') >= green_min && pixels_rastro('greenPxRastro12') <= green_max) )
    
            %segura botao
            green_holding_button = true;
            green_holding_time = tic;
            comandoString(11) = '1';  % Aperta sem soltar verde
        end
    
        %quando o rastro acaba solta
        %Se esta_apertando e nao ha mais rastro passando
        if( green_holding_button && ...
            ~(greenPixel >= green_min && ...
            greenPixel <= green_max) && ...
            toc(green_holding_time) > tempo_espera)
    
            green_holding_button = false;
            comandoString(6) = '1'; % Solta verde
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rastro_play %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        if( greenPixel >= green_min && ...
            greenPixel <= green_max &&  ...
            ~green_holding_button && ...
            toc(green_time) > tempo_espera )

            comandoString(16) = '1'; % Aperto simples verde
            green_time = tic;
        end

        envia_comando(galileo, comandoString);

        if debug_color_pixels
            % Simple Green
            imgO(312,230,R) = 0;
            imgO(312,230,G) = 255;
            imgO(312,230,B) = 0;
            
            % TODO
            % Rastro Green

            imagesc(imgO);
        end
    end
end