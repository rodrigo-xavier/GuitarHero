function time = detect_level(vid, galileo)

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

        greenPixel1 = imgO(312,230,G);
        redPixel1 = imgO(311,274,R);
        yellowPixelR1 = imgO(312,311,R);
        yellowPixelG1 = imgO(312,311,G);
        bluePixelG1 = imgO(312,354,G);
        bluePixelB1 = imgO(312,354,B);
        orangePixelR1 = imgO(311,395,R);
        orangePixelG1 = imgO(311,395,G);
        
        %detect green
        if(greenPixel1 >= green_min && greenPixel1 <= green_max)
            start = tic;

            while (t == 0)
                greenPixel2 = imgO(312,130,G);

                imgO = getdata(vid,1,'uint8');

                if(greenPixel2 >= green_min && greenPixel2 <= green_max)
                    tic_toc = toc(start);
                    t = time_calculator(tic_toc);
                end

                imagesc(imgO);
            end

        %detect red    
        elseif(redPixel1 >= red_min && redPixel1 <= red_max)
            start = tic;

            while (t == 0)
                redPixel2 = imgO(311,174,R);

                imgO = getdata(vid,1,'uint8');

                if(redPixel2 >= red_min && redPixel2 <= red_max)
                    tic_toc = toc(start);
                    t = time_calculator(tic_toc);
                end

                imagesc(imgO);
            end

        %detect yellow
        elseif(yellowPixelR1 >= yellowR_min && yellowPixelR1 <= yellowR_max && ...
        yellowPixelG1 >= yellowG_min && yellowPixelG1 <= yellowG_max )
            start = tic;

            while (t == 0)
                yellowPixelR2 = imgO(312,211,R);
                yellowPixelG2 = imgO(312,211,G);

                imgO = getdata(vid,1,'uint8');

                if(yellowPixelR2 >= yellowR_min && yellowPixelR2 <= yellowR_max && ...
                yellowPixelG2 >= yellowG_min && yellowPixelG2 <= yellowG_max )
                    t = time_calculator(tic_toc);
                end

                imagesc(imgO);
            end

        %detect blue
        elseif(bluePixelG1 >= blueG_min && bluePixelG1 <= blueG_max && ...
            bluePixelB1 >= blueB_min && bluePixelB1 <= blueB_max )
            start = tic;

            while (t == 0)
                bluePixelG2 = imgO(312,254,G);
                bluePixelB2 = imgO(312,254,B);

                imgO = getdata(vid,1,'uint8');

                if(bluePixelG2 >= blueG_min && bluePixelG2 <= blueG_max && ...
                bluePixelB2 >= blueB_min && bluePixelB2 <= blueB_max )
                    tic_toc = toc(start);
                    t = time_calculator(tic_toc);
                end

                imagesc(imgO);
            end

        %detect orange
        else(orangePixelR1 >= orangeR_min && orangePixelR1 <= orangeR_max && ...
            orangePixelG1 >= orangeG_min && orangePixelG1 <= orangeG_max )
            start = tic;

            while (t == 0)
                orangePixelR2 = imgO(311,295,R);
                orangePixelG2 = imgO(311,295,G);

                imgO = getdata(vid,1,'uint8');

            if(orangePixelR2 >= orangeR_min && orangePixelR2 <= orangeR_max && ...
                orangePixelG2 >= orangeG_min && orangePixelG2 <= orangeG_max )
                    tic_toc = toc(start);
                    t = time_calculator(tic_toc);
                end

                imagesc(imgO);
            end
        imagesc(imgO);
    end

    time = t;
end

function T2 = time_calculator(T1)
    D1 = 300;
    D2 = 250;

    V = T1/D1;
    T2 = D2/V;
end