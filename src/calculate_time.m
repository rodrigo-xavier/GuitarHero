% Encerra conexão com galileo se estiver conectado
if exist('galileo','var') == true
    fclose(galileo);
end

% Encerra conexão com video se estiver conectado
if exist('vid','var') == true
    delete(vid);
end

[vid, galileo] = connect_devices();
configure_video(vid);
from_red_rastro(vid, galileo);

function from_one_red_note(vid, galileo)
        
    while true
        % get image from camera
        imgO = getdata(vid,1,'uint8');

        if (imgO(293,275,1) >= 175 && imgO(293,275,1) <= 255)
            tic;
        end
    
        if (imgO(412,248,1) >= 175 && imgO(412,248,1) <= 255)
            time = toc
            beep;
        end

        imagesc(imgO);

    end

end

function from_red_rastro(vid, galileo)

    while true
        % get image from camera
        imgO = getdata(vid,1,'uint8');

        if (imgO(281,278,1) >= 175 && imgO(281,278,1) <= 255)
            tic;
        end
    
        if (imgO(412,248,1) >= 175 && imgO(412,248,1) <= 255)
            time = toc
            beep;
        end

        imagesc(imgO);

    end

end