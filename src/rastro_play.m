function [holding_buttons, holding_times, comandoString] = rastro_play(imgO, holding_buttons, holding_times, comandoString, tempo_espera)
    % cores
    R = 1;
    G = 2;
    B = 3;

    % cores
    % TODO: salvar um arquivo em disco com as variaveis
    % para mudar para apenas load('cores.mat')
    red_min = 175;
    red_max = 255;
    green_min = 175;
    green_max = 255;
    yellowR_min = 175;
    yellowR_max = 255;
    yellowG_min = 150;
    yellowG_max = 255;
    blueG_min = 125;
    blueG_max = 255;
    blueB_min = 175;
    blueB_max = 255;
    orangeR_min = 175;
    orangeR_max = 255;
    orangeG_min = 95;
    orangeG_max = 255;

    % ------------------------------------------------------------------------- %

    trail_detected = detect_trail(imgO);
    same_note = is_the_same_note;

    %Green
    %Segura botao no rastro
    %Se nao esta apertando e passa o rastro pela primeira vez
    if( ~holding_buttons('green') && trail_detected('green') && ~same_note('green') )

        %segura botao
        holding_buttons('green') = true;
        % holding_times('green') = tic;
        % fprintf(galileo,'%c', APERTA_SEM_SOLTAR_GREEN); 
        comandoString(11) = '1'; 
    end

    %quando o rastro acaba solta
    %Se esta_apertando e nao ha mais rastro passando
    if( holding_buttons('green') && ...
        ~(imgO(312,230,G) >= green_min && imgO(312,230,G) <= green_max) && ...
        ~same_note('green'))

        holding_buttons('green') = false;
        % fprintf(galileo,'%c', SOLTA_GREEN);  
        comandoString(6) = '1';
    end


    % Red
    %Segura botao no rastro
    %Se nao esta apertando e passa o rastro pela primeira vez
    if( ~holding_buttons('red') && trail_detected('red') && ~same_note('red') )

        %segura botao
        holding_buttons('red') = true;
        %holding_times('red') = tic;
        % fprintf(galileo,'%c', APERTA_SEM_SOLTAR_RED); 
        comandoString(10) = '1'; 

    end

    %quando o rastro acaba solta
    %Se esta_apertando e nao ha mais rastro passando
    if( holding_buttons('red') && ...
        ~(imgO(311,274,R) >= red_min && imgO(311,274,R) <= red_max) && ...
        ~same_note('red'))

        holding_buttons('red') = false;
        % fprintf(galileo,'%c', SOLTA_RED);  
        comandoString(5) = '1';

    end

    %Yellow
    %Segura botao no rastro
    %Se nao esta apertando e passa o rastro pela primeira vez
    if( ~holding_buttons('yellow') && trail_detected('yellow') && ~same_note('yellow') )
        
        %segura botao
        holding_buttons('yellow') = true;
        %holding_times('yellow') = tic;
        % fprintf(galileo,'%c', APERTA_SEM_SOLTAR_YELLOW);
        comandoString(9) = '1';  

    end

    %quando o rastro acaba solta
    %Se esta_apertando e nao ha mais rastro passando
    if( holding_buttons('yellow') && ...
        ~(imgO(312,311,R) >= yellowR_min && imgO(312,311,R) <= yellowR_max && ...
          imgO(312,311,G) >= yellowG_min && imgO(312,311,G) <= yellowG_max) && ...
        ~same_note('yellow'))

        holding_buttons('yellow') = false;
        % fprintf(galileo,'%c', SOLTA_YELLOW);  
        comandoString(4) = '1';

    end


    %Blue
    %Segura botao no rastro
    %Se nao esta apertando e passa o rastro pela primeira vez
    if( ~holding_buttons('blue') && trail_detected('blue') && ~same_note('blue'))
        
        %segura botao
        holding_buttons('blue') = true;
        % holding_times('blue') = tic;
        % fprintf(galileo,'%c', APERTA_SEM_SOLTAR_BLUE); 
        comandoString(8) = '1'; 

    end

    %quando o rastro acaba solta
    %Se esta_apertando e nao ha mais rastro passando
    if( holding_buttons('blue') && ...
        ~(imgO(312,311,B) >= blueB_min && imgO(312,311,B) <= blueB_max && ...
          imgO(312,311,G) >= blueG_min && imgO(312,311,G) <= blueG_max) && ...
        ~same_note('blue'))

        holding_buttons('blue') = false;
        % fprintf(galileo,'%c', SOLTA_BLUE);  
        comandoString(3) = '1';
    end


    %Orange
    %Segura botao no rastro
    %Se nao esta apertando e passa o rastro pela primeira vez
    if( ~holding_buttons('orange') && trail_detected('orange') && ~same_note('orange'))
        
        %segura botao
        holding_buttons('orange') = true;
        %holding_times('orange') = tic;
        % fprintf(galileo,'%c', APERTA_SEM_SOLTAR_ORANGE);
        comandoString(7) = '1';  

    end

    %quando o rastro acaba solta
    %Se esta_apertando e nao ha mais rastro passando
    if( holding_buttons('orange') && ...
        ~(imgO(312,311,R) >= orangeR_min && imgO(312,311,R) <= orangeR_max && ...
          imgO(312,311,G) >= orangeG_min && imgO(312,311,G) <= orangeG_max) && ...
        ~same_note('orange'))

        holding_buttons('orange') = false;
        % fprintf(galileo,'%c', SOLTA_ORANGE);  
        comandoString(2) = '1';

    end

end