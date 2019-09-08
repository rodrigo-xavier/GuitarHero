function configure_arduino_time(galileo, time)
    % Tempo deve ser enviado em segundos

    % Limpa o buffer
    if (galileo.BytesAvailable > 0)
        fscanf(galileo,'%c',galileo.BytesAvailable);
    end

    tmp = char(90);
    msg = "Tempo Simples: ";
    
    config = uint16(bin2dec('1000000000000000'));
    fwrite(galileo, config, 'uint16');
    out = '';
    while(true)
        fwrite(galileo, tmp, 'uint8');
        pause(0.5);
        if (galileo.BytesAvailable > 0)
            out = fscanf(galileo,'%c',galileo.BytesAvailable);
            if strcmp(out,'OK')
                break;
            end
            if strcmp(out, 'Z')
                error("Reenvie o código ao arduino.");
                fclose(galileo);
            end
        end
    end
    out = '';

    time_to_send = round(time_to_send*1000,0);
    while true
        % envia o tempo para o arduino 
        time_format = strcat('a', num2str(time_to_send), 'b');
        fprintf(galileo, "%s", time_format);
        pause(0.5);
        if (galileo.BytesAvailable > 0)
            out = fscanf(galileo,'%c',galileo.BytesAvailable);
            if(str2num(out)==time_to_send)
                disp(msg + out);
                break;
            end
        end
    end
end