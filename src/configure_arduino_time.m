function configure_arduino_time(galileo, time)
    disp("Enviando tempo para o galileo");
    config = uint16(bin2dec('1000000000000000'));
    time = uint16(round(time*1000,0));

    % clrdevice(galileo); % % Limpa o buffer de entrada e de saída
    flushinput(galileo); % Limpa o buffer de entrada
    flushoutput(galileo); % Limpa o buffer de saída
    
    fwrite(galileo, config, 'uint16');
    fwrite(galileo, time, 'uint16');
end