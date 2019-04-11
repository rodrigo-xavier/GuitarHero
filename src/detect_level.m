function [trail_time, trail_time] = detect_level(vid) % Colocar variável que diz se é rastro ou nota

    average_trail_time = 0;
    average_trail_time = 0;

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

    counter = 5;

    % TODO consertar valor dos pixels (Downs principalmente)
    while (counter > 0)
        imgO = getdata(vid,1,'uint8');

        R = 1;
        G = 2;
        B = 3;

        trail_greenPixel = imgO(260,238,G);
        trail_redPixel = imgO(286,237,R);
        trail_yellowPixelR = imgO(313,237,R);
        trail_yellowPixelG = imgO(313,237,G);
        trail_bluePixelG = imgO(343,237,G);
        trail_bluePixelB = imgO(343,237,B);
        trail_orangePixelR = imgO(367,238,R);
        trail_orangePixelG = imgO(367,238,G);

        note_greenPixel = imgO(260,238,G);
        note_redPixel = imgO(286,237,R);
        note_yellowPixelR = imgO(313,237,R);
        note_yellowPixelG = imgO(313,237,G);
        note_bluePixelG = imgO(343,237,G);
        note_bluePixelB = imgO(343,237,B);
        note_orangePixelR = imgO(367,238,R);
        note_orangePixelG = imgO(367,238,G);

        %detect green
        if(trail_greenPixel >= green_min && trail_greenPixel <= green_max)
            tic;

            while (true)
                imgO = getdata(vid,1,'uint8');
                note_greenPixel = imgO(241,287,G);

                if(note_greenPixel >= green_min && note_greenPixel <= green_max)
                    time_t = toc;
                    tic

                    while (true)
                        imgO = getdata(vid,1,'uint8');
                        down_greenPixel = imgO(241,287,G);
    
                        if(down_greenPixel >= green_min && down_greenPixel <= green_max)
                            time_n = toc;
                            counter = counter - 1;
                            break
                        end
                    end
                    break
                end
            end

        %detect red    
        elseif(trail_redPixelUp >= red_min && trail_redPixelUp <= red_max)
            tic;

            while (true)
                imgO = getdata(vid,1,'uint8');
                note_redPixel = imgO(273,287,R);

                if(note_redPixel >= red_min && note_redPixel <= red_max)
                    time_t = toc;
                    tic

                    while (true)
                        imgO = getdata(vid,1,'uint8');
                        down_redPixel = imgO(241,287,G);

                        if(down_redPixel >= green_min && down_redPixel <= green_max)
                            time_n = toc;
                            counter = counter - 1;
                            break
                        end
                    end
                    break
                end
            end

        %detect yellow
        elseif(trail_yellowPixelRUp >= yellowR_min && trail_yellowPixelRUp <= yellowR_max && ...
            trail_yellowPixelGUp >= yellowG_min && trail_yellowPixelGUp <= yellowG_max )
            
            tic;

            while (true)
                imgO = getdata(vid,1,'uint8');
                note_yellowPixelR = imgO(311,288,R);
                note_yellowPixelG = imgO(311,288,G);

                if(note_yellowPixelR >= yellowR_min && note_yellowPixelR <= yellowR_max && ...
                note_yellowPixelG >= yellowG_min && note_yellowPixelG <= yellowG_max )
                    time_t = toc;
                    tic

                    while (true)
                        imgO = getdata(vid,1,'uint8');
                        down_yellowPixelR = imgO(241,287,G);
                        down_yellowPixelG = imgO(241,287,G);

                        if(down_yellowPixelR >= yellowR_min && down_yellowPixelR <= yellowR_max && ...
                        down_yellowPixelG >= yellowG_min && down_yellowPixelG <= yellowG_max )
                            time_n = toc;
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

            tic;

            while (true)
                imgO = getdata(vid,1,'uint8');
                note_bluePixelG = imgO(354,287,G);
                note_bluePixelB = imgO(354,287,B);

                if(note_bluePixelG >= blueG_min && note_bluePixelG <= blueG_max && ...
                note_bluePixelB >= blueB_min && note_bluePixelB <= blueB_max )
                    time_t = toc;
                    tic

                    while (true)
                        imgO = getdata(vid,1,'uint8');
                        down_bluePixelR = imgO(241,287,G);
                        down_bluePixelG = imgO(241,287,G);

                        if(down_bluePixelR >= blueR_min && down_bluePixelR <= blueR_max && ...
                        down_bluePixelG >= blueG_min && down_bluePixelG <= blueG_max )
                            time_n = toc;
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

            while (true)
                imgO = getdata(vid,1,'uint8');
                note_orangePixelR = imgO(388,286,R);
                note_orangePixelG = imgO(388,286,G);

                if(note_orangePixelR >= orangeR_min && note_orangePixelR <= orangeR_max && ...
                    note_orangePixelG >= orangeG_min && note_orangePixelG <= orangeG_max )
                    time_t = toc;
                    tic

                    while (true)
                        imgO = getdata(vid,1,'uint8');
                        down_orangePixelR = imgO(241,287,G);
                        down_orangePixelG = imgO(241,287,G);

                        if(down_orangePixelR >= orangeR_min && down_orangePixelR <= orangeR_max && ...
                        down_orangePixelG >= orangeG_min && down_orangePixelG <= orangeG_max )
                            time_n = toc;
                            counter = counter - 1;
                            break
                        end
                    end
                    break
                end
            end
        end
            average_trail_time = average(average_trail_time, time);
            average_trail_time = average(average_trail_time, time);
        end
    end
    % fprintf("average: %f", average_trail_time)
    trail_time = average_trail_time;
    trail_time = average_trail_time;
end

function average_time = average(previous_time, posterior_time)
    average_time = (previous_time + posterior_time)/2;
end