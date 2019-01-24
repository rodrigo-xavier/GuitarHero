function [vid, galileo] = connect_devices()
    portx = 1;

    % Tenta iniciar conexão com galileo nas 20 primeiras portas
    while(portx <= 20)
        COMX = strcat('COM', int2str(portx));

        try
            galileo = serial(COMX);
            fopen(galileo);
            break;
        catch
            string = strcat('Porta\t', COMX, ' Falhou');
            disp(string)
        end

        portx = portx + 1;
    end

    portx = 1;

    % Tenta iniciar conexão com video nas 2 primeiras portas
    while(portx <= 2)
        try
            vid = videoinput('winvideo', portx, 'I420_640x480');
            break;
        catch
            string = strcat('Porta\tVID', int2str(portx), ' Falhou');
            disp(string)
        end

        portx = portx + 1;
    end
end