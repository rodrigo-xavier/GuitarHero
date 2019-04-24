function [note_time, trail_time, flag] = detect_level(vid)
    red_min         = 175;
    red_max         = 255;
    green_min       = 175;
    green_max       = 255;
    yellowR_min     = 175;
    yellowR_max     = 255;
    yellowG_min     = 150;
    yellowG_max     = 255;
    blueG_min       = 125;
    blueG_max       = 255;
    blueB_min       = 175;
    blueB_max       = 255;
    orangeR_min     = 175;
    orangeR_max     = 255;
    orangeG_min     = 95;
    orangeG_max     = 255;
    
    time_t          = 0;
    time_n          = 0;

    R               = 1;
    G               = 2;
    B               = 3;

    while (true)

        imgO = getdata(vid,1,'uint8');

        greenPixel        = imgO(293,238,G);
        redPixel          = imgO(293,275,R);
        yellowPixelR      = imgO(293,312,R);
        yellowPixelG      = imgO(293,312,G);
        bluePixelG        = imgO(293,349,G);
        bluePixelB        = imgO(293,349,B);
        orangePixelR      = imgO(293,387,R);
        orangePixelG      = imgO(293,387,G);

        %detect green
        if(greenPixel >= green_min && greenPixel <= green_max)
            tic;

            while (true)
                imgO = getdata(vid,1,'uint8');
                greenPixel = imgO(312,230,G);

                if(greenPixel >= green_min && greenPixel <= green_max)
                    time_t = toc;
                    tic

                    while (true)
                        imgO = getdata(vid,1,'uint8');
                        greenPixel = imgO(412,185,G);

                        if(greenPixel >= green_min && greenPixel <= green_max)
                            time_n = toc;
                            break;
                        end
                    end
                    break;
                end
            end
            break;

        %detect red    
        elseif(redPixel >= red_min && redPixel <= red_max)
            tic;

            while (true)
                imgO = getdata(vid,1,'uint8');
                redPixel = imgO(311,274,R);

                if(redPixel >= red_min && redPixel <= red_max)
                    time_t = toc;
                    tic

                    while (true)
                        imgO = getdata(vid,1,'uint8');
                        redPixel = imgO(411,250,R);

                        if(redPixel >= red_min && redPixel <= red_max)
                            time_n = toc;
                            break;
                        end
                    end
                    break;
                end
            end
            break;

        %detect yellow
        elseif(yellowPixelR >= yellowR_min && yellowPixelR <= yellowR_max && ...
            yellowPixelG >= yellowG_min && yellowPixelG <= yellowG_max )
            tic;

            while (true)
                imgO = getdata(vid,1,'uint8');
                yellowPixelR = imgO(312,311,R);
                yellowPixelG = imgO(312,311,G);

                if(yellowPixelR >= yellowR_min && yellowPixelR <= yellowR_max && ...
                yellowPixelG >= yellowG_min && yellowPixelG <= yellowG_max )
                    time_t = toc;
                    tic

                    while (true)
                        imgO = getdata(vid,1,'uint8');
                        yellowPixelR = imgO(411,313,R);
                        yellowPixelG = imgO(411,313,G);

                        if(yellowPixelR >= yellowR_min && yellowPixelR <= yellowR_max && ...
                        yellowPixelG >= yellowG_min && yellowPixelG <= yellowG_max )
                            time_n = toc;
                            break;
                        end
                    end
                    break;
                end
            end
            break;

        %detect blue
        elseif(bluePixelG >= blueG_min && bluePixelG <= blueG_max && ...
            bluePixelB >= blueB_min && bluePixelB <= blueB_max )
            tic;

            while (true)
                imgO = getdata(vid,1,'uint8');
                bluePixelG = imgO(312,354,G);
                bluePixelB = imgO(312,354,B);

                if(bluePixelG >= blueG_min && bluePixelG <= blueG_max && ...
                bluePixelB >= blueB_min && bluePixelB <= blueB_max )
                    time_t = toc;
                    tic

                    while (true)
                        imgO = getdata(vid,1,'uint8');
                        bluePixelG = imgO(411,376,G);
                        bluePixelB = imgO(411,376,B);

                        if(bluePixelG >= blueG_min && bluePixelG <= blueG_max && ...
                        bluePixelB >= blueB_min && bluePixelB <= blueB_max )
                            time_n = toc;
                            break;
                        end
                    end
                    break;
                end
            end
            break;

        %detect orange
        elseif(orangePixelR >= orangeR_min && orangePixelR <= orangeR_max && ...
            orangePixelG >= orangeG_min && orangePixelG <= orangeG_max)

            tic;

            while (true)
                imgO = getdata(vid,1,'uint8');
                orangePixelR = imgO(311,395,R);
                orangePixelG = imgO(311,395,G);

                if(orangePixelR >= orangeR_min && orangePixelR <= orangeR_max && ...
                    orangePixelG >= orangeG_min && orangePixelG <= orangeG_max )
                    time_t = toc;
                    tic

                    while (true)
                        imgO = getdata(vid,1,'uint8');
                        orangePixelR = imgO(411,440,R);
                        orangePixelG = imgO(411,440,G);

                        if(orangePixelR >= orangeR_min && orangePixelR <= orangeR_max && ...
                        orangePixelG >= orangeG_min && orangePixelG <= orangeG_max )
                            time_n = toc;
                            break;
                        end
                    end
                    break;
                end
            end
            break;
        end
    end
    trail_time = time_t + time_n;
    note_time = time_n;
    flag = true;
end