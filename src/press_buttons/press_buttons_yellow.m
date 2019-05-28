function press_buttons_yellow(vid, galileo, color_range, debug_color_pixels)
    yellowR_min = color_range('yellowR_min');
    yellowR_max = color_range('yellowR_max');
    yellowG_min = color_range('yellowG_min');
    yellowG_max = color_range('yellowG_max');

    [tempo_simples, tempo_rastro] = detect_times(vid);
    tempo_espera = tempo_rastro - tempo_simples;
    configure_arduino_time(galileo, tempo_simples, tempo_rastro);
    
    R = 1;
    G = 2;
    B = 3;

    % situacao de rastro das cores
    yellow_holding_button = false;

    yellow_time = tic;
    yellow_holding_time = uint64(0);

    while true
        imgO = getdata(vid,1,'uint8');
        [simple_pixels, pixels_rastro] = get_pixels(imgO);
        yellowPixelR = simple_pixels('yellowPixelR');
        yellowPixelG = simple_pixels('yellowPixelG');

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rastro_play %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        if( ~yellow_holding_button && ...
            (pixels_rastro('yellowPxRastro0R') >= yellowR_min && pixels_rastro('yellowPxRastro0R') <= yellowR_max) && ...
            (pixels_rastro('yellowPxRastro0G') >= yellowG_min && pixels_rastro('yellowPxRastro0G') <= yellowG_max) && ...
            (pixels_rastro('yellowPxRastro1R') >= yellowR_min && pixels_rastro('yellowPxRastro1R') <= yellowR_max) && ...
            (pixels_rastro('yellowPxRastro1G') >= yellowG_min && pixels_rastro('yellowPxRastro1G') <= yellowG_max) && ...
            (pixels_rastro('yellowPxRastro2R') >= yellowR_min && pixels_rastro('yellowPxRastro2R') <= yellowR_max) && ...
            (pixels_rastro('yellowPxRastro2G') >= yellowG_min && pixels_rastro('yellowPxRastro2G') <= yellowG_max) && ...
            (pixels_rastro('yellowPxRastro3R') >= yellowR_min && pixels_rastro('yellowPxRastro3R') <= yellowR_max) && ...
            (pixels_rastro('yellowPxRastro3G') >= yellowG_min && pixels_rastro('yellowPxRastro3G') <= yellowG_max) && ...
            (pixels_rastro('yellowPxRastro4R') >= yellowR_min && pixels_rastro('yellowPxRastro4R') <= yellowR_max) && ...
            (pixels_rastro('yellowPxRastro4G') >= yellowG_min && pixels_rastro('yellowPxRastro4G') <= yellowG_max) && ...
            (pixels_rastro('yellowPxRastro5R') >= yellowR_min && pixels_rastro('yellowPxRastro5R') <= yellowR_max) && ...
            (pixels_rastro('yellowPxRastro5G') >= yellowG_min && pixels_rastro('yellowPxRastro5G') <= yellowG_max) && ...
            (pixels_rastro('yellowPxRastro6R') >= yellowR_min && pixels_rastro('yellowPxRastro6R') <= yellowR_max) && ...
            (pixels_rastro('yellowPxRastro6G') >= yellowG_min && pixels_rastro('yellowPxRastro6G') <= yellowG_max) && ...
            (pixels_rastro('yellowPxRastro7R') >= yellowR_min && pixels_rastro('yellowPxRastro7R') <= yellowR_max) && ...
            (pixels_rastro('yellowPxRastro7G') >= yellowG_min && pixels_rastro('yellowPxRastro7G') <= yellowG_max) && ...
            (pixels_rastro('yellowPxRastro8R') >= yellowR_min && pixels_rastro('yellowPxRastro8R') <= yellowR_max) && ...
            (pixels_rastro('yellowPxRastro8G') >= yellowG_min && pixels_rastro('yellowPxRastro8G') <= yellowG_max) && ...
            (pixels_rastro('yellowPxRastro9R') >= yellowR_min && pixels_rastro('yellowPxRastro9R') <= yellowR_max) && ...
            (pixels_rastro('yellowPxRastro9G') >= yellowG_min && pixels_rastro('yellowPxRastro9G') <= yellowG_max) && ...
            (pixels_rastro('yellowPxRastro10R') >= yellowR_min && pixels_rastro('yellowPxRastro10R') <= yellowR_max) && ...
            (pixels_rastro('yellowPxRastro10G') >= yellowG_min && pixels_rastro('yellowPxRastro10G') <= yellowG_max) && ...
            (pixels_rastro('yellowPxRastro11R') >= yellowR_min && pixels_rastro('yellowPxRastro11R') <= yellowR_max) && ...
            (pixels_rastro('yellowPxRastro11G') >= yellowG_min && pixels_rastro('yellowPxRastro11G') <= yellowG_max) && ...
            (pixels_rastro('yellowPxRastro12R') >= yellowR_min && pixels_rastro('yellowPxRastro12R') <= yellowR_max) && ...
            (pixels_rastro('yellowPxRastro12G') >= yellowG_min && pixels_rastro('yellowPxRastro12G') <= yellowG_max) )
            
            %segura botao
            yellow_holding_button = true;
            yellow_holding_time = tic;
            comandoString(9) = '1';  % Aperta sem soltar amarelo
        end
    
        %quando o rastro acaba solta
        %Se esta_apertando e nao ha mais rastro passando
        if( yellow_holding_button && ...
            ~(yellowPixelR >= yellowR_min && yellowPixelR <= yellowR_max && ...
              yellowPixelG >= yellowG_min && yellowPixelG <= yellowG_max) && ...
            toc(yellow_holding_time) > tempo_espera)
    
            yellow_holding_button = false;
            comandoString(4) = '1'; % Solta amarelo
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rastro_play %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %detect yellow
        if(yellowPixelR >= yellowR_min && yellowPixelR <= yellowR_max && ...
           yellowPixelG >= yellowG_min && yellowPixelG <= yellowG_max && ...
           toc(yellow_time) > tempo_espera &&  ~yellow_holding_button)
           comandoString(14) = '1'; % Aperta e solta amarelo
           yellow_time = tic;
        end

        envia_comando(galileo, comandoString);

        if(debug_color_pixels)
            % Simple Yellow
            imgO(312,311,R) = 0;
            imgO(312,311,G) = 255;
            imgO(312,311,B) = 0;

            %TODO
            %Rastro Yellow

            imagesc(imgO);
        end
    end
end