function configure_arduino(arduino, time)
    time = uint16(round(time*1000,0));

    flush(arduino); % Limpa o buffer de entrada e saída do arduino

    write(arduino, time, 'uint16');

    if (readline(arduino) ~= string(time))
        error("Reenvie o código para o arduino.");
        delete(arduino);
    end

    disp("OFFTIME: " + time);
end