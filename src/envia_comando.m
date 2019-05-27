function envia_comando(arduino, comando)
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
    MSB = comando(1:8); %Most significant Byte
    LSB = comando(8:16);

    MSB_decimal = bin2dec(MSB);
    LSB_decimal = bin2dec(LSB);

    msg = [char(MSB_decimal) char(LSB_decimal)];

    fprintf(arduino, '%c', msg);
    
end