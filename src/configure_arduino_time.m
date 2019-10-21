function configure_arduino_time(arduino_board, time)
    time = uint16(round(time*1000,0));

    flush(arduino_board); % Limpa o buffer de entrada e saída do arduino

    write(arduino_board, time, 'uint16');

    if (readline(arduino_board) ~= string(time))
        error("Reenvie o código para o arduino.");
        delete(arduino_board);
    end

    msg = "OFFTIME: ";
    disp(msg + time);
end