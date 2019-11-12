function [holding_buttons, holding_times, comandoString] = simple_play(detected_image, holding_buttons, green_time, red_time, yellow_time, blue_time, orange_time)

    %detect green
    if( detected_image.getSimpleDetection('green') &&  ...
        ~holding_buttons('green') && ...
        toc(green_time) > tempo_espera )
        
        comandoString(16) = '1';
        green_time = tic;
    end

    %detect red   
    if( detected_image.getSimpleDetection('red')  && ...
        ~holding_buttons('red') ...
        && toc(red_time) > tempo_espera )
        
        comandoString(15) = '1';
        red_time = tic;
    end

    %detect yellow
    if(detected_image.getSimpleDetection('yellow')  && ...
       toc(yellow_time) > tempo_espera &&  ~holding_buttons('yellow'))
    
        comandoString(14) = '1';
        yellow_time = tic;
    end

    %detect blue
    if(detected_image.getSimpleDetection('blue')  && ...
       toc(blue_time) > tempo_espera &&  ~holding_buttons('blue'))
    
        comandoString(13) = '1';
        blue_time = tic;
    end

    %detect orange
    if(detected_image.getSimpleDetection('orange')  && ...
       toc(orange_time) > tempo_espera &&  ~holding_buttons('orange'))
    
        comandoString(12) = '1';
        orange_time = tic;
    end

end
