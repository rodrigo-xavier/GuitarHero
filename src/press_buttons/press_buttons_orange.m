function press_buttons_orange(vid, galileo, color_range, debug_color_pixels)
    orangeR_min = color_range('orangeR_min');
    orangeR_max = color_range('orangeR_max');
    orangeG_min = color_range('orangeG_min');
    orangeG_max = color_range('orangeG_max');

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
    orange_holding_button = false;
    
    orange_time = tic;
    orange_holding_time = uint64(0);

    while true
        imgO = getdata(vid,1,'uint8');
        [simple_pixels, pixels_rastro] = get_pixels(imgO);
        orangePixelR = simple_pixels('orangePixelR');
        orangePixelG = simple_pixels('orangePixelG');
        
        % Reinicia a string de comandos
        comandoString = '0000000000000000';
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rastro_play %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        if( ~orange_holding_button && ...
            (pixels_rastro('orangePxRastro0R') >= orangeR_min && pixels_rastro('orangePxRastro0R') <= orangeR_max) && ...
            (pixels_rastro('orangePxRastro0G') >= orangeG_min && pixels_rastro('orangePxRastro0G') <= orangeG_max) && ...
            (pixels_rastro('orangePxRastro1R') >= orangeR_min && pixels_rastro('orangePxRastro1R') <= orangeR_max) && ...
            (pixels_rastro('orangePxRastro1G') >= orangeG_min && pixels_rastro('orangePxRastro1G') <= orangeG_max) && ...
            (pixels_rastro('orangePxRastro2R') >= orangeR_min && pixels_rastro('orangePxRastro2R') <= orangeR_max) && ...
            (pixels_rastro('orangePxRastro2G') >= orangeG_min && pixels_rastro('orangePxRastro2G') <= orangeG_max) && ...
            (pixels_rastro('orangePxRastro3R') >= orangeR_min && pixels_rastro('orangePxRastro3R') <= orangeR_max) && ...
            (pixels_rastro('orangePxRastro3G') >= orangeG_min && pixels_rastro('orangePxRastro3G') <= orangeG_max) && ...
            (pixels_rastro('orangePxRastro4R') >= orangeR_min && pixels_rastro('orangePxRastro4R') <= orangeR_max) && ...
            (pixels_rastro('orangePxRastro4G') >= orangeG_min && pixels_rastro('orangePxRastro4G') <= orangeG_max) && ...
            (pixels_rastro('orangePxRastro5R') >= orangeR_min && pixels_rastro('orangePxRastro5R') <= orangeR_max) && ...
            (pixels_rastro('orangePxRastro5G') >= orangeG_min && pixels_rastro('orangePxRastro5G') <= orangeG_max) && ...
            (pixels_rastro('orangePxRastro6R') >= orangeR_min && pixels_rastro('orangePxRastro6R') <= orangeR_max) && ...
            (pixels_rastro('orangePxRastro6G') >= orangeG_min && pixels_rastro('orangePxRastro6G') <= orangeG_max) && ...
            (pixels_rastro('orangePxRastro7R') >= orangeR_min && pixels_rastro('orangePxRastro7R') <= orangeR_max) && ...
            (pixels_rastro('orangePxRastro7G') >= orangeG_min && pixels_rastro('orangePxRastro7G') <= orangeG_max) && ...
            (pixels_rastro('orangePxRastro8R') >= orangeR_min && pixels_rastro('orangePxRastro8R') <= orangeR_max) && ...
            (pixels_rastro('orangePxRastro8G') >= orangeG_min && pixels_rastro('orangePxRastro8G') <= orangeG_max) && ...
            (pixels_rastro('orangePxRastro9R') >= orangeR_min && pixels_rastro('orangePxRastro9R') <= orangeR_max) && ...
            (pixels_rastro('orangePxRastro9G') >= orangeG_min && pixels_rastro('orangePxRastro9G') <= orangeG_max) && ...
            (pixels_rastro('orangePxRastro10R') >= orangeR_min && pixels_rastro('orangePxRastro10R') <= orangeR_max) && ...
            (pixels_rastro('orangePxRastro10G') >= orangeG_min && pixels_rastro('orangePxRastro10G') <= orangeG_max) && ...
            (pixels_rastro('orangePxRastro11R') >= orangeR_min && pixels_rastro('orangePxRastro11R') <= orangeR_max) && ...
            (pixels_rastro('orangePxRastro11G') >= orangeG_min && pixels_rastro('orangePxRastro11G') <= orangeG_max) && ...
            (pixels_rastro('orangePxRastro12R') >= orangeR_min && pixels_rastro('orangePxRastro12R') <= orangeR_max) && ...
            (pixels_rastro('orangePxRastro12G') >= orangeG_min && pixels_rastro('orangePxRastro12G') <= orangeG_max) )
            
            %segura botao
            orange_holding_button = true;
            orange_holding_time = tic;
            comandoString(7) = '1';  % Aperta sem soltar laranja 
        end
    
        %quando o rastro acaba solta
        %Se esta_apertando e nao ha mais rastro passando
        if( orange_holding_button && ...
            ~(imgO(312,311,R) >= orangeR_min && imgO(312,311,R) <= orangeR_max && ...
              imgO(312,311,G) >= orangeG_min && imgO(312,311,G) <= orangeG_max) && ...
            toc(orange_holding_time) > tempo_espera)
    
            orange_holding_button = false;
            comandoString(2) = '1'; % Solta laranja
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rastro_play %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %detect orange
        if(orangePixelR >= orangeR_min && orangePixelR <= orangeR_max && ...
           orangePixelG >= orangeG_min && orangePixelG <= orangeG_max && ...
           toc(orange_time) > tempo_espera &&  ~orange_holding_button)

           comandoString(12) = '1'; % Aperta e solta laranja
           orange_time = tic;
        end

        envia_comando(galileo, comandoString);

        if(debug_color_pixels)
            
            % Simple Orange
            imgO(311,395,R) = 0;
            imgO(311,395,G) = 255;
            imgO(311,395,B) = 0;

            %TODO
            %Rastro Orange

            imagesc(imgO);
        end
    end
end