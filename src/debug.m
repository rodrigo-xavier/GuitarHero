% Global Flags
global debug_color_screen  = false;
global debug_green         = true;
global debug_red           = false;
global debug_blue          = false;
global debug_orange        = false;
global debug_yellow        = false;
global debug_just_video    = false;


function DEBUG(vid, galileo)

    % if (debug_color_screen)
    %     color_screen(imgO);
    % end
    if (debug_green)
        press_buttons_green(vid, galileo);
    end
end

function color_screen(imgO)
    R = 1;
    G = 2;
    B = 3;

    % Colore de verde os pixels que estão sendo utilizados

    % Simple Green
    imgO(312,230,R) = 0;
    imgO(312,230,G) = 255;
    imgO(312,230,B) = 0;

    % Simple Red
    imgO(311,274,R) = 0;
    imgO(311,274,G) = 255;
    imgO(311,274,B) = 0;

    % Simple Yellow
    imgO(312,311,R) = 0;
    imgO(312,311,G) = 255;
    imgO(312,311,B) = 0;

    % Simple Blue
    imgO(312,354,R) = 0;
    imgO(312,354,G) = 255;
    imgO(312,354,B) = 0;

    % Simple Orange
    imgO(311,395,R) = 0;
    imgO(311,395,G) = 255;
    imgO(311,395,B) = 0;

    % Rastro Vermelho
    imgO(293,275,R) = 0;
    imgO(293,275,G) = 255;
    imgO(293,275,B) = 0;
    imgO(292,275,R) = 0;
    imgO(292,275,G) = 255;
    imgO(292,275,B) = 0;
    imgO(291,275,R) = 0;
    imgO(291,275,G) = 255;
    imgO(291,275,B) = 0;
    imgO(290,276,R) = 0;
    imgO(290,276,G) = 255;
    imgO(290,276,B) = 0;
    imgO(289,276,R) = 0;
    imgO(289,276,G) = 255;
    imgO(289,276,B) = 0;
    imgO(288,276,R) = 0;
    imgO(288,276,G) = 255;
    imgO(288,276,B) = 0;
    imgO(287,276,R) = 0;
    imgO(287,276,G) = 255;
    imgO(287,276,B) = 0;
    imgO(286,276,R) = 0;
    imgO(286,276,G) = 255;
    imgO(286,276,B) = 0;
    imgO(285,277,R) = 0;
    imgO(285,277,G) = 255;
    imgO(285,277,B) = 0;
    imgO(284,277,R) = 0;
    imgO(284,277,G) = 255;
    imgO(284,277,B) = 0;
    imgO(283,277,R) = 0;
    imgO(283,277,G) = 255;
    imgO(283,277,B) = 0;
    imgO(282,277,R) = 0;
    imgO(282,277,G) = 255;
    imgO(282,277,B) = 0;
    imgO(281,278,R) = 0;
    imgO(281,278,G) = 255;
    imgO(281,278,B) = 0;
    
    imagesc(imgO);
end