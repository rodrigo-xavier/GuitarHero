function [green_note_passed, red_note_passed, yellow_note_passed, blue_note_passed, orange_note_passed] = note_passed(imgO)
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

    % TODO: Verificar se os pixels estao corretos
    greenPixel = imgO(312,230,G);
    redPixel = imgO(311,274,R);
    yellowPixelR = imgO(312,311,R);
    yellowPixelG = imgO(312,311,G);
    bluePixelG = imgO(312,354,G);
    bluePixelB = imgO(312,354,B);
    orangePixelR = imgO(311,395,R);
    orangePixelG = imgO(311,395,G);

    % ------------------------------------------------------------------------- %
    % detect green
    if( greenPixel >= green_min && greenPixel <= green_max )
        green_note_passed = false;
    else 
        green_note_passed = true;
    end

    %detect red   
    if( redPixel >= red_min && redPixel <= red_max )
        red_note_passed = false;
    else
        red_note_passed = true;
    end

    %detect yellow
    if(yellowPixelR >= yellowR_min && yellowPixelR <= yellowR_max && ...
       yellowPixelG >= yellowG_min && yellowPixelG <= yellowG_max)
        yellow_note_passed = false;
    else
        yellow_note_passed = true;
    end

    %detect blue
    if(bluePixelG >= blueG_min && bluePixelG <= blueG_max && ...
       bluePixelB >= blueB_min && bluePixelB <= blueB_max)
        blue_note_passed = false;
    else
        blue_note_passed = true;
    end

    %detect orange
    if(orangePixelR >= orangeR_min && orangePixelR <= orangeR_max && ...
       orangePixelG >= orangeG_min && orangePixelG <= orangeG_max)
        orange_note_passed = false;
    else
        orange_note_passed = true;
    end

end