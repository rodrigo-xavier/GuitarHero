function press_buttons_blue(vid, galileo, color_range, debug_color_pixels)
    blueG_min = color_range('blueG_min');
    blueG_max = color_range('blueG_max');
    blueB_min = color_range('blueB_min');
    blueB_max = color_range('blueB_max');

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
    blue_holding_button = false;

    blue_time = tic;
    blue_holding_time = uint64(0);

    while true
        imgO = getdata(vid,1,'uint8');
        [simple_pixels, pixels_rastro] = get_pixels(imgO);
        bluePixelG = simple_pixels('bluePixelG');
        bluePixelB = simple_pixels('bluePixelB');
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rastro_play %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        if( ~blue_holding_button && ...
            (pixels_rastro('bluePxRastro0B') >= blueB_min && pixels_rastro('bluePxRastro0B') <= blueB_max) && ...
            (pixels_rastro('bluePxRastro0G') >= blueG_min && pixels_rastro('bluePxRastro0G') <= blueG_max) && ...
            (pixels_rastro('bluePxRastro1B') >= blueB_min && pixels_rastro('bluePxRastro1B') <= blueB_max) && ...
            (pixels_rastro('bluePxRastro1G') >= blueG_min && pixels_rastro('bluePxRastro1G') <= blueG_max) && ...
            (pixels_rastro('bluePxRastro2B') >= blueB_min && pixels_rastro('bluePxRastro2B') <= blueB_max) && ...
            (pixels_rastro('bluePxRastro2G') >= blueG_min && pixels_rastro('bluePxRastro2G') <= blueG_max) && ...
            (pixels_rastro('bluePxRastro3B') >= blueB_min && pixels_rastro('bluePxRastro3B') <= blueB_max) && ...
            (pixels_rastro('bluePxRastro3G') >= blueG_min && pixels_rastro('bluePxRastro3G') <= blueG_max) && ...
            (pixels_rastro('bluePxRastro4B') >= blueB_min && pixels_rastro('bluePxRastro4B') <= blueB_max) && ...
            (pixels_rastro('bluePxRastro4G') >= blueG_min && pixels_rastro('bluePxRastro4G') <= blueG_max) && ...
            (pixels_rastro('bluePxRastro5B') >= blueB_min && pixels_rastro('bluePxRastro5B') <= blueB_max) && ...
            (pixels_rastro('bluePxRastro5G') >= blueG_min && pixels_rastro('bluePxRastro5G') <= blueG_max) && ...
            (pixels_rastro('bluePxRastro6B') >= blueB_min && pixels_rastro('bluePxRastro6B') <= blueB_max) && ...
            (pixels_rastro('bluePxRastro6G') >= blueG_min && pixels_rastro('bluePxRastro6G') <= blueG_max) && ...
            (pixels_rastro('bluePxRastro7B') >= blueB_min && pixels_rastro('bluePxRastro7B') <= blueB_max) && ...
            (pixels_rastro('bluePxRastro7G') >= blueG_min && pixels_rastro('bluePxRastro7G') <= blueG_max) && ...
            (pixels_rastro('bluePxRastro8B') >= blueB_min && pixels_rastro('bluePxRastro8B') <= blueB_max) && ...
            (pixels_rastro('bluePxRastro8G') >= blueG_min && pixels_rastro('bluePxRastro8G') <= blueG_max) && ...
            (pixels_rastro('bluePxRastro9B') >= blueB_min && pixels_rastro('bluePxRastro9B') <= blueB_max) && ...
            (pixels_rastro('bluePxRastro9G') >= blueG_min && pixels_rastro('bluePxRastro9G') <= blueG_max) && ...
            (pixels_rastro('bluePxRastro10B') >= blueB_min && pixels_rastro('bluePxRastro10B') <= blueB_max) && ...
            (pixels_rastro('bluePxRastro10G') >= blueG_min && pixels_rastro('bluePxRastro10G') <= blueG_max) && ...
            (pixels_rastro('bluePxRastro11B') >= blueB_min && pixels_rastro('bluePxRastro11B') <= blueB_max) && ...
            (pixels_rastro('bluePxRastro11G') >= blueG_min && pixels_rastro('bluePxRastro11G') <= blueG_max) && ...
            (pixels_rastro('bluePxRastro12B') >= blueB_min && pixels_rastro('bluePxRastro12B') <= blueB_max) && ...
            (pixels_rastro('bluePxRastro12G') >= blueG_min && pixels_rastro('bluePxRastro12G') <= blueG_max) )
            
            %segura botao
            blue_holding_button = true;
            blue_holding_time = tic;
            comandoString(8) = '1'; % Aperta sem soltar azul
        end

        %quando o rastro acaba solta
        %Se esta_apertando e nao ha mais rastro passando
        if( blue_holding_button && ...
            ~(bluePixelB >= blueB_min && bluePixelB <= blueB_max && ...
            bluePixelG >= blueG_min && bluePixelG <= blueG_max) && ...
            toc(blue_holding_time) > tempo_espera)

            blue_holding_button = false;
            comandoString(3) = '1'; % Solta azul
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rastro_play %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %detect blue
        if(bluePixelG >= blueG_min && bluePixelG <= blueG_max && ...
           bluePixelB >= blueB_min && bluePixelB <= blueB_max && ...
           toc(blue_time) > tempo_espera &&  ~blue_holding_button)

           comandoString(13) = '1'; % Aperta e solta azul
           blue_time = tic;
        end

        envia_comando(galileo, comandoString);

        if(debug_color_pixels)

            % Simple Blue
            imgO(312,354,R) = 0;
            imgO(312,354,G) = 255;
            imgO(312,354,B) = 0;

            %TODO
            %Rastro Blue

            imagesc(imgO);

        end
    end
end