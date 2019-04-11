function [note_time, trail_time] = detect_level(vid) % Colocar variável que diz se é rastro ou nota

    average_trail_time = 0;
    average_note_time = 0;
    time_t = 0;
    time_n = 0;

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

    R = 1;
    G = 2;
    B = 3;

    counter = 5;

    % TODO consertar valor dos pixels (Downs principalmente)
    while(counter > 0)
        imgO = getdata(vid,1,'uint8');

        trail_greenPixel = imgO(293,238,G);
        trail_redPixel = imgO(293,275,R);
        trail_yellowPixelR = imgO(293,312,R);
        trail_yellowPixelG = imgO(293,312,G);
        trail_bluePixelG = imgO(293,349,G);
        trail_bluePixelB = imgO(293,349,B);
        trail_orangePixelR = imgO(293,387,R);
        trail_orangePixelG = imgO(293,387,G);

        %detect green
        if(trail_greenPixel >= green_min && trail_greenPixel <= green_max)
            tic;
            fprintf("verde")

            while (true)
                
                imgO = getdata(vid,1,'uint8');
                note_greenPixel = imgO(312,230,G);

                if(note_greenPixel >= green_min && note_greenPixel <= green_max)
                    time_t = toc;
                    tic

                    while (true)
                        imgO = getdata(vid,1,'uint8');
                        down_greenPixel = imgO(412,185,G);
    
                        if(down_greenPixel >= green_min && down_greenPixel <= green_max)
                            time_n = toc;
                            fprintf("%f", time_n);
                            fprintf("%f", time_t);
                            fprintf("\n")
                            counter = counter - 1;
                            break
                        end
                    end
                    break
                end
            end

        %detect red    
        elseif(trail_redPixel >= red_min && trail_redPixel <= red_max)
            tic;
            fprintf("vermelho")

            while (true)
                
                imgO = getdata(vid,1,'uint8');
                note_redPixel = imgO(311,274,R);

                if(note_redPixel >= red_min && note_redPixel <= red_max)
                    time_t = toc;
                    tic

                    while (true)
                        imgO = getdata(vid,1,'uint8');
                        down_redPixel = imgO(411,250,R);

                        if(down_redPixel >= red_min && down_redPixel <= red_max)
                            time_n = toc;
                            fprintf("%f", time_n);
                            fprintf("%f", time_t);
                            fprintf("\n")
                            counter = counter - 1;
                            break
                        end
                    end
                    break
                end
            end

        %detect yellow
        elseif(trail_yellowPixelR >= yellowR_min && trail_yellowPixelR <= yellowR_max && ...
            trail_yellowPixelG >= yellowG_min && trail_yellowPixelG <= yellowG_max )
            fprintf("amarelo")
            tic;

            while (true)
                
                imgO = getdata(vid,1,'uint8');
                note_yellowPixelR = imgO(312,311,R);
                note_yellowPixelG = imgO(312,311,G);

                if(note_yellowPixelR >= yellowR_min && note_yellowPixelR <= yellowR_max && ...
                note_yellowPixelG >= yellowG_min && note_yellowPixelG <= yellowG_max )
                    time_t = toc;
                    tic

                    while (true)
                        imgO = getdata(vid,1,'uint8');
                        down_yellowPixelR = imgO(411,313,R);
                        down_yellowPixelG = imgO(411,313,G);

                        if(down_yellowPixelR >= yellowR_min && down_yellowPixelR <= yellowR_max && ...
                        down_yellowPixelG >= yellowG_min && down_yellowPixelG <= yellowG_max )
                            time_n = toc;
                            fprintf("%f", time_n);
                            fprintf("%f", time_t);
                            fprintf("\n")
                            counter = counter - 1;
                            break
                        end
                    end
                    break
                end
            end

        %detect blue
        elseif(trail_bluePixelG >= blueG_min && trail_bluePixelG <= blueG_max && ...
            trail_bluePixelB >= blueB_min && trail_bluePixelB <= blueB_max )
            fprintf("azul")
            tic;

            while (true)
                
                imgO = getdata(vid,1,'uint8');
                note_bluePixelG = imgO(312,354,G);
                note_bluePixelB = imgO(312,354,B);

                if(note_bluePixelG >= blueG_min && note_bluePixelG <= blueG_max && ...
                note_bluePixelB >= blueB_min && note_bluePixelB <= blueB_max )
                    time_t = toc;
                    tic

                    while (true)
                        imgO = getdata(vid,1,'uint8');
                        down_bluePixelG = imgO(411,376,G);
                        down_bluePixelB = imgO(411,376,B);

                        if(down_bluePixelG >= blueG_min && down_bluePixelG <= blueG_max && ...
                        down_bluePixelB >= blueB_min && down_bluePixelB <= blueB_max )
                            time_n = toc;
                            fprintf("%f", time_n);
                            fprintf("%f", time_t);
                            fprintf("\n")
                            counter = counter - 1;
                            break
                        end
                    end
                    break
                end
            end

        %detect orange
        elseif(trail_orangePixelR >= orangeR_min && trail_orangePixelR <= orangeR_max && ...
            trail_orangePixelG >= orangeG_min && trail_orangePixelG <= orangeG_max )

            tic;
            fprintf("laranja")

            while (true)
                
                imgO = getdata(vid,1,'uint8');
                note_orangePixelR = imgO(311,395,R);
                note_orangePixelG = imgO(311,395,G);

                if(note_orangePixelR >= orangeR_min && note_orangePixelR <= orangeR_max && ...
                    note_orangePixelG >= orangeG_min && note_orangePixelG <= orangeG_max )
                    time_t = toc;
                    tic

                    while (true)
                        imgO = getdata(vid,1,'uint8');
                        down_orangePixelR = imgO(411,440,R);
                        down_orangePixelG = imgO(411,440,G);

                        if(down_orangePixelR >= orangeR_min && down_orangePixelR <= orangeR_max && ...
                        down_orangePixelG >= orangeG_min && down_orangePixelG <= orangeG_max )
                            time_n = toc;
                            fprintf("%f", time_n);
                            fprintf("%f", time_t);
                            fprintf("\n")
                            counter = counter - 1;
                            break
                        end
                    end
                    break
                end
            end
        end
    end
    trail_time = time_t + time_n;
    note_time = time_n;
end

function average_time = average(previous_time, posterior_time)
    average_time = (previous_time + posterior_time)/2;
end