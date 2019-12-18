function [arduino] = connect_arduino()
    baudrate = 115200;
    % baudrate = 9600;
    terminator = "CR/LF";
    
    COMX = serialportlist("available");
    arduino = serialport(COMX, baudrate);
    arduino.ByteOrder = "big-endian";
    configureTerminator(arduino, terminator);
    disp("Arduino: Porta " + COMX + " Sucesso!");
end