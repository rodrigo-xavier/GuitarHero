function [holding_buttons, holding_times] = rastro_detection(galileo, imgO, holding_buttons, holding_times)

    % ------------------------------------------------------------------------- %
    % Configuracao das variaveis (Eles também existem na funcao press_buttons)
    % acoes
    APERTA_SEM_SOLTAR_RED = char(101);
    SOLTA_RED = char(102);
    
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
    green_max = 175;
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

    % Red
    %Segura botao no rastro
    %Se nao esta apertando e passa o rastro pela primeira vez
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
        toc(holding_times('red')) > 0.35)

        holding_buttons('red') = false;

        fprintf(galileo,'%c', SOLTA_RED);  

    end


    %Red

    %Faca algo quando tiver que apertar
    % ...

    %Faca algo quando tiver que soltar
    % ...


    %Yellow

    %Faca algo quando tiver que apertar
    % ...

    %Faca algo quando tiver que soltar
    % ...


    %Blue

    %Faca algo quando tiver que apertar
    % ...

    %Faca algo quando tiver que soltar
    % ...


    %Orange

    %Faca algo quando tiver que apertar
    % ...

    %Faca algo quando tiver que soltar
    % ...

end