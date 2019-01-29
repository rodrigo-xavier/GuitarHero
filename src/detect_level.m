function time = detect_level(vid, galileo)
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

    while true
        imgO = getdata(vid,1,'uint8');

        R = 1;
        G = 2;
        B = 3;

        greenPixel = imgO(312,230,G);
        redPixel = imgO(311,274,R);
        yellowPixelR = imgO(312,311,R);
        yellowPixelG = imgO(312,311,G);
        bluePixelG = imgO(312,354,G);
        bluePixelB = imgO(312,354,B);
        orangePixelR = imgO(311,395,R);
        orangePixelG = imgO(311,395,G);
        
        %detect green
        if(greenPixel >= green_min && greenPixel <= green_max)
            start = tic;
            while(toc(start) < tempo_espera)
                imgO = getdata(vid,1,'uint8');
                imagesc(imgO);
            end
            time = time_calculator(tic_toc)
        end

        %detect red    
        if(redPixel >= red_min && redPixel <= red_max)
            start = tic;
            while(toc(start) < tempo_espera)
                imgO = getdata(vid,1,'uint8');
                imagesc(imgO);
            end
            time = time_calculator(tic_toc)
        end

        %detect yellow
        if(yellowPixelR >= yellowR_min && yellowPixelR <= yellowR_max && ...
        yellowPixelG >= yellowG_min && yellowPixelG <= yellowG_max )
            start = tic;
            while(toc(start) < tempo_espera)
                imgO = getdata(vid,1,'uint8');
                imagesc(imgO);
            end
            time = time_calculator(tic_toc)
        end

        %detect blue
        if(bluePixelG >= blueG_min && bluePixelG <= blueG_max && ...
            bluePixelB >= blueB_min && bluePixelB <= blueB_max )
            start = tic;
            while(toc(start) < tempo_espera)
                imgO = getdata(vid,1,'uint8');
                imagesc(imgO);
            end
            time = time_calculator(tic_toc)
        end

        %detect orange
        if(orangePixelR >= orangeR_min && orangePixelR <= orangeR_max && ...
            orangePixelG >= orangeG_min && orangePixelG <= orangeG_max )
            start = tic;
            while(toc(start) < tempo_espera)
                imgO = getdata(vid,1,'uint8');
                imagesc(imgO);
            end
            time = time_calculator(tic_toc)
        end
        imagesc(imgO);
    end
end

function T2 = time_calculator(T1)
    D1 = 300;
    D2 = 250;

    V = T1/D1;
    T2 = D2/V;
end