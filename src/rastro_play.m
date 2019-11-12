function [holding_buttons, holding_times, comandoString] = rastro_play(detected_image, imgO, holding_buttons, holding_times, comandoString, tempo_espera)
    %Green
    %Segura botao no rastro
    %Se nao esta apertando e passa o rastro pela primeira vez
    if( ~holding_buttons('green') && detected_image.getTrailDetection('green') )
        %segura botao
        holding_buttons('green') = true;
        holding_times('green') = tic;
        comandoString(11) = '1'; 
    end

    %quando o rastro acaba solta
    %Se esta_apertando e nao ha mais rastro passando
    if( holding_buttons('green') && ...
        ~detected_image.getTrailLastNoteDetection('green') && ...
        toc(holding_times('green')) > tempo_espera)

        holding_buttons('green') = false;
        comandoString(6) = '1';
    end

    % Red
    %Segura botao no rastro
    %Se nao esta apertando e passa o rastro pela primeira vez
    if( ~holding_buttons('red') && detected_image.getTrailDetection('red') )
        %segura botao
        holding_buttons('red') = true;
        holding_times('red') = tic; 
        comandoString(10) = '1'; 
    end

    %quando o rastro acaba solta
    %Se esta_apertando e nao ha mais rastro passando
    if( holding_buttons('red') && ...
        ~getTrailLastNoteDetection('red') && ...
        toc(holding_times('red')) > tempo_espera)

        holding_buttons('red') = false;
        comandoString(5) = '1';

    end

    %Yellow
    %Segura botao no rastro
    %Se nao esta apertando e passa o rastro pela primeira vez
    if( ~holding_buttons('yellow') && detected_image.getTrailDetection('yellow') )
        %segura botao
        holding_buttons('yellow') = true;
        holding_times('yellow') = tic;
        comandoString(9) = '1';  
    end

    %quando o rastro acaba solta
    %Se esta_apertando e nao ha mais rastro passando
    if( holding_buttons('yellow') && ...
        ~getTrailLastNoteDetection('yellow') && ...
        toc(holding_times('yellow')) > tempo_espera)

        holding_buttons('yellow') = false;
        comandoString(4) = '1';
    end

    %Blue
    %Segura botao no rastro
    %Se nao esta apertando e passa o rastro pela primeira vez
    if( ~holding_buttons('blue') && detected_image.getTrailDetection('blue') )
        %segura botao
        holding_buttons('blue') = true;
        holding_times('blue') = tic;
        % fprintf(arduino,'%c', APERTA_SEM_SOLTAR_BLUE); 
        comandoString(8) = '1'; 
    end

    %quando o rastro acaba solta
    %Se esta_apertando e nao ha mais rastro passando
    if( holding_buttons('blue') && ...
        ~getTrailLastNoteDetection('blue') && ...
        toc(holding_times('blue')) > tempo_espera)

        holding_buttons('blue') = false;
        comandoString(3) = '1';
    end

    %Orange
    %Segura botao no rastro
    %Se nao esta apertando e passa o rastro pela primeira vez
    if( ~holding_buttons('orange') && detected_image.getTrailDetection('orange') )
        %segura botao
        holding_buttons('orange') = true;
        holding_times('orange') = tic;
        comandoString(7) = '1';  
    end

    %quando o rastro acaba solta
    %Se esta_apertando e nao ha mais rastro passando
    if( holding_buttons('orange') && ...
        ~getTrailLastNoteDetection('orange') && ...
        toc(holding_times('orange')) > tempo_espera)

        holding_buttons('orange') = false;
        comandoString(2) = '1';
    end

end