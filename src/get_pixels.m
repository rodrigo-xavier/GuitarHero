function [simple_pixels, pixels_rastro] = get_pixels(imgO)
    
    R = 1;
    G = 2;
    B = 3;

    % Pixels do aperto simples
    greenPixel = imgO(312,230,G);
    redPixel = imgO(311,274,R);
    yellowPixelR = imgO(312,311,R);
    yellowPixelG = imgO(312,311,G);
    bluePixelG = imgO(312,354,G);
    bluePixelB = imgO(312,354,B);
    orangePixelR = imgO(311,395,R);
    orangePixelG = imgO(311,395,G);
    
    keys = {'greenPixel', 'redPixel', 'yellowPixelR', 'yellowPixelG', ...
    'bluePixelG', 'bluePixelB', 'orangePixelR', 'orangePixelG'};
    values = {greenPixel, redPixel, yellowPixelR, yellowPixelG, bluePixelG, ...
              bluePixelB, orangePixelR, orangePixelG};
    simple_pixels = containers.Map(keys, values);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Pixels do rastro
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Verde
    keys = {'greenPxRastro0', 'greenPxRastro1', 'greenPxRastro2', 'greenPxRastro3', ... 
            'greenPxRastro4', 'greenPxRastro5', 'greenPxRastro6', 'greenPxRastro7', ...
            'greenPxRastro8', 'greenPxRastro9', 'greenPxRastro10', 'greenPxRastro11', ...
            'greenPxRastro12'};
    greenPxRastro0 = imgO(293,238,G);
    greenPxRastro1 = imgO(292,238,G);
    greenPxRastro2 = imgO(291,239,G);
    greenPxRastro3 = imgO(290,239,G);
    greenPxRastro4 = imgO(289,239,G);
    greenPxRastro5 = imgO(288,240,G);
    greenPxRastro6 = imgO(287,240,G);
    greenPxRastro7 = imgO(286,240,G);
    greenPxRastro8 = imgO(285,241,G);
    greenPxRastro9 = imgO(284,241,G);
    greenPxRastro10 = imgO(283,241,G);
    greenPxRastro11 = imgO(282,242,G);
    greenPxRastro12 = imgO(281,243,G);
    values = {greenPxRastro0, greenPxRastro1, greenPxRastro2, greenPxRastro3, ...
              greenPxRastro4, greenPxRastro5, greenPxRastro6, greenPxRastro7, ...
              greenPxRastro8, greenPxRastro9, greenPxRastro10, greenPxRastro11, ...
              greenPxRastro12};
    green_pixels_rastro = containers.Map(keys, values);

    % Vermelho
    keys = {'redPxRastro0', 'redPxRastro1', 'redPxRastro2', 'redPxRastro3', ...
            'redPxRastro4', 'redPxRastro5', 'redPxRastro6', 'redPxRastro7', ...
            'redPxRastro8', 'redPxRastro9', 'redPxRastro10', 'redPxRastro11', ...
            'redPxRastro12'};
    redPxRastro0 = imgO(293,275,R);
    redPxRastro1 = imgO(292,275,R);
    redPxRastro2 = imgO(291,275,R);
    redPxRastro3 = imgO(290,276,R);
    redPxRastro4 = imgO(289,276,R);
    redPxRastro5 = imgO(288,276,R);
    redPxRastro6 = imgO(287,276,R);
    redPxRastro7 = imgO(286,276,R);
    redPxRastro8 = imgO(285,277,R);
    redPxRastro9 = imgO(284,277,R);
    redPxRastro10 = imgO(283,277,R);
    redPxRastro11 = imgO(282,277,R);
    redPxRastro12 = imgO(281,278,R);
    values = {redPxRastro0, redPxRastro1, redPxRastro2, redPxRastro3, ...
              redPxRastro4, redPxRastro5, redPxRastro6, redPxRastro7, ...
              redPxRastro8, redPxRastro9, redPxRastro10, redPxRastro11, ...
              redPxRastro12};
    red_pixels_rastro = containers.Map(keys, values);


    % Amarelo
    keys = {'yellowPxRastro0R', 'yellowPxRastro0G', 'yellowPxRastro1R', 'yellowPxRastro1G', ...
            'yellowPxRastro2R', 'yellowPxRastro2G', 'yellowPxRastro3R', 'yellowPxRastro3G', ...
            'yellowPxRastro4R', 'yellowPxRastro4G', 'yellowPxRastro5R', 'yellowPxRastro5G', ...
            'yellowPxRastro6R', 'yellowPxRastro6G', 'yellowPxRastro7R', 'yellowPxRastro7G', ...
            'yellowPxRastro8R', 'yellowPxRastro8G', 'yellowPxRastro9R', 'yellowPxRastro9G', ...
            'yellowPxRastro10R', 'yellowPxRastro10G', 'yellowPxRastro11R', 'yellowPxRastro11G', ...
            'yellowPxRastro12R', 'yellowPxRastro12G'};
    yellowPxRastro0R = imgO(293,312,R);
    yellowPxRastro0G = imgO(293,312,G);
    yellowPxRastro1R = imgO(292,312,R);
    yellowPxRastro1G = imgO(292,312,G);
    yellowPxRastro2R = imgO(291,312,R);
    yellowPxRastro2G = imgO(291,312,G);
    yellowPxRastro3R = imgO(290,312,R);
    yellowPxRastro3G = imgO(290,312,G);
    yellowPxRastro4R = imgO(289,312,R);
    yellowPxRastro4G = imgO(289,312,G);
    yellowPxRastro5R = imgO(288,312,R);
    yellowPxRastro5G = imgO(288,312,G);
    yellowPxRastro6R = imgO(287,312,R);
    yellowPxRastro6G = imgO(287,312,G);
    yellowPxRastro7R = imgO(286,312,R);
    yellowPxRastro7G = imgO(286,312,G);
    yellowPxRastro8R = imgO(285,312,R);
    yellowPxRastro8G = imgO(285,312,G);
    yellowPxRastro9R = imgO(284,312,R);
    yellowPxRastro9G = imgO(284,312,G);
    yellowPxRastro10R = imgO(283,312,R);
    yellowPxRastro10G = imgO(283,312,G);
    yellowPxRastro11R = imgO(282,312,R);
    yellowPxRastro11G = imgO(282,312,G);
    yellowPxRastro12R = imgO(281,312,R);
    yellowPxRastro12G = imgO(281,312,G);
    values = {yellowPxRastro0R, yellowPxRastro0G, yellowPxRastro1R, yellowPxRastro1G, ...
            yellowPxRastro2R, yellowPxRastro2G, yellowPxRastro3R, yellowPxRastro3G, ...
            yellowPxRastro4R, yellowPxRastro4G, yellowPxRastro5R, yellowPxRastro5G, ...
            yellowPxRastro6R, yellowPxRastro6G, yellowPxRastro7R, yellowPxRastro7G, ...
            yellowPxRastro8R, yellowPxRastro8G, yellowPxRastro9R, yellowPxRastro9G, ...
            yellowPxRastro10R, yellowPxRastro10G, yellowPxRastro11R, yellowPxRastro11G, ...
            yellowPxRastro12R, yellowPxRastro12G}; 
    yellow_pixels_rastro = containers.Map(keys, values);


    % Azul
    keys = {'bluePxRastro0B', 'bluePxRastro0G', 'bluePxRastro1B', 'bluePxRastro1G', ...
            'bluePxRastro2B', 'bluePxRastro2G', 'bluePxRastro3B', 'bluePxRastro3G', ...
            'bluePxRastro4B', 'bluePxRastro4G', 'bluePxRastro5B', 'bluePxRastro5G', ...
            'bluePxRastro6B', 'bluePxRastro6G', 'bluePxRastro7B', 'bluePxRastro7G', ...
            'bluePxRastro8B', 'bluePxRastro8G', 'bluePxRastro9B', 'bluePxRastro9G', ...
            'bluePxRastro10B', 'bluePxRastro10G', 'bluePxRastro11B', 'bluePxRastro11G', ...
            'bluePxRastro12B', 'bluePxRastro12G'};
    bluePxRastro0B = imgO(291,349,B);
    bluePxRastro0G = imgO(291,349,G);
    bluePxRastro1B = imgO(290,349,B);
    bluePxRastro1G = imgO(290,349,G);
    bluePxRastro2B = imgO(289,349,B);
    bluePxRastro2G = imgO(289,349,G);
    bluePxRastro3B = imgO(288,349,B);
    bluePxRastro3G = imgO(288,349,G);
    bluePxRastro4B = imgO(287,349,B);
    bluePxRastro4G = imgO(287,349,G);
    bluePxRastro5B = imgO(286,349,B);
    bluePxRastro5G = imgO(286,349,G);
    bluePxRastro6B = imgO(285,348,B);
    bluePxRastro6G = imgO(285,348,G);
    bluePxRastro7B = imgO(284,348,B);
    bluePxRastro7G = imgO(284,348,G);
    bluePxRastro8B = imgO(283,348,B);
    bluePxRastro8G = imgO(283,348,G);
    bluePxRastro9B = imgO(282,348,B);
    bluePxRastro9G = imgO(282,348,G);
    bluePxRastro10B = imgO(281,348,B);
    bluePxRastro10G = imgO(281,348,G);
    bluePxRastro11B = imgO(280,348,B);
    bluePxRastro11G = imgO(280,348,G);
    bluePxRastro12B = imgO(279,248,B);
    bluePxRastro12G = imgO(279,348,G);
    values = {bluePxRastro0B, bluePxRastro0G, bluePxRastro1B, bluePxRastro1G, ...
            bluePxRastro2B, bluePxRastro2G, bluePxRastro3B, bluePxRastro3G, ...
            bluePxRastro4B, bluePxRastro4G, bluePxRastro5B, bluePxRastro5G, ...
            bluePxRastro6B, bluePxRastro6G, bluePxRastro7B, bluePxRastro7G, ...
            bluePxRastro8B, bluePxRastro8G, bluePxRastro9B, bluePxRastro9G, ...
            bluePxRastro10B, bluePxRastro10G, bluePxRastro11B, bluePxRastro11G, ...
            bluePxRastro12B, bluePxRastro12G};
    blue_pixels_rastro = containers.Map(keys, values);


    % Laranja
    keys = {'orangePxRastro0R', 'orangePxRastro0G', 'orangePxRastro1R', 'orangePxRastro1G', ...
            'orangePxRastro2R', 'orangePxRastro2G', 'orangePxRastro3R', 'orangePxRastro3G', ...
            'orangePxRastro4R', 'orangePxRastro4G', 'orangePxRastro5R', 'orangePxRastro5G', ...
            'orangePxRastro6R', 'orangePxRastro6G', 'orangePxRastro7R', 'orangePxRastro7G', ...
            'orangePxRastro8R', 'orangePxRastro8G', 'orangePxRastro9R', 'orangePxRastro9G', ...
            'orangePxRastro10R', 'orangePxRastro10G', 'orangePxRastro11R', 'orangePxRastro11G', ...
            'orangePxRastro12R', 'orangePxRastro12G'}; 
    orangePxRastro0R = imgO(294,387,R);
    orangePxRastro0G = imgO(294,387,G);
    orangePxRastro1R = imgO(293,387,R);
    orangePxRastro1G = imgO(293,387,G);
    orangePxRastro2R = imgO(292,386,R);
    orangePxRastro2G = imgO(292,386,G);
    orangePxRastro3R = imgO(291,386,R);
    orangePxRastro3G = imgO(291,386,G);
    orangePxRastro4R = imgO(290,386,R);
    orangePxRastro4G = imgO(290,386,G);
    orangePxRastro5R = imgO(289,385,R);
    orangePxRastro5G = imgO(289,385,G);
    orangePxRastro6R = imgO(288,385,R);
    orangePxRastro6G = imgO(288,385,G);
    orangePxRastro7R = imgO(287,385,R);
    orangePxRastro7G = imgO(287,385,G);
    orangePxRastro8R = imgO(286,384,R);
    orangePxRastro8G = imgO(286,384,G);
    orangePxRastro9R = imgO(285,384,R);
    orangePxRastro9G = imgO(285,384,G);
    orangePxRastro10R = imgO(284,384,R);
    orangePxRastro10G = imgO(284,384,G);
    orangePxRastro11R = imgO(283,383,R);
    orangePxRastro11G = imgO(283,383,G);
    orangePxRastro12R = imgO(282,382,R);
    orangePxRastro12G = imgO(282,382,G);
    values = {orangePxRastro0R, orangePxRastro0G, orangePxRastro1R, orangePxRastro1G, ...
            orangePxRastro2R, orangePxRastro2G, orangePxRastro3R, orangePxRastro3G, ...
            orangePxRastro4R, orangePxRastro4G, orangePxRastro5R, orangePxRastro5G, ...
            orangePxRastro6R, orangePxRastro6G, orangePxRastro7R, orangePxRastro7G, ... 
            orangePxRastro8R, orangePxRastro8G, orangePxRastro9R, orangePxRastro9G, ...
            orangePxRastro10R, orangePxRastro10G, orangePxRastro11R, orangePxRastro11G, ...
            orangePxRastro12R, orangePxRastro12G}; 
    orange_pixels_rastro = containers.Map(keys, values);

    % Concatena todos os Maps
    pixels_rastro = [green_pixels_rastro; red_pixels_rastro; yellow_pixels_rastro; ...
                     blue_pixels_rastro; orange_pixels_rastro];

end