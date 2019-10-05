function envia_comando(galileo, comando)
    % Recebe comando no formato '0000000000000000' (16 bits)
    %                           MSB             LSB
    %                          (BIT15)          (BIT0)
    % BIT0 => APERTO SIMPLES VERDE
    % BIT1 => APERTO SIMPLES VERMELHO
    % BIT2 => APERTO SIMPLES AMARELO
    % BIT3 => APERTO SIMPLES AZUL
    % BIT4 => APERTO SIMPLES LARANJADO
    % BIT5 => APERTO SEM SOLTAR VERDE
    % BIT6 => APERTO SEM SOLTAR VERMELHO
    % BIT7 => APERTO SEM SOLTAR AMARELO
    % BIT8 => APERTO SEM SOLTAR AZUL
    % BIT9 => APERTO SEM SOLTAR LARANJADO
    % BIT10 => SOLTA VERDE
    % BIT11 => SOLTA VERMELHO
    % BIT12 => SOLTA AMARELO
    % BIT13 => SOLTA AZUL
    % BIT14 => SOLTA LARANJADO
    % BIT15 => 0 (será utilizado para configurações)
    % disp('1');
    % pause(0.55);

    % asdf = '0000000000000001';
    % command = uint16(bin2dec(asdf));
    fwrite(galileo, '0', 'uint8');
    if (galileo.BytesAvailable > 0)
        galileo_output = fscanf(galileo,'%c',galileo.BytesAvailable)
    end
    
    % asdf = '0000000000000010';
    % command = uint16(bin2dec(asdf));
    % fwrite(galileo, command, 'uint16');
    % galileo_output = fscanf(galileo,'%c',12)
    % disp('2');
    % pause(0.2);
    
    % asdf = '0000000000000100';
    % command = uint16(bin2dec(asdf));
    % fwrite(galileo, command, 'uint16');
    % galileo_output = fscanf(galileo,'%c',12)
    % disp('3');
    % pause(0.2);

    % asdf = '0000000000001000';
    % command = uint16(bin2dec(asdf));
    % fwrite(galileo, command, 'uint16');
    % % galileo_output = fscanf(galileo,'%c',12)
    % disp('4');
    % pause(0.2);

    % asdf = '0000000000010000';
    % command = uint16(bin2dec(asdf));
    % fwrite(galileo, command, 'uint16');
    % % galileo_output = fscanf(galileo,'%c',12)
    % disp('5');
    % pause(0.2);
    
    % asdf = '0000000000100000';
    % command = uint16(bin2dec(asdf));
    % fwrite(galileo, command, 'uint16');
    % % galileo_output = fscanf(galileo,'%c',12)
    % disp('6');
    % pause(0.2);

    % asdf = '0000000001000000';
    % command = uint16(bin2dec(asdf));
    % fwrite(galileo, command, 'uint16');
    % % galileo_output = fscanf(galileo,'%c',12)
    % disp('7');
    % pause(0.2);

    % asdf = '0000000010000000';
    % command = uint16(bin2dec(asdf));
    % fwrite(galileo, command, 'uint16');
    % % galileo_output = fscanf(galileo,'%c',12)
    % disp('8');
    % pause(0.2);
end