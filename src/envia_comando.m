function envia_comando(arduino, command)
    command = uint16(bin2dec(command));
    write(arduino, command, 'uint16');

    % data = '';
    % if (arduino.NumBytesAvailable > 0)
    %     data = read(arduino, arduino.NumBytesAvailable, 'uint8');
    %     str = char(data);
    %     disp("str: ");
    %     disp(str);
    %     disp("command: ");
    %     disp(command);
    % end

end