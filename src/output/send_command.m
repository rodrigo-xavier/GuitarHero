function send_command(arduino, command)
    command = uint16(bin2dec(command));
    write(arduino, command, 'uint16');

    data = '';
    if (arduino.NumBytesAvailable > 0)
        str = char(read(arduino, arduino.NumBytesAvailable, 'uint8'));
        disp(str);

        % data = read(arduino, arduino.NumBytesAvailable, 'uint8');
        % str = char(data);
        % disp("str: ");
        % disp(str);
    end

end