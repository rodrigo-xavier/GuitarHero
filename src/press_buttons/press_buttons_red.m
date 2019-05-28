function press_buttons_red(vid, galileo, color_range, debug_color_pixels)
    red_min = color_range('red_min');
    red_max = color_range('red_max');
    
    [tempo_simples, tempo_rastro] = detect_times(vid);
    tempo_espera = tempo_rastro - tempo_simples;
    configure_arduino_time(galileo, tempo_simples, tempo_rastro);
    
    R = 1;
    G = 2;
    B = 3;

    red_holding_button = false;
    
    red_time = tic;
    red_holding_time = uint64(0);

    while true
        imgO = getdata(vid,1,'uint8');
        [simple_pixels, pixels_rastro] = get_pixels(imgO);
        redPixel = simple_pixels('redPixel');
        
        % Reinicia a string de comandos
        comandoString = '0000000000000000';
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rastro_play %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        if( ~red_holding_button && ...
            (pixels_rastro('redPxRastro0') >= red_min && pixels_rastro('redPxRastro0') <= red_max) && ...
            (pixels_rastro('redPxRastro1') >= red_min && pixels_rastro('redPxRastro1') <= red_max) && ...
            (pixels_rastro('redPxRastro2') >= red_min && pixels_rastro('redPxRastro2') <= red_max) && ...
            (pixels_rastro('redPxRastro3') >= red_min && pixels_rastro('redPxRastro3') <= red_max) && ...
            (pixels_rastro('redPxRastro4') >= red_min && pixels_rastro('redPxRastro4') <= red_max) && ...
            (pixels_rastro('redPxRastro5') >= red_min && pixels_rastro('redPxRastro5') <= red_max) && ...
            (pixels_rastro('redPxRastro6') >= red_min && pixels_rastro('redPxRastro6') <= red_max) && ...
            (pixels_rastro('redPxRastro7') >= red_min && pixels_rastro('redPxRastro7') <= red_max) && ...
            (pixels_rastro('redPxRastro8') >= red_min && pixels_rastro('redPxRastro8') <= red_max) && ...
            (pixels_rastro('redPxRastro9') >= red_min && pixels_rastro('redPxRastro9') <= red_max) && ...
            (pixels_rastro('redPxRastro10') >= red_min && pixels_rastro('redPxRastro10') <= red_max) && ...
            (pixels_rastro('redPxRastro11') >= red_min && pixels_rastro('redPxRastro11') <= red_max) && ...
            (pixels_rastro('redPxRastro12') >= red_min && pixels_rastro('redPxRastro12') <= red_max) )
    
            %segura botao
            red_holding_button = true;
            red_holding_time = tic;
            
            comandoString(10) = '1'; % Aperta sem soltar vermelho
        end
    
        %quando o rastro acaba solta
        %Se esta_apertando e nao ha mais rastro passando
        if( red_holding_button && ...
            ~(redPixel >= red_min && redPixel <= red_max) && ...
            toc(red_holding_time) > tempo_espera)
    
            red_holding_button = false;
            comandoString(5) = '1'; % Solta vermelho
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rastro_play %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %detect red   
        if( redPixel >= red_min && redPixel <= red_max && ...
            ~red_holding_button ...
            && toc(red_time) > tempo_espera )

            comandoString(15) = '1'; % Aperta e solta Vermelho
            red_time = tic;
        end

        envia_comando(galileo, comandoString);

        if(debug_color_pixels)
            % Simple Red
            imgO(311,274,R) = 0;
            imgO(311,274,G) = 255;
            imgO(311,274,B) = 0;

            % Rastro Vermelho
            imgO(293,275,R) = 0;
            imgO(293,275,G) = 255;
            imgO(293,275,B) = 0;
            imgO(292,275,R) = 0;
            imgO(292,275,G) = 255;
            imgO(292,275,B) = 0;
            imgO(291,275,R) = 0;
            imgO(291,275,G) = 255;
            imgO(291,275,B) = 0;
            imgO(290,276,R) = 0;
            imgO(290,276,G) = 255;
            imgO(290,276,B) = 0;
            imgO(289,276,R) = 0;
            imgO(289,276,G) = 255;
            imgO(289,276,B) = 0;
            imgO(288,276,R) = 0;
            imgO(288,276,G) = 255;
            imgO(288,276,B) = 0;
            imgO(287,276,R) = 0;
            imgO(287,276,G) = 255;
            imgO(287,276,B) = 0;
            imgO(286,276,R) = 0;
            imgO(286,276,G) = 255;
            imgO(286,276,B) = 0;
            imgO(285,277,R) = 0;
            imgO(285,277,G) = 255;
            imgO(285,277,B) = 0;
            imgO(284,277,R) = 0;
            imgO(284,277,G) = 255;
            imgO(284,277,B) = 0;
            imgO(283,277,R) = 0;
            imgO(283,277,G) = 255;
            imgO(283,277,B) = 0;
            imgO(282,277,R) = 0;
            imgO(282,277,G) = 255;
            imgO(282,277,B) = 0;
            imgO(281,278,R) = 0;
            imgO(281,278,G) = 255;
            imgO(281,278,B) = 0;

            imagesc(imgO);
        end
    end
end