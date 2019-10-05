function configure_arduino_time(galileo, time)
    disp("Enviando tempo para o galileo");
    time = uint16(round(time*1000,0));

    % clrdevice(galileo); % % Limpa o buffer de entrada e de saída
    flushinput(galileo); % Limpa o buffer de entrada
    flushoutput(galileo); % Limpa o buffer de saída
    
    fwrite(galileo, '?', 'uint8');
    fwrite(galileo, 160, 'uint8');
end