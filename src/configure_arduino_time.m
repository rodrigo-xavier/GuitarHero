function configure_arduino_time(arduino, time)
    % Tempo deve ser enviado em segundos

    % Limpa o buffer
    if (arduino.BytesAvailable > 0)
        fscanf(arduino,'%c',arduino.BytesAvailable);
    end
    
    config = uint16(bin2dec('1000000000000000'));
    fwrite(arduino, config, 'uint16');

    msg = "Tempo Simples: ";
    arduino_output = '';

    time = round(time*1000,0);
    time_format = strcat(num2str(time), 'z');

    fprintf(arduino, "%s", time_format);
    pause(1);

    if (arduino.BytesAvailable > 0)
        arduino_output = fscanf(arduino,'%c',arduino.BytesAvailable);

        if (str2num(arduino_output) == time)
            disp(msg + arduino_output);
            return;
        else
            error("Reenvie o código ao arduino.");
            fclose(arduino);
        end
    end
end