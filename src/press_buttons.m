function press_buttons(vid, galileo)
    % escolhe o nivel que sera jogado

    % opcoes de niveis disponiveis
    niveis_easy = ["easy_slowest", "easy_slower", "easy_slow", "easy_full_speed"];
    niveis_medium = ["medium_slowest", "medium_slower", "medium_slow", "medium_full_speed"];
    niveis_hard = ["hard_slowest", "hard_slower", "hard_slow", "hard_full_speed"];
    niveis_expert = ["expert_slowest", "expert_slower", "expert_slow", "expert_full_speed"];

    % nivel escolhido
    nivel = niveis_easy(1); % easy_slowest

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

    % acoes
    APERTA_E_SOLTA = char(100);
    APERTA_SEM_SOLTAR = char(101);
    SOLTA = char(102);

    % tempo
    [tempo_aperta, tempo_espera] = chose_times(nivel);

    while true
        % get image from camera
        imgO = getdata(vid,1,'uint8');

        R = 1;
        G = 2;
        B = 3;

        % Verificar se os pixels estão corretos
        greenPixel = imgO(312,230,G);
        redPixel = imgO(311,274,R);
        yellowPixelR = imgO(312,311,R);
        yellowPixelG = imgO(312,311,G);
        bluePixelG = imgO(312,354,G);
        bluePixelB = imgO(312,354,B);
        orangePixelR = imgO(311,395,R);
        orangePixelG = imgO(311,395,G);
        
        %detect green
        if(greenPixel >= green_min && greenPixel <= green_max)
            % do something
        end

        %detect red    
        if(redPixel >= red_min && redPixel <= red_max)
            fprintf(galileo,'%c', APERTA_E_SOLTA);
            % pause tempo_espera
        end

        %detect yellow
        if(yellowPixelR >= yellowR_min && yellowPixelR <= yellowR_max && ...
        yellowPixelG >= yellowG_min && yellowPixelG <= yellowG_min )
        % do something
        end

        %detect blue
        if(bluePixelG >= blueG_min && bluePixelG <= blueG_max && ...
            bluePixelB >= blueB_min && bluePixelB <= blueB_min )
            % do something
        end

        %detect orange
        if(orangePixelR >= orangeR_min && orangePixelR <= orangeR_max && ...
            orangePixelG >= orangeG_min && orangePixelG <= orangeG_min )
            % do something
        end
        
        imagesc(imgO);
    end
end

function aperta_e_segura(tempo)
    % Função que envia ao arduino o comando para manter
    % o botão apertado por `tempo` milisegundos.

    fprintf(galileo,'%c', char(254)); %start
    tempo_string = int2str(tempo);
    for n=1:strlength(tempo_string)
        fprintf(galileo,'%c', char(tempo_string(n))); % envia um digito por vez
    end
    fprintf(galileo,'%c', char(255)); %end
end