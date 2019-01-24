function [vid, galileo] = connect_devices()
    counter = 1;

    % Tenta iniciar conexão com galileo nas 20 primeiras portas
    while(counter <= 20)
        COMX = strcat('COM', int2str(counter));

        try
            galileo = serial(COMX);
            fopen(galileo);
            break;
        catch
            disp(strcat('Porta\t', COMX, ' Falhou'));
        end

        counter = counter + 1;
    end

    counter = 1;

    % Tenta iniciar conexão com video nas 2 primeiras portas
    while(counter <= 2)
        try
            vid = videoinput('winvideo', counter, 'I420_640x480');
            break;
        catch
            disp(strcat('Porta\t', COMX, ' Falhou'));
        end

        counter = counter + 1;
    end
end