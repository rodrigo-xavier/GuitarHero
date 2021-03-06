function [arduino, vid] = connect_devices()
    counter = 1;
    vid_message = [];
    baudrate = 115200;
    % baudrate = 9600;
    terminator = "CR/LF";    % 0 em ascii

    % TODO: implementar status() para verificar se o arduino está conectado
    
    COMX = serialportlist("available");
    arduino = serialport(COMX, baudrate);
    arduino.ByteOrder = "big-endian";
    configureTerminator(arduino, terminator);
    disp("Arduino: Porta " + COMX + " Sucesso!");

    % Tenta iniciar conexão com video nas 2 primeiras portas
    while(counter <= 2)
        try
            vid_message = [];
            vid = videoinput('winvideo', counter, 'I420_640x480');
            break;
        catch vid_message
            disp("Vid: Porta " + int2str(counter) + " Falhou!");
        end

        counter = counter + 1;
    end
    if isempty(vid_message)
        disp("Vid: Porta " + int2str(counter) + " Sucesso!");
    end
end