function envia_comando(arduino, comando)
    
    command = uint16(bin2dec(comando));
    fwrite(arduino, command, 'uint16');
    
end