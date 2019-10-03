function [galileo] = connect_devices()
    counter = 1;
    ME2 = [];
    ME = [];
    baudrate = 75;
    buffer_size = 10000;

    % TODO: implementar status() para verificar se o arduino está conectado
    
    % Tenta iniciar conexão com galileo nas 25 primeiras portas
    while(counter <= 25)
        COMX = strcat('COM', int2str(counter));

        try
            ME = [];
            % galileo = serial(COMX, 'galileo', baudrate);
            galileo = serial(COMX);
            % galileo.InputBufferSize = buffer_size;
            fopen(galileo);
            break;
        catch ME
            disp("Arduino: Porta " + COMX + " Falhou!");
        end

        counter = counter + 1;
    end
    
    if isempty(ME)
        disp("Arduino: Porta " + COMX + " Sucesso!");
    end
    counter = 1;

    % Tenta iniciar conexão com video nas 2 primeiras portas
    while(counter <= 2)
        try
            ME2 = [];
            vid = videoinput('winvideo', counter, 'I420_640x480');
            break;
        catch ME2
            disp("Vid: Porta " + int2str(counter) + " Falhou!");
        end

        counter = counter + 1;
    end
    if isempty(ME2)
        disp("Vid: Porta " + int2str(counter) + " Sucesso!");
    end
end