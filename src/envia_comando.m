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
    
    command = uint16(bin2dec(comando));
    fwrite(galileo, command, 'uint16');
    
end