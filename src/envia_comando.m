function envia_comando(arduino, command)
    command = uint16(bin2dec(command));

    disp("command");
    disp(command);

    write(arduino, command, 'uint16');

    data = '';
    if (arduino.NumBytesAvailable > 0)
        str = char(read(arduino, arduino.NumBytesAvailable, 'uint8'));


        answer = false;
        try 
            split(str, 'B0100000063f694');
            answer = true;
        end
        if (answer)
            error("Arduino error");
        end


        disp(str);

    end

end