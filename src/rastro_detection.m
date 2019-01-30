function holding_button = rastro_detection(galileo, imgO, holding_button)

    % ------------------------------------------------------------------------- %
    % Configuracao das variaveis (Eles também existem na funcao press_buttons)
    % acoes
    APERTA_E_SOLTA = char(100);
    APERTA_SEM_SOLTAR = char(101);
    SOLTA = char(102);
    
    % cores
    R = 1;
    G = 2;
    B = 3;

    % cores
    % salvar um arquivo em disco com as variaveis
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

    %Segura botao no rastro
    %Se nao esta apertando e passa o rastro pela primeira vez
    if  ~(holding_button) && ...
        ((imgO(293,275,R) >= red_min && imgO(293,275,R) <= red_max) && ...
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
        (imgO(281,278,R) >= red_min && imgO(281,278,R) <= red_max)) 

        %segura botao
        holding_button = true;

        %tempo
        %tempo_apertando = 0;
        %tic;

        fprintf(galileo,'%c', APERTA_SEM_SOLTAR);  
    end

    %quando o rastro acaba solta
    %Se esta_apertando e nao ha mais rastro passando
    if  ( (holding_button) && ...
        ~((imgO(293,275,R) >= red_min && imgO(293,275,R) <= red_max) && ...
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
        (imgO(281,278,R) >= red_min && imgO(281,278,R) <= red_max)) )

        holding_button = false;

        %tempo
        %tempo_apertando = toc;

        fprintf(galileo,'%c', SOLTA);  

    end