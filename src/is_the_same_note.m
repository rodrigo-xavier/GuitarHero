function [same_note] = is_the_same_note(imgO, same_note)
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

    green = false;
    red = false;
    yellow = false;
    blue = false;
    orange = false;

    % ------------------------------------------------------------------------- %

    %detect green
    if( (greenPixel >= green_min && greenPixel <= green_max) && ~same_note('green'))
        green = true;
    end

    if( ~(greenPixel >= green_min && greenPixel <= green_max) && same_note('green'))
        green = false;
    end

    %detect red   
    if( redPixel >= red_min && redPixel <= red_max && ~same_note('red'))
        red = true;
    end

    if( ~(redPixel >= red_min && redPixel <= red_max) && same_note('red'))
        red = false;
    end

    %detect yellow
    if( yellowPixelR >= yellowR_min && yellowPixelR <= yellowR_max && ...
        yellowPixelG >= yellowG_min && yellowPixelG <= yellowG_max && ... 
        ~same_note('yellow'))
        yellow = true;
    end

    if( ~(yellowPixelR >= yellowR_min && yellowPixelR <= yellowR_max && ...
        yellowPixelG >= yellowG_min && yellowPixelG <= yellowG_max) && ...
        same_note('yellow'))
        yellow = false;
    end

    %detect blue
    if( (bluePixelG >= blueG_min && bluePixelG <= blueG_max && ...
        bluePixelB >= blueB_min && bluePixelB <= blueB_max) && ...
        ~same_note('blue'))
        blue = true;
    end

    if( ~(bluePixelG >= blueG_min && bluePixelG <= blueG_max && ...
        bluePixelB >= blueB_min && bluePixelB <= blueB_max) && ...
        same_note('blue'))
        blue = false;
    end

    %detect orange
    if( (orangePixelR >= orangeR_min && orangePixelR <= orangeR_max && ...
        orangePixelG >= orangeG_min && orangePixelG <= orangeG_max) && ...
        ~same_note('orange'))
        orange = true;
    end

    if( ~(orangePixelR >= orangeR_min && orangePixelR <= orangeR_max && ...
        orangePixelG >= orangeG_min && orangePixelG <= orangeG_max) && ...
        same_note('orange'))
        orange = false;
    end

    %mapeia o resultado
    keys = {'green', 'red', 'yellow', 'blue', 'orange'};
    values = [green red yellow blue orange];
    same_note = containers.Map(keys, values);

end