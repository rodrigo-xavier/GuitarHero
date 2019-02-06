function time = detect_level(vid)

    t = 0;

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

    while (t == 0)
        imgO = getdata(vid,1,'uint8');

        R = 1;
        G = 2;
        B = 3;

        greenPixelUp1 = imgO(260,238,G);
        % greenPixelUp2 = imgO(260,237,G);
        % greenPixelUp3 = imgO(261,238,G);
        redPixelUp1 = imgO(286,237,R);
        yellowPixelRUp1 = imgO(313,237,R);
        yellowPixelGUp1 = imgO(313,237,G);
        bluePixelGUp1 = imgO(343,237,G);
        bluePixelBUp1 = imgO(343,237,B);
        orangePixelRUp1 = imgO(367,238,R);
        orangePixelGUp1 = imgO(367,238,G);

        [greenPixelUp, dists] = findNearestNeighbors(imgO, greenPixelUp1, 8);
        [redPixelUp, dists] = findNearestNeighbors(imgO, redPixelUp1, 8);
        
        %detect green
        if(greenPixelUp1 >= green_min && greenPixelUp1 <= green_max)
            tic;

            while (t == 0)
                imgO = getdata(vid,1,'uint8');
                greenPixelDown1 = imgO(241,287,G);

                if(greenPixelDown1 >= green_min && greenPixelDown1 <= green_max)
                    t = time_calculator(toc);
                end
            end

        %detect red    
        elseif(redPixelUp1 >= red_min && redPixelUp1 <= red_max)
            tic;

            while (t == 0)
                imgO = getdata(vid,1,'uint8');
                redPixelDown1 = imgO(273,287,R);

                if(redPixelDown1 >= red_min && redPixelDown1 <= red_max)
                    t = time_calculator(toc);
                end
            end

        %detect yellow
        elseif(yellowPixelRUp1 >= yellowR_min && yellowPixelRUp1 <= yellowR_max && ...
        yellowPixelGUp1 >= yellowG_min && yellowPixelGUp1 <= yellowG_max )
            tic;

            while (t == 0)
                imgO = getdata(vid,1,'uint8');
                yellowPixelRDown1 = imgO(311,288,R);
                yellowPixelGDown1 = imgO(311,288,G);

                if(yellowPixelRDown1 >= yellowR_min && yellowPixelRDown1 <= yellowR_max && ...
                yellowPixelGDown1 >= yellowG_min && yellowPixelGDown1 <= yellowG_max )
                    t = time_calculator(toc);
                end
            end

        %detect blue
        elseif(bluePixelGUp1 >= blueG_min && bluePixelGUp1 <= blueG_max && ...
            bluePixelBUp1 >= blueB_min && bluePixelBUp1 <= blueB_max )
            tic;

            while (t == 0)
                imgO = getdata(vid,1,'uint8');
                bluePixelGDown1 = imgO(354,287,G);
                bluePixelBDown1 = imgO(354,287,B);

                if(bluePixelGDown1 >= blueG_min && bluePixelGDown1 <= blueG_max && ...
                bluePixelBDown1 >= blueB_min && bluePixelBDown1 <= blueB_max )
                    t = time_calculator(toc);
                end
            end

        %detect orange
        else (orangePixelRUp1 >= orangeR_min && orangePixelRUp1 <= orangeR_max && ...
            orangePixelGUp1 >= orangeG_min && orangePixelGUp1 <= orangeG_max )
            tic;

            while (t == 0)
                imgO = getdata(vid,1,'uint8');
                orangePixelRDown1 = imgO(388,286,R);
                orangePixelGDown1 = imgO(388,286,G);

            if(orangePixelRDown1 >= orangeR_min && orangePixelRDown1 <= orangeR_max && ...
                orangePixelGDown1 >= orangeG_min && orangePixelGDown1 <= orangeG_max )
                    t = time_calculator(toc);
                end
            end
        end
    end

    time = t;
end

function T2 = time_calculator(T1)
    D1 = 50;
    D2 = 174;

    V = T1/D1;
    T2 = D2/V;
end