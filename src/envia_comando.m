function envia_comando(arduino_board, comando)
    data = '';
    asdf = '0000000000000001';
    command = uint16(bin2dec(asdf));
    write(arduino_board, command, 'uint16');
    % data = readline(arduino_board)
    
    if (arduino_board.NumBytesAvailable > 0)
        data = read(arduino_board, arduino_board.NumBytesAvailable, 'uint8');
        str = char(data)
    end
    % configureCallback(arduino_board, "terminator", @print_string(arduino_board));

    pause(0.2);

    % data = read(arduino_board, 1, 'uint8')
    
end